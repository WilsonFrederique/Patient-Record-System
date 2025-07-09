package Bibliotheque;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.ByteArrayOutputStream;
import java.io.OutputStream;

@WebServlet(name = "ServletHistoriques", urlPatterns = {"/ServletHistoriques"})
public class ServletHistoriques extends HttpServlet {

    private static final SimpleDateFormat dateTimeFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
    private static final Font titleFont = new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD);
    private static final Font subTitleFont = new Font(Font.FontFamily.HELVETICA, 14, Font.BOLD);
    private static final Font normalFont = new Font(Font.FontFamily.HELVETICA, 12);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null) {
            request.getRequestDispatcher("/Components/Historiques/indexHistoriques.jsp").forward(request, response);
            return;
        }

        switch (action) {
            case "search":
                searchHistoriquePatient(request, response);
                break;
            default:
                request.getRequestDispatcher("/Components/Historiques/indexHistoriques.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("downloadPDF".equals(action)) {
            generatePDF(request, response);
        } else {
            doGet(request, response);
        }
    }

    private void searchHistoriquePatient(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String cinPatient = request.getParameter("cinPatient");

        if (cinPatient == null || cinPatient.trim().isEmpty()) {
            request.setAttribute("error", "Veuillez entrer un CIN patient");
            request.getRequestDispatcher("/Components/Historiques/indexHistoriques.jsp").forward(request, response);
            return;
        }

        try (Connection conn = DB_Connexion.getConnection()) {
            if (conn == null) {
                request.setAttribute("error", "Erreur de connexion à la base de données");
                request.getRequestDispatcher("/Components/Historiques/indexHistoriques.jsp").forward(request, response);
                return;
            }

            if (!patientExists(conn, cinPatient)) {
                request.setAttribute("error", "Patient non trouvé");
                request.getRequestDispatcher("/Components/Historiques/indexHistoriques.jsp").forward(request, response);
                return;
            }

            Map<String, String> patientInfo = getPatientInfo(conn, cinPatient);
            
            if (patientInfo == null) {
                request.setAttribute("error", "Erreur lors de la récupération des informations du patient");
                request.getRequestDispatcher("/Components/Historiques/indexHistoriques.jsp").forward(request, response);
                return;
            }
            
            List<Map<String, String>> rdvs = getRendezVousPatient(conn, cinPatient);
            List<Map<String, String>> consultations = getConsultationsPatient(conn, cinPatient);
            List<Map<String, String>> examens = getExamensPatient(conn, cinPatient);

            request.setAttribute("patientInfo", patientInfo);
            request.setAttribute("rdvs", rdvs);
            request.setAttribute("consultations", consultations);
            request.setAttribute("examens", examens);
            request.setAttribute("cinPatient", cinPatient);

            request.getRequestDispatcher("/Components/Historiques/indexHistoriques.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur lors de la recherche: " + e.getMessage());
            request.getRequestDispatcher("/Components/Historiques/indexHistoriques.jsp").forward(request, response);
        }
    }

    private void generatePDF(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String cinPatient = request.getParameter("cinPatient");
        
        try (Connection conn = DB_Connexion.getConnection()) {
            if (conn == null) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur de connexion à la base de données");
                return;
            }

            Map<String, String> patientInfo = getPatientInfo(conn, cinPatient);
            List<Map<String, String>> rdvs = getRendezVousPatient(conn, cinPatient);
            List<Map<String, String>> consultations = getConsultationsPatient(conn, cinPatient);
            List<Map<String, String>> examens = getExamensPatient(conn, cinPatient);

            Document document = new Document();
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            PdfWriter.getInstance(document, baos);
            
            document.open();
            
            // Titre
            Paragraph title = new Paragraph("HISTORIQUE MÉDICAL", titleFont);
            title.setAlignment(Element.ALIGN_CENTER);
            title.setSpacingAfter(20);
            document.add(title);
            
            // Informations patient
            Paragraph patientTitle = new Paragraph("INFORMATIONS DU PATIENT", subTitleFont);
            patientTitle.setSpacingAfter(10);
            document.add(patientTitle);
            
            PdfPTable patientTable = new PdfPTable(2);
            patientTable.setWidthPercentage(100);
            patientTable.setSpacingBefore(10);
            patientTable.setSpacingAfter(20);
            
            addPatientInfoToTable(patientTable, "CIN", patientInfo.get("cinPatient"));
            addPatientInfoToTable(patientTable, "Nom", patientInfo.get("nom") + " " + patientInfo.get("prenom"));
            addPatientInfoToTable(patientTable, "Sexe", patientInfo.get("sexe"));
            addPatientInfoToTable(patientTable, "Âge", patientInfo.get("age") + " ans");
            addPatientInfoToTable(patientTable, "Adresse", patientInfo.get("adresse"));
            addPatientInfoToTable(patientTable, "Téléphone", patientInfo.get("telephone"));
            addPatientInfoToTable(patientTable, "Email", patientInfo.get("email"));
            
            document.add(patientTable);
            
            // Rendez-vous
            addSectionToPDF(document, "RENDEZ-VOUS", rdvs, 
                new String[]{"ID", "Date/Heure", "Praticien", "Statut"}, 
                new float[]{1, 2, 3, 2});
            
            // Consultations
            addSectionToPDF(document, "CONSULTATIONS", consultations, 
                new String[]{"ID", "Date", "Compte rendu"}, 
                new float[]{1, 2, 5});
            
            // Examens
            addSectionToPDF(document, "EXAMENS", examens, 
                new String[]{"ID", "Type", "Date réalisation", "Statut"}, 
                new float[]{1, 3, 2, 2});
            
            document.close();
            
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=historique_medical_" + cinPatient + ".pdf");
            response.setContentLength(baos.size());
            
            OutputStream os = response.getOutputStream();
            baos.writeTo(os);
            os.flush();
            os.close();
            
        } catch (SQLException | DocumentException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur lors de la génération du PDF: " + e.getMessage());
        }
    }

    private void addPatientInfoToTable(PdfPTable table, String label, String value) {
        PdfPCell cellLabel = new PdfPCell(new Phrase(label, normalFont));
        PdfPCell cellValue = new PdfPCell(new Phrase(value != null ? value : "N/A", normalFont));
        
        table.addCell(cellLabel);
        table.addCell(cellValue);
    }

    private void addSectionToPDF(Document document, String title, List<Map<String, String>> data, 
            String[] headers, float[] columnWidths) throws DocumentException {
        
        if (data == null || data.isEmpty()) {
            Paragraph noData = new Paragraph("Aucun " + title.toLowerCase() + " trouvé", normalFont);
            noData.setSpacingAfter(20);
            document.add(noData);
            return;
        }
        
        Paragraph sectionTitle = new Paragraph(title, subTitleFont);
        sectionTitle.setSpacingBefore(15);
        sectionTitle.setSpacingAfter(10);
        document.add(sectionTitle);
        
        PdfPTable table = new PdfPTable(columnWidths);
        table.setWidthPercentage(100);
        table.setSpacingBefore(10);
        table.setSpacingAfter(20);
        
        // En-têtes
        for (String header : headers) {
            PdfPCell cell = new PdfPCell(new Phrase(header, normalFont));
            cell.setBackgroundColor(BaseColor.LIGHT_GRAY);
            table.addCell(cell);
        }
        
        // Données
        for (Map<String, String> row : data) {
            if (title.equals("RENDEZ-VOUS")) {
                table.addCell(new Phrase(row.get("idRdv"), normalFont));
                table.addCell(new Phrase(row.get("dateHeure"), normalFont));
                table.addCell(new Phrase(row.get("praticien"), normalFont));
                table.addCell(new Phrase(row.get("statut"), normalFont));
            } else if (title.equals("CONSULTATIONS")) {
                table.addCell(new Phrase(row.get("idConsult"), normalFont));
                table.addCell(new Phrase(row.get("dateConsult"), normalFont));
                
                String compteRendu = row.get("compteRendu");
                if (compteRendu != null && compteRendu.length() > 100) {
                    compteRendu = compteRendu.substring(0, 100) + "...";
                }
                table.addCell(new Phrase(compteRendu != null ? compteRendu : "N/A", normalFont));
            } else if (title.equals("EXAMENS")) {
                table.addCell(new Phrase(row.get("idExamen"), normalFont));
                table.addCell(new Phrase(row.get("typeExamen"), normalFont));
                table.addCell(new Phrase(row.get("dateRealisation"), normalFont));
                table.addCell(new Phrase(row.get("statut"), normalFont));
            }
        }
        
        document.add(table);
    }

    private boolean patientExists(Connection conn, String cinPatient) throws SQLException {
        String sql = "SELECT 1 FROM patients WHERE cinPatient = ? LIMIT 1";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, cinPatient);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        }
    }

    private Map<String, String> getPatientInfo(Connection conn, String cinPatient) throws SQLException {
        String sql = "SELECT cinPatient, nom, prenom, sexe, age, telephone, adresse, email FROM patients WHERE cinPatient = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, cinPatient);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Map<String, String> patient = new HashMap<>();
                    patient.put("cinPatient", rs.getString("cinPatient"));
                    patient.put("nom", rs.getString("nom"));
                    patient.put("prenom", rs.getString("prenom"));
                    patient.put("sexe", rs.getString("sexe"));
                    patient.put("age", String.valueOf(rs.getInt("age")));
                    patient.put("telephone", rs.getString("telephone"));
                    patient.put("adresse", rs.getString("adresse"));
                    patient.put("email", rs.getString("email"));
                    return patient;
                }
            }
        }
        return null;
    }

    private List<Map<String, String>> getRendezVousPatient(Connection conn, String cinPatient) throws SQLException {
        List<Map<String, String>> rdvs = new ArrayList<>();
        String sql = "SELECT r.idRdv, r.dateHeure, r.statut, p.nom AS nomPraticien, p.prenom AS prenomPraticien " +
                     "FROM rendezvous r " +
                     "JOIN praticiens p ON r.cinPraticien = p.cinPraticien " +
                     "WHERE r.cinPatient = ? ORDER BY r.dateHeure DESC";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, cinPatient);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Map<String, String> rdv = new HashMap<>();
                    rdv.put("idRdv", rs.getString("idRdv"));
                    rdv.put("dateHeure", dateTimeFormat.format(rs.getTimestamp("dateHeure")));
                    rdv.put("praticien", rs.getString("prenomPraticien") + " " + rs.getString("nomPraticien"));
                    rdv.put("statut", rs.getString("statut"));
                    rdvs.add(rdv);
                }
            }
        }
        return rdvs;
    }

    private List<Map<String, String>> getConsultationsPatient(Connection conn, String cinPatient) throws SQLException {
        List<Map<String, String>> consultations = new ArrayList<>();
        String sql = "SELECT c.idConsult, c.dateConsult, c.compteRendu " +
                     "FROM consultations c " +
                     "JOIN rendezvous r ON c.idRdv = r.idRdv " +
                     "WHERE r.cinPatient = ? ORDER BY c.dateConsult DESC";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, cinPatient);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Map<String, String> consult = new HashMap<>();
                    consult.put("idConsult", rs.getString("idConsult"));
                    consult.put("dateConsult", dateTimeFormat.format(rs.getTimestamp("dateConsult")));
                    consult.put("compteRendu", rs.getString("compteRendu"));
                    consultations.add(consult);
                }
            }
        }
        return consultations;
    }

    private List<Map<String, String>> getExamensPatient(Connection conn, String cinPatient) throws SQLException {
        List<Map<String, String>> examens = new ArrayList<>();
        String sql = "SELECT e.idExamen, e.typeExamen, e.dateRealisation, e.statut " +
                     "FROM examens e " +
                     "JOIN prescriptions p ON e.idPrescrire = p.idPrescrire " +
                     "JOIN consultations c ON p.idConsult = c.idConsult " +
                     "JOIN rendezvous r ON c.idRdv = r.idRdv " +
                     "WHERE r.cinPatient = ? ORDER BY e.dateRealisation DESC";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, cinPatient);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Map<String, String> examen = new HashMap<>();
                    examen.put("idExamen", rs.getString("idExamen"));
                    examen.put("typeExamen", rs.getString("typeExamen"));
                    examen.put("dateRealisation", rs.getTimestamp("dateRealisation") != null ? 
                              dateTimeFormat.format(rs.getTimestamp("dateRealisation")) : "N/A");
                    examen.put("statut", rs.getString("statut"));
                    examens.add(examen);
                }
            }
        }
        return examens;
    }
}