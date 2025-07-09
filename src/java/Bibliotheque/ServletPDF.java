package Bibliotheque;

import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ServletPDF extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null) {
            processRequest(request, response);
            return;
        }

        switch (action) {
            case "searchByIdAndDate":
                searchByIdPersAndDate(request, response);
                break;
            case "generatePDF":
                try {
                    generatePDF(request, response);
                } catch (DocumentException ex) {
                    redirectWithError(request, response, "/Components/GenererPDF/indexPDF.jsp", "erreur_generation_pdf");
                }
                break;
            default:
                redirectWithError(request, response, "/Components/GenererPDF/indexPDF.jsp", "action_invalide");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("generatePDF".equals(action)) {
            try {
                generatePDF(request, response);
            } catch (DocumentException ex) {
                redirectWithError(request, response, "/Components/GenererPDF/indexPDF.jsp", "erreur_generation_pdf");
            }
        } else {
            processRequest(request, response);
        }
    }
    
    private void generatePDF(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException, DocumentException {
        // Récupération et validation des paramètres
        String idpers = getTrimmedParameter(request, "idpers");
        String datepretStr = getTrimmedParameter(request, "datepret");

        if (idpers.isEmpty() || datepretStr.isEmpty()) {
            redirectWithError(request, response, "/Components/GenererPDF/indexPDF.jsp", "champs_recherche_vides");
            return;
        }

        try {
            // Conversion de la date
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date datepret = dateFormat.parse(datepretStr);

            // Récupération des données depuis la base
            Map<String, String> membre = null;
            List<Map<String, Object>> prets = new ArrayList<>();
            Date dateRetour = null;

            try (Connection conn = DB_Connexion.getConnection()) {
                String sql = "SELECT m.nom, m.age, m.sexe, m.contact, "
                        + "l.idlivre, l.designation as titre_livre, "
                        + "MIN(p.dateretour) as dateretour, "
                        + "COUNT(*) as total "
                        + "FROM preter p "
                        + "JOIN membre m ON p.idpers = m.idpers "
                        + "JOIN livre l ON p.idlivre = l.idlivre "
                        + "WHERE p.idpers = ? AND DATE(p.datepret) = ? "
                        + "GROUP BY m.nom, m.age, m.sexe, m.contact, l.idlivre, l.designation "
                        + "ORDER BY l.designation";

                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, idpers);
                    stmt.setDate(2, new java.sql.Date(datepret.getTime()));

                    try (ResultSet rs = stmt.executeQuery()) {
                        boolean firstRow = true;
                        while (rs.next()) {
                            if (firstRow) {
                                membre = new HashMap<>();
                                membre.put("nom", rs.getString("nom") != null ? rs.getString("nom") : "Non spécifié");
                                membre.put("age", String.valueOf(rs.getInt("age")));
                                membre.put("sexe", rs.getString("sexe") != null ? rs.getString("sexe") : "Non spécifié");
                                membre.put("contact", rs.getString("contact") != null ? rs.getString("contact") : "Non spécifié");
                                firstRow = false;
                            }

                            Map<String, Object> pret = new HashMap<>();
                            pret.put("idlivre", rs.getString("idlivre") != null ? rs.getString("idlivre") : "N/A");
                            pret.put("titre_livre", rs.getString("titre_livre") != null ? rs.getString("titre_livre") : "Titre inconnu");
                            pret.put("total", rs.getInt("total"));

                            if (dateRetour == null) {
                                dateRetour = rs.getDate("dateretour");
                            }

                            prets.add(pret);
                        }
                    }
                }
            } catch (SQLException e) {
                handleSQLException(e, request, response, "/Components/GenererPDF/indexPDF.jsp", null);
                return;
            }

            if (membre == null || prets.isEmpty()) {
                redirectWithError(request, response, "/Components/GenererPDF/indexPDF.jsp", "aucune_donnee_trouvee");
                return;
            }

            // Calcul de la date de retour si non trouvée
            if (dateRetour == null) {
                Calendar cal = Calendar.getInstance();
                cal.setTime(datepret);
                cal.add(Calendar.DAY_OF_MONTH, 14);
                dateRetour = cal.getTime();
            }

            // Formatage des dates avec gestion des erreurs
            SimpleDateFormat displayFormat = new SimpleDateFormat("dd MMMM yyyy", java.util.Locale.FRENCH);
            String datePretFormatted;
            String dateRetourFormatted;

            try {
                datePretFormatted = displayFormat.format(datepret);
            } catch (Exception e) {
                datePretFormatted = "Date inconnue";
            }

            try {
                dateRetourFormatted = displayFormat.format(dateRetour);
            } catch (Exception e) {
                dateRetourFormatted = "Date inconnue";
            }

            // Création du document PDF
            Document document = new Document();
            ByteArrayOutputStream baos = new ByteArrayOutputStream();

            try {
                PdfWriter.getInstance(document, baos);
                document.open();

                // Configuration des polices
                Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18);
                Font headerFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12);
                Font normalFont = FontFactory.getFont(FontFactory.HELVETICA, 12);

                // Titre du document
                Paragraph title = new Paragraph("BIBLIOTHÈQUE FIWRE", titleFont);
                title.setAlignment(Element.ALIGN_CENTER);
                document.add(title);
                document.add(Chunk.NEWLINE);

                // Section Info Membre
                Paragraph memberTitle = new Paragraph("Info Membre :", headerFont);
                document.add(memberTitle);

                document.add(new Paragraph(membre.get("nom"), normalFont));
                document.add(new Paragraph(membre.get("age") + " ans", normalFont));
                document.add(new Paragraph(membre.get("sexe"), normalFont));

                Paragraph contact = new Paragraph("Contact : " + membre.get("contact"), normalFont);
                contact.setSpacingAfter(10f);
                document.add(contact);

                // Tableau des livres
                PdfPTable table = new PdfPTable(3);
                table.setWidthPercentage(100);
                table.setWidths(new float[]{2, 5, 2});

                // En-têtes du tableau
                PdfPCell cell;

                cell = new PdfPCell(new Phrase("Code livre", headerFont));
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell);

                cell = new PdfPCell(new Phrase("Intitulé", headerFont));
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell);

                cell = new PdfPCell(new Phrase("Nombre prêté", headerFont));
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell);

                // Remplissage du tableau
                for (Map<String, Object> pret : prets) {
                    cell = new PdfPCell(new Phrase(pret.get("idlivre").toString(), normalFont));
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                    table.addCell(cell);

                    cell = new PdfPCell(new Phrase(pret.get("titre_livre").toString(), normalFont));
                    cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                    table.addCell(cell);

                    cell = new PdfPCell(new Phrase(pret.get("total").toString(), normalFont));
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                    table.addCell(cell);
                }

                document.add(table);
                document.add(Chunk.NEWLINE);

                // Section Dates
                Paragraph datePret = new Paragraph("Prêté le : " + datePretFormatted, normalFont);
                document.add(datePret);

                Paragraph dateRetourPara = new Paragraph("Doit être rendu le : " + dateRetourFormatted, normalFont);
                dateRetourPara.setSpacingAfter(10f);
                document.add(dateRetourPara);

            } finally {
                if (document != null && document.isOpen()) {
                    document.close();
                }
            }

            // Envoi du PDF au navigateur
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=\"fiche_pret.pdf\"");
            response.setContentLength(baos.size());

            try (OutputStream os = response.getOutputStream()) {
                baos.writeTo(os);
            }

        } catch (ParseException e) {
            redirectWithError(request, response, "/Components/GenererPDF/indexPDF.jsp", "format_date_invalide");
        } catch (Exception e) {
            redirectWithError(request, response, "/Components/GenererPDF/indexPDF.jsp", "erreur_generation_pdf");
        }
    }

    private void searchByIdPersAndDate(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        String idpers = getTrimmedParameter(request, "idpers");
        String datepretStr = getTrimmedParameter(request, "datepret");

        if (idpers.isEmpty() || datepretStr.isEmpty()) {
            redirectWithError(request, response, "/Components/GenererPDF/indexPDF.jsp", "champs_recherche_vides");
            return;
        }

        try {
            // Convertir la date en objet Date
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date datepret = dateFormat.parse(datepretStr);

            try (Connection conn = DB_Connexion.getConnection()) {
                String sql = "SELECT m.nom, m.age, m.sexe, m.contact, "
                        + "l.idlivre, l.designation as titre_livre, "
                        + "MIN(p.dateretour) as dateretour, "
                        + "COUNT(*) as total "
                        + "FROM preter p "
                        + "JOIN membre m ON p.idpers = m.idpers "
                        + "JOIN livre l ON p.idlivre = l.idlivre "
                        + "WHERE p.idpers = ? AND DATE(p.datepret) = ? "
                        + "GROUP BY m.nom, m.age, m.sexe, m.contact, l.idlivre, l.designation "
                        + "ORDER BY l.designation";

                List<Map<String, Object>> prets = new ArrayList<>();
                Map<String, String> membre = null;
                Date dateRetour = null;

                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, idpers);
                    stmt.setDate(2, new java.sql.Date(datepret.getTime()));

                    try (ResultSet rs = stmt.executeQuery()) {
                        boolean firstRow = true;
                        while (rs.next()) {
                            if (firstRow) {
                                membre = new HashMap<>();
                                membre.put("nom", rs.getString("nom"));
                                membre.put("age", String.valueOf(rs.getInt("age")));
                                membre.put("sexe", rs.getString("sexe"));
                                membre.put("contact", rs.getString("contact"));
                                firstRow = false;
                            }

                            Map<String, Object> pret = new HashMap<>();
                            pret.put("idlivre", rs.getString("idlivre"));
                            pret.put("titre_livre", rs.getString("titre_livre"));
                            pret.put("total", rs.getInt("total"));

                            if (dateRetour == null) {
                                dateRetour = rs.getDate("dateretour");
                            }

                            prets.add(pret);
                        }
                    }
                }

                if (membre == null) {
                    redirectWithError(request, response, "/Components/GenererPDF/indexPDF.jsp", "membre_non_trouve");
                    return;
                }

                if (prets.isEmpty()) {
                    redirectWithError(request, response, "/Components/GenererPDF/indexPDF.jsp", "aucun_pret_trouve");
                    return;
                }

                // Calcul de la date de retour si non trouvée
                if (dateRetour == null) {
                    Calendar cal = Calendar.getInstance();
                    cal.setTime(datepret);
                    cal.add(Calendar.DAY_OF_MONTH, 14);
                    dateRetour = cal.getTime();
                }

                // Formatage des dates pour l'affichage
                SimpleDateFormat displayFormat = new SimpleDateFormat("dd MMMM yyyy");
                String datePretFormatted = displayFormat.format(datepret);
                String dateRetourFormatted = displayFormat.format(dateRetour);

                // Passer les données à la JSP
                request.setAttribute("membre", membre);
                request.setAttribute("prets", prets);
                request.setAttribute("datePret", datepret);
                request.setAttribute("dateRetour", dateRetour);
                request.setAttribute("datePretFormatted", datePretFormatted);
                request.setAttribute("dateRetourFormatted", dateRetourFormatted);

                request.getRequestDispatcher("/Components/GenererPDF/indexPDF.jsp").forward(request, response);

            } catch (SQLException e) {
                handleSQLException(e, request, response, "/Components/GenererPDF/indexPDF.jsp", null);
            }
        } catch (ParseException e) {
            redirectWithError(request, response, "/Components/GenererPDF/indexPDF.jsp", "format_date_invalide");
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ServletPDF</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ServletPDF at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet pour la génération de PDF";
    }

    private void handleSQLException(SQLException e, HttpServletRequest request, 
            HttpServletResponse response, String path, String additionalParams) throws IOException {
        e.printStackTrace();
        String errorMessage = "erreur_bdd";
        if (e.getMessage().contains("constraint")) {
            if (e.getMessage().contains("foreign key")) {
                errorMessage = "pret_lie_a_autre_table";
            } else if (e.getMessage().contains("primary key") || e.getMessage().contains("duplicate")) {
                errorMessage = "id_existe_deja";
            }
        }
        redirectWithError(request, response, path, errorMessage, additionalParams);
    }

    private void redirectWithError(HttpServletRequest request, HttpServletResponse response, 
            String path, String error) throws IOException {
        redirectWithError(request, response, path, error, null);
    }

    private void redirectWithError(HttpServletRequest request, HttpServletResponse response, 
            String path, String error, String additionalParams) throws IOException {
        String params = "error=" + error;
        if (additionalParams != null && !additionalParams.isEmpty()) {
            params += "&" + additionalParams;
        }
        response.sendRedirect(request.getContextPath() + path + "?" + params);
    }

    private String getTrimmedParameter(HttpServletRequest request, String paramName) {
        String value = request.getParameter(paramName);
        return value != null ? value.trim() : "";
    }
}