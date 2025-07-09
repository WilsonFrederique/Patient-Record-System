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

@WebServlet(name = "ServletConsultations", urlPatterns = {"/ServletConsultations"})
public class ServletConsultations extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("delete".equals(action)) {
            deleteConsultation(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/Components/Consultations/indexConsultations.jsp");
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
            redirectWithError(request, response, "/Components/Consultations/FrmConsultations.jsp", "action_non_specifiee");
            return;
        }

        try {
            switch (action) {
                case "update":
                    updateConsultation(request, response);
                    break;
                case "insert":
                    insertConsultation(request, response);
                    break;
                default:
                    redirectWithError(request, response, "/Components/Consultations/FrmConsultations.jsp", "action_invalide");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "erreur_systeme");
            request.getRequestDispatcher("/Components/Consultations/FrmConsultations.jsp").forward(request, response);
        }
    }

    private void insertConsultation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        System.out.println("Début de la méthode insertConsultation");
        
        String idRdv = request.getParameter("idRdv");
        String dateConsultStr = request.getParameter("dateConsult");
        String compteRendu = request.getParameter("compteRendu");

        System.out.println("Paramètres reçus - idRdv: " + idRdv + ", dateConsult: " + dateConsultStr);

        // Vérification des champs obligatoires
        if (idRdv == null || idRdv.trim().isEmpty() || dateConsultStr == null || dateConsultStr.trim().isEmpty()) {
            System.out.println("Champs obligatoires manquants");
            request.setAttribute("error", "champs_vides");
            request.setAttribute("idRdv", idRdv);
            request.setAttribute("dateConsult", dateConsultStr);
            request.setAttribute("compteRendu", compteRendu);
            request.getRequestDispatcher("/Components/Consultations/FrmConsultations.jsp").forward(request, response);
            return;
        }

        // Vérification que l'ID Rendez-vous est un nombre
        try {
            Integer.parseInt(idRdv);
        } catch (NumberFormatException e) {
            System.out.println("ID Rendez-vous invalide: " + idRdv);
            request.setAttribute("error", "rdv_invalide");
            request.setAttribute("idRdv", idRdv);
            request.setAttribute("dateConsult", dateConsultStr);
            request.setAttribute("compteRendu", compteRendu);
            request.getRequestDispatcher("/Components/Consultations/FrmConsultations.jsp").forward(request, response);
            return;
        }

        Connection conn = null;
        try {
            // Conversion de la date
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            Date dateConsult = sdf.parse(dateConsultStr);
            Timestamp dateConsultTimestamp = new Timestamp(dateConsult.getTime());

            System.out.println("Date convertie: " + dateConsultTimestamp);

            // Vérification que la date n'est pas dans le futur
            if (dateConsult.after(new Date())) {
                System.out.println("Date dans le futur");
                request.setAttribute("error", "date_future");
                request.setAttribute("idRdv", idRdv);
                request.setAttribute("dateConsult", dateConsultStr);
                request.setAttribute("compteRendu", compteRendu);
                request.getRequestDispatcher("/Components/Consultations/FrmConsultations.jsp").forward(request, response);
                return;
            }

            conn = DB_Connexion.getConnection();
            if (conn == null) {
                System.out.println("Échec de connexion à la base de données");
                request.setAttribute("error", "connexion_bdd");
                request.setAttribute("idRdv", idRdv);
                request.setAttribute("dateConsult", dateConsultStr);
                request.setAttribute("compteRendu", compteRendu);
                request.getRequestDispatcher("/Components/Consultations/FrmConsultations.jsp").forward(request, response);
                return;
            }

            // Vérification que le rendez-vous existe et est confirmé
            if (!isRdvExistsAndConfirmed(conn, idRdv)) {
                System.out.println("Rendez-vous invalide ou non confirmé: " + idRdv);
                request.setAttribute("error", "rdv_non_confirme");
                request.setAttribute("idRdv", idRdv);
                request.setAttribute("dateConsult", dateConsultStr);
                request.setAttribute("compteRendu", compteRendu);
                request.getRequestDispatcher("/Components/Consultations/FrmConsultations.jsp").forward(request, response);
                return;
            }

            // Vérification qu'il n'y a pas déjà une consultation pour ce rendez-vous à la même date (sans l'heure)
            if (hasConsultationForRdvAtSameDate(conn, idRdv, dateConsultTimestamp)) {
                System.out.println("Consultation existe déjà pour ce RDV à la même date: " + idRdv);
                request.setAttribute("error", "consultation_existe_deja");
                request.setAttribute("idRdv", idRdv);
                request.setAttribute("dateConsult", dateConsultStr);
                request.setAttribute("compteRendu", compteRendu);
                request.getRequestDispatcher("/Components/Consultations/FrmConsultations.jsp").forward(request, response);
                return;
            }

            // Insertion de la consultation
            String sql = "INSERT INTO consultations (idRdv, dateConsult, compteRendu) VALUES (?, ?, ?)";
            System.out.println("Requête SQL: " + sql);
            
            try (PreparedStatement stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
                stmt.setInt(1, Integer.parseInt(idRdv));
                stmt.setTimestamp(2, dateConsultTimestamp);
                stmt.setString(3, compteRendu != null && !compteRendu.isEmpty() ? compteRendu : null);

                System.out.println("Exécution de la requête d'insertion");
                int rowsAffected = stmt.executeUpdate();
                
                if (rowsAffected > 0) {
                    System.out.println("Insertion réussie, lignes affectées: " + rowsAffected);
                    
                    // Mettre à jour le statut du rendez-vous en "terminé"
                    updateRdvStatus(conn, idRdv, "termine");

                    // Récupérer l'ID généré
                    try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                        if (generatedKeys.next()) {
                            int generatedId = generatedKeys.getInt(1);
                            System.out.println("ID généré: " + generatedId);
                            request.setAttribute("success", "insert");
                            request.getRequestDispatcher("/Components/Consultations/indexConsultations.jsp").forward(request, response);
                        } else {
                            System.out.println("Aucun ID généré");
                            request.setAttribute("success", "insert");
                            request.getRequestDispatcher("/Components/Consultations/indexConsultations.jsp").forward(request, response);
                        }
                    }
                } else {
                    System.out.println("Aucune ligne affectée lors de l'insertion");
                    request.setAttribute("error", "erreur_insertion");
                    request.setAttribute("idRdv", idRdv);
                    request.setAttribute("dateConsult", dateConsultStr);
                    request.setAttribute("compteRendu", compteRendu);
                    request.getRequestDispatcher("/Components/Consultations/FrmConsultations.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            System.out.println("Erreur lors de l'insertion: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("idRdv", idRdv);
            request.setAttribute("dateConsult", dateConsultStr);
            request.setAttribute("compteRendu", compteRendu);
            request.getRequestDispatcher("/Components/Consultations/indexConsultations.jsp").forward(request, response);
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

    private void updateConsultation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        String idConsult = request.getParameter("idConsult");
        String idRdv = request.getParameter("idRdv");
        String dateConsultStr = request.getParameter("dateConsult");
        String compteRendu = request.getParameter("compteRendu");

        // Vérification des champs obligatoires
        if (idConsult == null || idConsult.trim().isEmpty() || 
            idRdv == null || idRdv.trim().isEmpty() || 
            dateConsultStr == null || dateConsultStr.trim().isEmpty()) {
            
            request.setAttribute("error", "champs_vides");
            request.setAttribute("idConsult", idConsult);
            request.setAttribute("idRdv", idRdv);
            request.setAttribute("dateConsult", dateConsultStr);
            request.setAttribute("compteRendu", compteRendu);
            request.setAttribute("edit", "true");
            request.getRequestDispatcher("/Components/Consultations/FrmConsultations.jsp").forward(request, response);
            return;
        }

        Connection conn = null;
        try {
            // Conversion de la date
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            Date dateConsult = sdf.parse(dateConsultStr);
            Timestamp dateConsultTimestamp = new Timestamp(dateConsult.getTime());

            // Vérification que la date n'est pas dans le futur
            if (dateConsult.after(new Date())) {
                request.setAttribute("error", "date_future");
                request.setAttribute("idConsult", idConsult);
                request.setAttribute("idRdv", idRdv);
                request.setAttribute("dateConsult", dateConsultStr);
                request.setAttribute("compteRendu", compteRendu);
                request.setAttribute("edit", "true");
                request.getRequestDispatcher("/Components/Consultations/FrmConsultations.jsp").forward(request, response);
                return;
            }

            conn = DB_Connexion.getConnection();
            if (conn == null) {
                request.setAttribute("error", "connexion_bdd");
                request.setAttribute("idConsult", idConsult);
                request.setAttribute("idRdv", idRdv);
                request.setAttribute("dateConsult", dateConsultStr);
                request.setAttribute("compteRendu", compteRendu);
                request.setAttribute("edit", "true");
                request.getRequestDispatcher("/Components/Consultations/FrmConsultations.jsp").forward(request, response);
                return;
            }

            // Vérification que la consultation existe
            if (!isConsultationExists(conn, idConsult)) {
                request.setAttribute("error", "consultation_non_trouvee");
                request.setAttribute("idConsult", idConsult);
                request.setAttribute("idRdv", idRdv);
                request.setAttribute("dateConsult", dateConsultStr);
                request.setAttribute("compteRendu", compteRendu);
                request.setAttribute("edit", "true");
                request.getRequestDispatcher("/Components/Consultations/FrmConsultations.jsp").forward(request, response);
                return;
            }

            // Vérification que le rendez-vous existe
            if (!isRdvExists(conn, idRdv)) {
                request.setAttribute("error", "rdv_invalide");
                request.setAttribute("idConsult", idConsult);
                request.setAttribute("idRdv", idRdv);
                request.setAttribute("dateConsult", dateConsultStr);
                request.setAttribute("compteRendu", compteRendu);
                request.setAttribute("edit", "true");
                request.getRequestDispatcher("/Components/Consultations/FrmConsultations.jsp").forward(request, response);
                return;
            }

            // Vérification qu'il n'y a pas déjà une autre consultation pour ce RDV à la même date (sans l'heure)
            if (hasOtherConsultationForRdvAtSameDate(conn, idConsult, idRdv, dateConsultTimestamp)) {
                request.setAttribute("error", "consultation_existe_deja");
                request.setAttribute("idConsult", idConsult);
                request.setAttribute("idRdv", idRdv);
                request.setAttribute("dateConsult", dateConsultStr);
                request.setAttribute("compteRendu", compteRendu);
                request.setAttribute("edit", "true");
                request.getRequestDispatcher("/Components/Consultations/FrmConsultations.jsp").forward(request, response);
                return;
            }

            // Mise à jour de la consultation
            String sql = "UPDATE consultations SET dateConsult=?, compteRendu=? WHERE idConsult=?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setTimestamp(1, dateConsultTimestamp);
                stmt.setString(2, compteRendu != null && !compteRendu.isEmpty() ? compteRendu : null);
                stmt.setInt(3, Integer.parseInt(idConsult));

                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    request.setAttribute("success", "update");
                    request.getRequestDispatcher("/Components/Consultations/indexConsultations.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "erreur_mise_a_jour");
                    request.setAttribute("idConsult", idConsult);
                    request.setAttribute("idRdv", idRdv);
                    request.setAttribute("dateConsult", dateConsultStr);
                    request.setAttribute("compteRendu", compteRendu);
                    request.setAttribute("edit", "true");
                    request.getRequestDispatcher("/Components/Consultations/FrmConsultations.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "erreur_systeme");
            request.setAttribute("idConsult", idConsult);
            request.setAttribute("idRdv", idRdv);
            request.setAttribute("dateConsult", dateConsultStr);
            request.setAttribute("compteRendu", compteRendu);
            request.setAttribute("edit", "true");
            request.getRequestDispatcher("/Components/Consultations/FrmConsultations.jsp").forward(request, response);
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

    private void deleteConsultation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idConsult = request.getParameter("idConsult");
        
        if (idConsult == null || idConsult.trim().isEmpty()) {
            redirectWithError(request, response, "/Components/Consultations/indexConsultations.jsp", "id_non_specifie");
            return;
        }

        Connection conn = null;
        try {
            conn = DB_Connexion.getConnection();
            if (conn == null) {
                redirectWithError(request, response, "/Components/Consultations/indexConsultations.jsp", "connexion_bdd");
                return;
            }

            // Récupérer l'ID du rendez-vous avant suppression
            String idRdv = null;
            String sqlSelect = "SELECT idRdv FROM consultations WHERE idConsult = ?";
            try (PreparedStatement stmtSelect = conn.prepareStatement(sqlSelect)) {
                stmtSelect.setInt(1, Integer.parseInt(idConsult));
                try (ResultSet rs = stmtSelect.executeQuery()) {
                    if (rs.next()) {
                        idRdv = rs.getString("idRdv");
                    }
                }
            }

            // Supprimer la consultation
            String sqlDelete = "DELETE FROM consultations WHERE idConsult = ?";
            try (PreparedStatement stmtDelete = conn.prepareStatement(sqlDelete)) {
                stmtDelete.setInt(1, Integer.parseInt(idConsult));
                int rowsAffected = stmtDelete.executeUpdate();
                
                if (rowsAffected > 0) {
                    // Mettre à jour le statut du rendez-vous en "planifié"
                    if (idRdv != null) {
                        updateRdvStatus(conn, idRdv, "planifie");
                    }
                    
                    // Récupérer les paramètres de date pour la redirection
                    String dateDebut = request.getParameter("dateDebut");
                    String dateFin = request.getParameter("dateFin");
                    
                    String redirectUrl = request.getContextPath() + "/Components/Consultations/indexConsultations.jsp?success=delete&id=" + idConsult;
                    if (dateDebut != null && dateFin != null) {
                        redirectUrl += "&dateDebut=" + dateDebut + "&dateFin=" + dateFin;
                    }
                    
                    response.sendRedirect(redirectUrl);
                } else {
                    redirectWithError(request, response, "/Components/Consultations/indexConsultations.jsp", "consultation_non_trouvee");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            redirectWithError(request, response, "/Components/Consultations/indexConsultations.jsp", "erreur_systeme");
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
    private boolean isConsultationExists(Connection conn, String idConsult) throws SQLException {
        String sql = "SELECT COUNT(*) FROM consultations WHERE idConsult = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, Integer.parseInt(idConsult));
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    private boolean isRdvExists(Connection conn, String idRdv) throws SQLException {
        String sql = "SELECT COUNT(*) FROM rendezvous WHERE idRdv = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, Integer.parseInt(idRdv));
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    private boolean isRdvExistsAndConfirmed(Connection conn, String idRdv) throws SQLException {
        String sql = "SELECT COUNT(*) FROM rendezvous WHERE idRdv = ? AND statut = 'confirme'";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, Integer.parseInt(idRdv));
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    // Vérifie s'il existe déjà une consultation pour ce RDV à la même date (sans l'heure)
    private boolean hasConsultationForRdvAtSameDate(Connection conn, String idRdv, Timestamp dateConsult) throws SQLException {
        String sql = "SELECT COUNT(*) FROM consultations WHERE idRdv = ? AND DATE(dateConsult) = DATE(?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, Integer.parseInt(idRdv));
            stmt.setTimestamp(2, dateConsult);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    // Vérifie s'il existe une autre consultation (différente) pour ce RDV à la même date (sans l'heure)
    private boolean hasOtherConsultationForRdvAtSameDate(Connection conn, String idConsult, String idRdv, Timestamp dateConsult) throws SQLException {
        String sql = "SELECT COUNT(*) FROM consultations WHERE idRdv = ? AND DATE(dateConsult) = DATE(?) AND idConsult != ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, Integer.parseInt(idRdv));
            stmt.setTimestamp(2, dateConsult);
            stmt.setInt(3, Integer.parseInt(idConsult));
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    private void updateRdvStatus(Connection conn, String idRdv, String newStatus) throws SQLException {
        String sql = "UPDATE rendezvous SET statut = ? WHERE idRdv = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, newStatus);
            stmt.setInt(2, Integer.parseInt(idRdv));
            stmt.executeUpdate();
        }
    }

    private void redirectWithError(HttpServletRequest request, HttpServletResponse response,
            String path, String error) throws IOException {
        response.sendRedirect(request.getContextPath() + path + "?error=" + error);
    }
}