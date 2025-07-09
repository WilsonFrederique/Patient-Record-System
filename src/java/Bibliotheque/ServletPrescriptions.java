package Bibliotheque;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ServletPrescriptions", urlPatterns = {"/ServletPrescriptions"})
public class ServletPrescriptions extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("delete".equals(action)) {
            deletePrescription(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/Components/Prescriptions/indexPrescriptions.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        System.out.println("Action reçue: " + action);
        
        if (action == null) {
            redirectWithError(request, response, "/Components/Prescriptions/FrmPrescriptions.jsp", "action_non_specifiee");
            return;
        }

        try {
            switch (action) {
                case "update":
                    updatePrescription(request, response);
                    break;
                case "insert":
                    insertPrescription(request, response);
                    break;
                default:
                    redirectWithError(request, response, "/Components/Prescriptions/FrmPrescriptions.jsp", "action_invalide");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "erreur_systeme");
            request.getRequestDispatcher("/Components/Prescriptions/FrmPrescriptions.jsp").forward(request, response);
        }
    }

    private void insertPrescription(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        System.out.println("Début de la méthode insertPrescription");
        
        String idConsult = request.getParameter("idConsult");
        String typePrescrire = request.getParameter("typePrescrire");
        String posologie = request.getParameter("posologie");
        String datePrescrireStr = request.getParameter("datePrescrire");

        System.out.println("Paramètres reçus - idConsult: " + idConsult + ", type: " + typePrescrire);

        // Vérification des champs obligatoires
        if (idConsult == null || idConsult.trim().isEmpty() || 
            typePrescrire == null || typePrescrire.trim().isEmpty() ||
            datePrescrireStr == null || datePrescrireStr.trim().isEmpty()) {
            
            System.out.println("Champs obligatoires manquants");
            request.setAttribute("error", "champs_vides");
            request.setAttribute("idConsult", idConsult);
            request.setAttribute("typePrescrire", typePrescrire);
            request.setAttribute("posologie", posologie);
            request.setAttribute("datePrescrire", datePrescrireStr);
            request.getRequestDispatcher("/Components/Prescriptions/FrmPrescriptions.jsp").forward(request, response);
            return;
        }

        // Vérification que l'ID Consultation est un nombre
        try {
            Integer.parseInt(idConsult);
        } catch (NumberFormatException e) {
            System.out.println("ID Consultation invalide: " + idConsult);
            request.setAttribute("error", "consult_invalide");
            request.setAttribute("idConsult", idConsult);
            request.setAttribute("typePrescrire", typePrescrire);
            request.setAttribute("posologie", posologie);
            request.setAttribute("datePrescrire", datePrescrireStr);
            request.getRequestDispatcher("/Components/Prescriptions/FrmPrescriptions.jsp").forward(request, response);
            return;
        }

        Connection conn = null;
        try {
            // Conversion de la date
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            Date datePrescrire = sdf.parse(datePrescrireStr);
            Timestamp datePrescrireTimestamp = new Timestamp(datePrescrire.getTime());

            System.out.println("Date convertie: " + datePrescrireTimestamp);

            // Vérification que la date n'est pas dans le futur
            if (datePrescrire.after(new Date())) {
                System.out.println("Date dans le futur");
                request.setAttribute("error", "date_future");
                request.setAttribute("idConsult", idConsult);
                request.setAttribute("typePrescrire", typePrescrire);
                request.setAttribute("posologie", posologie);
                request.setAttribute("datePrescrire", datePrescrireStr);
                request.getRequestDispatcher("/Components/Prescriptions/FrmPrescriptions.jsp").forward(request, response);
                return;
            }

            conn = DB_Connexion.getConnection();
            if (conn == null) {
                System.out.println("Échec de connexion à la base de données");
                request.setAttribute("error", "connexion_bdd");
                request.setAttribute("idConsult", idConsult);
                request.setAttribute("typePrescrire", typePrescrire);
                request.setAttribute("posologie", posologie);
                request.setAttribute("datePrescrire", datePrescrireStr);
                request.getRequestDispatcher("/Components/Prescriptions/FrmPrescriptions.jsp").forward(request, response);
                return;
            }

            // Vérification que la consultation existe
            if (!isConsultExists(conn, idConsult)) {
                System.out.println("Consultation invalide ou inexistante: " + idConsult);
                request.setAttribute("error", "consult_invalide");
                request.setAttribute("idConsult", idConsult);
                request.setAttribute("typePrescrire", typePrescrire);
                request.setAttribute("posologie", posologie);
                request.setAttribute("datePrescrire", datePrescrireStr);
                request.getRequestDispatcher("/Components/Prescriptions/FrmPrescriptions.jsp").forward(request, response);
                return;
            }

            // Vérification qu'il n'y a pas déjà une prescription pour cette consultation à la même date (sans l'heure)
            if (hasPrescriptionForConsultAtSameDate(conn, idConsult, datePrescrireTimestamp)) {
                System.out.println("Prescription existe déjà pour cette consultation à la même date: " + idConsult);
                request.setAttribute("error", "prescription_existe_deja");
                request.setAttribute("idConsult", idConsult);
                request.setAttribute("typePrescrire", typePrescrire);
                request.setAttribute("posologie", posologie);
                request.setAttribute("datePrescrire", datePrescrireStr);
                request.getRequestDispatcher("/Components/Prescriptions/FrmPrescriptions.jsp").forward(request, response);
                return;
            }

            // Insertion de la prescription
            String sql = "INSERT INTO prescriptions (idConsult, typePrescrire, posologie, datePrescrire) VALUES (?, ?, ?, ?)";
            System.out.println("Requête SQL: " + sql);
            
            try (PreparedStatement stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
                stmt.setInt(1, Integer.parseInt(idConsult));
                stmt.setString(2, typePrescrire);
                stmt.setString(3, posologie != null && !posologie.isEmpty() ? posologie : null);
                stmt.setTimestamp(4, datePrescrireTimestamp);

                System.out.println("Exécution de la requête d'insertion");
                int rowsAffected = stmt.executeUpdate();
                
                if (rowsAffected > 0) {
                    System.out.println("Insertion réussie, lignes affectées: " + rowsAffected);
                    
                    // Récupérer l'ID généré
                    try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                        if (generatedKeys.next()) {
                            int generatedId = generatedKeys.getInt(1);
                            System.out.println("ID généré: " + generatedId);
                            request.setAttribute("success", "insert");
                            request.getRequestDispatcher("/Components/Prescriptions/indexPrescriptions.jsp").forward(request, response);
                        } else {
                            System.out.println("Aucun ID généré");
                            request.setAttribute("success", "insert");
                            request.getRequestDispatcher("/Components/Prescriptions/indexPrescriptions.jsp").forward(request, response);
                        }
                    }
                } else {
                    System.out.println("Aucune ligne affectée lors de l'insertion");
                    request.setAttribute("error", "erreur_insertion");
                    request.setAttribute("idConsult", idConsult);
                    request.setAttribute("typePrescrire", typePrescrire);
                    request.setAttribute("posologie", posologie);
                    request.setAttribute("datePrescrire", datePrescrireStr);
                    request.getRequestDispatcher("/Components/Prescriptions/FrmPrescriptions.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            System.out.println("Erreur lors de l'insertion: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "erreur_systeme");
            request.setAttribute("idConsult", idConsult);
            request.setAttribute("typePrescrire", typePrescrire);
            request.setAttribute("posologie", posologie);
            request.setAttribute("datePrescrire", datePrescrireStr);
            request.getRequestDispatcher("/Components/Prescriptions/FrmPrescriptions.jsp").forward(request, response);
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

    private void updatePrescription(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        String idPrescrire = request.getParameter("idPrescrire");
        String idConsult = request.getParameter("idConsult");
        String typePrescrire = request.getParameter("typePrescrire");
        String posologie = request.getParameter("posologie");
        String datePrescrireStr = request.getParameter("datePrescrire");

        // Vérification des champs obligatoires
        if (idPrescrire == null || idPrescrire.trim().isEmpty() || 
            idConsult == null || idConsult.trim().isEmpty() || 
            typePrescrire == null || typePrescrire.trim().isEmpty() ||
            datePrescrireStr == null || datePrescrireStr.trim().isEmpty()) {
            
            request.setAttribute("error", "champs_vides");
            request.setAttribute("idPrescrire", idPrescrire);
            request.setAttribute("idConsult", idConsult);
            request.setAttribute("typePrescrire", typePrescrire);
            request.setAttribute("posologie", posologie);
            request.setAttribute("datePrescrire", datePrescrireStr);
            request.setAttribute("edit", "true");
            request.getRequestDispatcher("/Components/Prescriptions/FrmPrescriptions.jsp").forward(request, response);
            return;
        }

        Connection conn = null;
        try {
            // Conversion de la date
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            Date datePrescrire = sdf.parse(datePrescrireStr);
            Timestamp datePrescrireTimestamp = new Timestamp(datePrescrire.getTime());

            // Vérification que la date n'est pas dans le futur
            if (datePrescrire.after(new Date())) {
                request.setAttribute("error", "date_future");
                request.setAttribute("idPrescrire", idPrescrire);
                request.setAttribute("idConsult", idConsult);
                request.setAttribute("typePrescrire", typePrescrire);
                request.setAttribute("posologie", posologie);
                request.setAttribute("datePrescrire", datePrescrireStr);
                request.setAttribute("edit", "true");
                request.getRequestDispatcher("/Components/Prescriptions/FrmPrescriptions.jsp").forward(request, response);
                return;
            }

            conn = DB_Connexion.getConnection();
            if (conn == null) {
                request.setAttribute("error", "connexion_bdd");
                request.setAttribute("idPrescrire", idPrescrire);
                request.setAttribute("idConsult", idConsult);
                request.setAttribute("typePrescrire", typePrescrire);
                request.setAttribute("posologie", posologie);
                request.setAttribute("datePrescrire", datePrescrireStr);
                request.setAttribute("edit", "true");
                request.getRequestDispatcher("/Components/Prescriptions/FrmPrescriptions.jsp").forward(request, response);
                return;
            }

            // Vérification que la prescription existe
            if (!isPrescriptionExists(conn, idPrescrire)) {
                request.setAttribute("error", "prescription_non_trouvee");
                request.setAttribute("idPrescrire", idPrescrire);
                request.setAttribute("idConsult", idConsult);
                request.setAttribute("typePrescrire", typePrescrire);
                request.setAttribute("posologie", posologie);
                request.setAttribute("datePrescrire", datePrescrireStr);
                request.setAttribute("edit", "true");
                request.getRequestDispatcher("/Components/Prescriptions/FrmPrescriptions.jsp").forward(request, response);
                return;
            }

            // Vérification que la consultation existe
            if (!isConsultExists(conn, idConsult)) {
                request.setAttribute("error", "consult_invalide");
                request.setAttribute("idPrescrire", idPrescrire);
                request.setAttribute("idConsult", idConsult);
                request.setAttribute("typePrescrire", typePrescrire);
                request.setAttribute("posologie", posologie);
                request.setAttribute("datePrescrire", datePrescrireStr);
                request.setAttribute("edit", "true");
                request.getRequestDispatcher("/Components/Prescriptions/FrmPrescriptions.jsp").forward(request, response);
                return;
            }

            // Vérification qu'il n'y a pas déjà une autre prescription pour cette consultation à la même date (sans l'heure)
            if (hasOtherPrescriptionForConsultAtSameDate(conn, idPrescrire, idConsult, datePrescrireTimestamp)) {
                request.setAttribute("error", "prescription_existe_deja");
                request.setAttribute("idPrescrire", idPrescrire);
                request.setAttribute("idConsult", idConsult);
                request.setAttribute("typePrescrire", typePrescrire);
                request.setAttribute("posologie", posologie);
                request.setAttribute("datePrescrire", datePrescrireStr);
                request.setAttribute("edit", "true");
                request.getRequestDispatcher("/Components/Prescriptions/FrmPrescriptions.jsp").forward(request, response);
                return;
            }

            // Mise à jour de la prescription
            String sql = "UPDATE prescriptions SET typePrescrire=?, posologie=?, datePrescrire=? WHERE idPrescrire=?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, typePrescrire);
                stmt.setString(2, posologie != null && !posologie.isEmpty() ? posologie : null);
                stmt.setTimestamp(3, datePrescrireTimestamp);
                stmt.setInt(4, Integer.parseInt(idPrescrire));

                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    request.setAttribute("success", "update");
                    request.getRequestDispatcher("/Components/Prescriptions/indexPrescriptions.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "erreur_mise_a_jour");
                    request.setAttribute("idPrescrire", idPrescrire);
                    request.setAttribute("idConsult", idConsult);
                    request.setAttribute("typePrescrire", typePrescrire);
                    request.setAttribute("posologie", posologie);
                    request.setAttribute("datePrescrire", datePrescrireStr);
                    request.setAttribute("edit", "true");
                    request.getRequestDispatcher("/Components/Prescriptions/FrmPrescriptions.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "erreur_systeme");
            request.setAttribute("idPrescrire", idPrescrire);
            request.setAttribute("idConsult", idConsult);
            request.setAttribute("typePrescrire", typePrescrire);
            request.setAttribute("posologie", posologie);
            request.setAttribute("datePrescrire", datePrescrireStr);
            request.setAttribute("edit", "true");
            request.getRequestDispatcher("/Components/Prescriptions/FrmPrescriptions.jsp").forward(request, response);
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

    private void deletePrescription(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idPrescrire = request.getParameter("idPrescrire");
        
        if (idPrescrire == null || idPrescrire.trim().isEmpty()) {
            redirectWithError(request, response, "/Components/Prescriptions/indexPrescriptions.jsp", "id_non_specifie");
            return;
        }

        Connection conn = null;
        try {
            conn = DB_Connexion.getConnection();
            if (conn == null) {
                redirectWithError(request, response, "/Components/Prescriptions/indexPrescriptions.jsp", "connexion_bdd");
                return;
            }

            // Supprimer la prescription
            String sqlDelete = "DELETE FROM prescriptions WHERE idPrescrire = ?";
            try (PreparedStatement stmtDelete = conn.prepareStatement(sqlDelete)) {
                stmtDelete.setInt(1, Integer.parseInt(idPrescrire));
                int rowsAffected = stmtDelete.executeUpdate();
                
                if (rowsAffected > 0) {
                    response.sendRedirect(request.getContextPath() + "/Components/Prescriptions/indexPrescriptions.jsp?success=delete&id=" + idPrescrire);
                } else {
                    redirectWithError(request, response, "/Components/Prescriptions/indexPrescriptions.jsp", "prescription_non_trouvee");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            redirectWithError(request, response, "/Components/Prescriptions/indexPrescriptions.jsp", "erreur_systeme");
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

    // Méthodes utilitaires
    private boolean isPrescriptionExists(Connection conn, String idPrescrire) throws SQLException {
        String sql = "SELECT COUNT(*) FROM prescriptions WHERE idPrescrire = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, Integer.parseInt(idPrescrire));
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    private boolean isConsultExists(Connection conn, String idConsult) throws SQLException {
        String sql = "SELECT COUNT(*) FROM consultations WHERE idConsult = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, Integer.parseInt(idConsult));
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    // Vérifie s'il existe déjà une prescription pour cette consultation à la même date (sans l'heure)
    private boolean hasPrescriptionForConsultAtSameDate(Connection conn, String idConsult, Timestamp datePrescrire) throws SQLException {
        String sql = "SELECT COUNT(*) FROM prescriptions WHERE idConsult = ? AND DATE(datePrescrire) = DATE(?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, Integer.parseInt(idConsult));
            stmt.setTimestamp(2, datePrescrire);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    // Vérifie s'il existe une autre prescription (différente) pour cette consultation à la même date (sans l'heure)
    private boolean hasOtherPrescriptionForConsultAtSameDate(Connection conn, String idPrescrire, String idConsult, Timestamp datePrescrire) throws SQLException {
        String sql = "SELECT COUNT(*) FROM prescriptions WHERE idConsult = ? AND DATE(datePrescrire) = DATE(?) AND idPrescrire != ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, Integer.parseInt(idConsult));
            stmt.setTimestamp(2, datePrescrire);
            stmt.setInt(3, Integer.parseInt(idPrescrire));
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    private void redirectWithError(HttpServletRequest request, HttpServletResponse response,
            String path, String error) throws IOException {
        response.sendRedirect(request.getContextPath() + path + "?error=" + error);
    }
}