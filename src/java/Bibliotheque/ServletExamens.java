package Bibliotheque;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet(name = "ServletExamens", urlPatterns = {"/ServletExamens"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,    // 1MB
    maxFileSize = 1024 * 1024 * 10,     // 10MB
    maxRequestSize = 1024 * 1024 * 50   // 50MB
)
public class ServletExamens extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("delete".equals(action)) {
            deleteExamen(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/Components/Examens/indexExamens.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        
        if (action == null) {
            request.setAttribute("error", "Action non spécifiée");
            request.getRequestDispatcher("/Components/Examens/FrmExamens.jsp").forward(request, response);
            return;
        }

        try {
            switch (action) {
                case "update":
                    updateExamen(request, response);
                    break;
                case "insert":
                    insertExamen(request, response);
                    break;
                default:
                    request.setAttribute("error", "Action invalide");
                    request.getRequestDispatcher("/Components/Examens/FrmExamens.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur système: " + e.getMessage());
            request.getRequestDispatcher("/Components/Examens/FrmExamens.jsp").forward(request, response);
        }
    }

    private void insertExamen(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        String idPrescrire = request.getParameter("idPrescrire");
        String typeExamen = request.getParameter("typeExamen");
        String dateRealisationStr = request.getParameter("dateRealisation");
        String statut = request.getParameter("statut");
        String resultat = request.getParameter("resultat");
        String laboratoire = request.getParameter("laboratoire");
        Part imagePart = request.getPart("image");

        // Validation des champs obligatoires
        if (idPrescrire == null || idPrescrire.trim().isEmpty() ||
            typeExamen == null || typeExamen.trim().isEmpty() ||
            statut == null || statut.trim().isEmpty()) {
            
            request.setAttribute("error", "Tous les champs obligatoires doivent être remplis");
            forwardWithParams(request, response, false, null, idPrescrire, typeExamen, dateRealisationStr, statut, resultat, laboratoire, false);
            return;
        }

        // Validation spécifique pour le statut "réalisé"
        if ("réalisé".equals(statut) && (dateRealisationStr == null || dateRealisationStr.trim().isEmpty())) {
            request.setAttribute("error", "La date de réalisation est obligatoire pour un examen réalisé");
            forwardWithParams(request, response, false, null, idPrescrire, typeExamen, dateRealisationStr, statut, resultat, laboratoire, false);
            return;
        }

        Connection conn = null;
        try {
            conn = DB_Connexion.getConnection();
            if (conn == null) {
                request.setAttribute("error", "Erreur de connexion à la base de données");
                forwardWithParams(request, response, false, null, idPrescrire, typeExamen, dateRealisationStr, statut, resultat, laboratoire, false);
                return;
            }

            // Vérification que la prescription existe
            if (!isPrescriptionExists(conn, idPrescrire)) {
                request.setAttribute("error", "La prescription spécifiée n'existe pas");
                forwardWithParams(request, response, false, null, idPrescrire, typeExamen, dateRealisationStr, statut, resultat, laboratoire, false);
                return;
            }

            // Conversion de la date
            Timestamp dateRealisation = null;
            if (dateRealisationStr != null && !dateRealisationStr.trim().isEmpty()) {
                try {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                    Date date = sdf.parse(dateRealisationStr);
                    
                    // Validation que la date n'est pas dans le futur
                    if (date.after(new Date())) {
                        request.setAttribute("error", "La date de réalisation ne peut pas être dans le futur");
                        forwardWithParams(request, response, false, null, idPrescrire, typeExamen, dateRealisationStr, statut, resultat, laboratoire, false);
                        return;
                    }
                    
                    dateRealisation = new Timestamp(date.getTime());
                } catch (Exception e) {
                    request.setAttribute("error", "Format de date invalide");
                    forwardWithParams(request, response, false, null, idPrescrire, typeExamen, dateRealisationStr, statut, resultat, laboratoire, false);
                    return;
                }
            }

            // Insertion de l'examen
            String sql = "INSERT INTO examens (idPrescrire, typeExamen, dateRealisation, statut, resultat, laboratoire, image) VALUES (?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, Integer.parseInt(idPrescrire));
                stmt.setString(2, typeExamen);
                
                if (dateRealisation != null) {
                    stmt.setTimestamp(3, dateRealisation);
                } else {
                    stmt.setNull(3, java.sql.Types.TIMESTAMP);
                }
                
                stmt.setString(4, statut);
                stmt.setString(5, emptyToNull(resultat));
                stmt.setString(6, emptyToNull(laboratoire));
                
                // Gestion de l'image
                if (imagePart != null && imagePart.getSize() > 0) {
                    try (InputStream imageStream = imagePart.getInputStream()) {
                        stmt.setBinaryStream(7, imageStream, (int) imagePart.getSize());
                    }
                } else {
                    stmt.setNull(7, java.sql.Types.BLOB);
                }

                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    request.setAttribute("success", "Examen ajouté avec succès");
                    response.sendRedirect(request.getContextPath() + "/Components/Examens/indexExamens.jsp");
                } else {
                    request.setAttribute("error", "Échec de l'ajout de l'examen");
                    forwardWithParams(request, response, false, null, idPrescrire, typeExamen, dateRealisationStr, statut, resultat, laboratoire, false);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur système: " + e.getMessage());
            forwardWithParams(request, response, false, null, idPrescrire, typeExamen, dateRealisationStr, statut, resultat, laboratoire, false);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    private void updateExamen(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        String idExamen = request.getParameter("idExamen");
        String idPrescrire = request.getParameter("idPrescrire");
        String typeExamen = request.getParameter("typeExamen");
        String dateRealisationStr = request.getParameter("dateRealisation");
        String statut = request.getParameter("statut");
        String resultat = request.getParameter("resultat");
        String laboratoire = request.getParameter("laboratoire");
        Part imagePart = request.getPart("image");

        // Validation des champs obligatoires
        if (idExamen == null || idExamen.trim().isEmpty() ||
            idPrescrire == null || idPrescrire.trim().isEmpty() ||
            typeExamen == null || typeExamen.trim().isEmpty() ||
            statut == null || statut.trim().isEmpty()) {
            
            request.setAttribute("error", "Tous les champs obligatoires doivent être remplis");
            forwardWithParams(request, response, true, idExamen, idPrescrire, typeExamen, dateRealisationStr, statut, resultat, laboratoire, false);
            return;
        }

        // Validation spécifique pour le statut "réalisé"
        if ("réalisé".equals(statut) && (dateRealisationStr == null || dateRealisationStr.trim().isEmpty())) {
            request.setAttribute("error", "La date de réalisation est obligatoire pour un examen réalisé");
            forwardWithParams(request, response, true, idExamen, idPrescrire, typeExamen, dateRealisationStr, statut, resultat, laboratoire, false);
            return;
        }

        Connection conn = null;
        try {
            conn = DB_Connexion.getConnection();
            if (conn == null) {
                request.setAttribute("error", "Erreur de connexion à la base de données");
                forwardWithParams(request, response, true, idExamen, idPrescrire, typeExamen, dateRealisationStr, statut, resultat, laboratoire, false);
                return;
            }

            // Vérification que l'examen existe
            if (!isExamenExists(conn, idExamen)) {
                request.setAttribute("error", "L'examen spécifié n'existe pas");
                forwardWithParams(request, response, true, idExamen, idPrescrire, typeExamen, dateRealisationStr, statut, resultat, laboratoire, false);
                return;
            }

            // Vérification que la prescription existe
            if (!isPrescriptionExists(conn, idPrescrire)) {
                request.setAttribute("error", "La prescription spécifiée n'existe pas");
                forwardWithParams(request, response, true, idExamen, idPrescrire, typeExamen, dateRealisationStr, statut, resultat, laboratoire, false);
                return;
            }

            // Conversion de la date
            Timestamp dateRealisation = null;
            if (dateRealisationStr != null && !dateRealisationStr.trim().isEmpty()) {
                try {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                    Date date = sdf.parse(dateRealisationStr);
                    
                    // Validation que la date n'est pas dans le futur
                    if (date.after(new Date())) {
                        request.setAttribute("error", "La date de réalisation ne peut pas être dans le futur");
                        forwardWithParams(request, response, true, idExamen, idPrescrire, typeExamen, dateRealisationStr, statut, resultat, laboratoire, false);
                        return;
                    }
                    
                    dateRealisation = new Timestamp(date.getTime());
                } catch (Exception e) {
                    request.setAttribute("error", "Format de date invalide");
                    forwardWithParams(request, response, true, idExamen, idPrescrire, typeExamen, dateRealisationStr, statut, resultat, laboratoire, false);
                    return;
                }
            }

            // Mise à jour de l'examen
            String sql;
            boolean hasNewImage = imagePart != null && imagePart.getSize() > 0;
            
            if (hasNewImage) {
                sql = "UPDATE examens SET idPrescrire=?, typeExamen=?, dateRealisation=?, statut=?, resultat=?, laboratoire=?, image=? WHERE idExamen=?";
            } else {
                sql = "UPDATE examens SET idPrescrire=?, typeExamen=?, dateRealisation=?, statut=?, resultat=?, laboratoire=? WHERE idExamen=?";
            }
            
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                int paramIndex = 1;
                stmt.setInt(paramIndex++, Integer.parseInt(idPrescrire));
                stmt.setString(paramIndex++, typeExamen);
                
                if (dateRealisation != null) {
                    stmt.setTimestamp(paramIndex++, dateRealisation);
                } else {
                    stmt.setNull(paramIndex++, java.sql.Types.TIMESTAMP);
                }
                
                stmt.setString(paramIndex++, statut);
                stmt.setString(paramIndex++, emptyToNull(resultat));
                stmt.setString(paramIndex++, emptyToNull(laboratoire));
                
                // Si une nouvelle image est fournie
                if (hasNewImage) {
                    try (InputStream imageStream = imagePart.getInputStream()) {
                        stmt.setBinaryStream(paramIndex++, imageStream, (int) imagePart.getSize());
                    }
                }
                
                stmt.setInt(paramIndex++, Integer.parseInt(idExamen));

                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    request.setAttribute("success", "Examen modifié avec succès");
                    response.sendRedirect(request.getContextPath() + "/Components/Examens/indexExamens.jsp");
                } else {
                    request.setAttribute("error", "Échec de la modification de l'examen");
                    forwardWithParams(request, response, true, idExamen, idPrescrire, typeExamen, dateRealisationStr, statut, resultat, laboratoire, false);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur système: " + e.getMessage());
            forwardWithParams(request, response, true, idExamen, idPrescrire, typeExamen, dateRealisationStr, statut, resultat, laboratoire, false);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    private void deleteExamen(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idExamen = request.getParameter("idExamen");
        
        if (idExamen == null || idExamen.trim().isEmpty()) {
            request.setAttribute("error", "ID examen non spécifié");
            request.getRequestDispatcher("/Components/Examens/indexExamens.jsp").forward(request, response);
            return;
        }

        Connection conn = null;
        try {
            conn = DB_Connexion.getConnection();
            if (conn == null) {
                request.setAttribute("error", "Erreur de connexion à la base de données");
                request.getRequestDispatcher("/Components/Examens/indexExamens.jsp").forward(request, response);
                return;
            }

            // Vérifier si l'examen existe avant suppression
            if (!isExamenExists(conn, idExamen)) {
                request.setAttribute("error", "L'examen spécifié n'existe pas");
                request.getRequestDispatcher("/Components/Examens/indexExamens.jsp").forward(request, response);
                return;
            }

            // Supprimer l'examen
            String sqlDelete = "DELETE FROM examens WHERE idExamen = ?";
            try (PreparedStatement stmtDelete = conn.prepareStatement(sqlDelete)) {
                stmtDelete.setInt(1, Integer.parseInt(idExamen));
                int rowsAffected = stmtDelete.executeUpdate();
                
                if (rowsAffected > 0) {
                    request.setAttribute("success", "Examen supprimé avec succès");
                } else {
                    request.setAttribute("error", "Échec de la suppression de l'examen");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur système: " + e.getMessage());
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        
        request.getRequestDispatcher("/Components/Examens/indexExamens.jsp").forward(request, response);
    }

    // Méthodes utilitaires
    private boolean isExamenExists(Connection conn, String idExamen) throws SQLException {
        String sql = "SELECT COUNT(*) FROM examens WHERE idExamen = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, Integer.parseInt(idExamen));
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    private boolean isPrescriptionExists(Connection conn, String idPrescrire) throws SQLException {
        String sql = "SELECT COUNT(*) FROM prescriptions WHERE idPrescrire = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, Integer.parseInt(idPrescrire));
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    private String emptyToNull(String value) {
        return (value == null || value.trim().isEmpty()) ? null : value;
    }

    private void forwardWithParams(HttpServletRequest request, HttpServletResponse response,
            boolean isEditMode, String idExamen, String idPrescrire, String typeExamen, 
            String dateRealisation, String statut, String resultat, String laboratoire,
            boolean hasImage) throws ServletException, IOException {
        
        request.setAttribute("edit", isEditMode ? "true" : "false");
        if (isEditMode) request.setAttribute("idExamen", idExamen);
        request.setAttribute("idPrescrire", idPrescrire);
        request.setAttribute("typeExamen", typeExamen);
        request.setAttribute("dateRealisation", dateRealisation);
        request.setAttribute("statut", statut);
        request.setAttribute("resultat", resultat);
        request.setAttribute("laboratoire", laboratoire);
        request.setAttribute("hasImage", hasImage);
        
        request.getRequestDispatcher("/Components/Examens/FrmExamens.jsp").forward(request, response);
    }
}