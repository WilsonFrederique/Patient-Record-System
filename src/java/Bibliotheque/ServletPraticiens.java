package Bibliotheque;

import java.io.IOException;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ServletPraticiens", urlPatterns = {"/ServletPraticiens"})
public class ServletPraticiens extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        if (action == null) {
            redirectWithError(request, response, "/Components/Praticiens/indexPraticiens.jsp", "action_non_specifiee");
            return;
        }
        
        switch (action) {
            case "update":
                updatePraticien(request, response);
                break;
            case "insert":
                insertPraticien(request, response);
                break;
            default:
                redirectWithError(request, response, "/Components/Praticiens/indexPraticiens.jsp", "action_invalide");
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/Components/Praticiens/indexPraticiens.jsp");
            return;
        }

        switch (action) {
            case "delete":
                deletePraticien(request, response);
                break;
            case "search":
                searchPraticiens(request, response);
                break;
            case "edit":
                editPraticien(request, response);
                break;
            default:
                redirectWithError(request, response, "/Components/Praticiens/indexPraticiens.jsp", "action_invalide");
        }
    }

    private void editPraticien(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        String cinPraticien = request.getParameter("cinPraticien");
        if (cinPraticien == null || cinPraticien.trim().isEmpty()) {
            redirectWithError(request, response, "/Components/Praticiens/indexPraticiens.jsp", "cin_praticien_manquant");
            return;
        }

        try (Connection conn = DB_Connexion.getConnection()) {
            String sql = "SELECT * FROM praticiens WHERE cinPraticien = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, cinPraticien);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        request.setAttribute("cinPraticien", rs.getString("cinPraticien"));
                        request.setAttribute("nom", rs.getString("nom"));
                        request.setAttribute("prenom", rs.getString("prenom"));
                        request.setAttribute("telephone", rs.getString("telephone"));
                        request.setAttribute("email", rs.getString("email"));
                        request.setAttribute("specialite", rs.getString("specialite"));
                        request.setAttribute("edit", "true");
                        
                        request.getRequestDispatcher("/Components/Praticiens/FrmPraticiens.jsp").forward(request, response);
                    } else {
                        redirectWithError(request, response, "/Components/Praticiens/indexPraticiens.jsp", "praticien_non_trouve");
                    }
                }
            }
        } catch (SQLException e) {
            handleSQLException(e, request, response, "/Components/Praticiens/indexPraticiens.jsp", null);
        }
    }
    
    private void searchPraticiens(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        String searchTerm = request.getParameter("searchTerm");

        if (searchTerm == null || searchTerm.trim().isEmpty()) {
            redirectWithError(request, response, "/Components/Praticiens/indexPraticiens.jsp", "term_recherche_vide");
            return;
        }

        try (Connection conn = DB_Connexion.getConnection()) {
            String sql = "SELECT * FROM praticiens WHERE "
                       + "cinPraticien LIKE ? OR "
                       + "nom LIKE ? OR "
                       + "prenom LIKE ? OR "
                       + "telephone LIKE ? OR "
                       + "email LIKE ? OR "
                       + "specialite LIKE ? "
                       + "ORDER BY nom ASC";

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                String likeTerm = "%" + searchTerm + "%";
                stmt.setString(1, likeTerm);
                stmt.setString(2, likeTerm);
                stmt.setString(3, likeTerm);
                stmt.setString(4, likeTerm);
                stmt.setString(5, likeTerm);
                stmt.setString(6, likeTerm);

                ResultSet rs = stmt.executeQuery();
                List<Map<String, String>> resultats = new ArrayList<>();

                while (rs.next()) {
                    Map<String, String> praticien = new HashMap<>();
                    praticien.put("cinPraticien", rs.getString("cinPraticien"));
                    praticien.put("nom", rs.getString("nom"));
                    praticien.put("prenom", rs.getString("prenom"));
                    praticien.put("telephone", rs.getString("telephone"));
                    praticien.put("email", rs.getString("email"));
                    praticien.put("specialite", rs.getString("specialite"));
                    resultats.add(praticien);
                }

                request.setAttribute("resultatsRecherche", resultats);
                request.setAttribute("searchTerm", searchTerm);
                request.getRequestDispatcher("/Components/Praticiens/indexPraticiens.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            redirectWithError(request, response, "/Components/Praticiens/indexPraticiens.jsp", "erreur_recherche");
        }
    }
    
    private void insertPraticien(HttpServletRequest request, HttpServletResponse response) 
        throws IOException {
        String cinPraticien = getTrimmedParameter(request, "cinPraticien");
        String nom = getTrimmedParameter(request, "nom");
        String prenom = getTrimmedParameter(request, "prenom");
        String telephone = getTrimmedParameter(request, "telephone");
        String email = getTrimmedParameter(request, "email");
        String specialite = getTrimmedParameter(request, "specialite");

        // Vérification des champs obligatoires
        if (areParametersEmpty(cinPraticien, nom, prenom)) {
            redirectWithFormData(request, response, "/Components/Praticiens/FrmPraticiens.jsp", "champs_vides", 
                              cinPraticien, nom, prenom, telephone, email, specialite, false);
            return;
        }

        // Validation de l'email si fourni
        if (!email.isEmpty() && !isValidEmail(email)) {
            redirectWithFormData(request, response, "/Components/Praticiens/FrmPraticiens.jsp", "email_invalide", 
                              cinPraticien, nom, prenom, telephone, email, specialite, false);
            return;
        }

        try (Connection conn = DB_Connexion.getConnection()) {
            if (conn == null) {
                redirectWithFormData(request, response, "/Components/Praticiens/FrmPraticiens.jsp", "connexion_bdd", 
                                  cinPraticien, nom, prenom, telephone, email, specialite, false);
                return;
            }

            // Vérification si le CIN existe déjà
            if (isCinPraticienExists(conn, cinPraticien)) {
                redirectWithFormData(request, response, "/Components/Praticiens/FrmPraticiens.jsp", "cin_existe_deja", 
                                  cinPraticien, nom, prenom, telephone, email, specialite, false);
                return;
            }

            // Vérification si le téléphone existe déjà
            if (!telephone.isEmpty() && isTelephoneExists(conn, telephone)) {
                redirectWithFormData(request, response, "/Components/Praticiens/FrmPraticiens.jsp", "telephone_existe_deja", 
                                  cinPraticien, nom, prenom, telephone, email, specialite, false);
                return;
            }

            // Vérification si l'email existe déjà
            if (!email.isEmpty() && isEmailExists(conn, email)) {
                redirectWithFormData(request, response, "/Components/Praticiens/FrmPraticiens.jsp", "email_existe_deja", 
                                  cinPraticien, nom, prenom, telephone, email, specialite, false);
                return;
            }

            String sql = "INSERT INTO praticiens (cinPraticien, nom, prenom, telephone, email, specialite) VALUES (?, ?, ?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, cinPraticien);
                stmt.setString(2, nom);
                stmt.setString(3, prenom);
                stmt.setString(4, telephone.isEmpty() ? null : telephone);
                stmt.setString(5, email.isEmpty() ? null : email);
                stmt.setString(6, specialite.isEmpty() ? null : specialite);

                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    redirectWithSuccess(request, response, "/Components/Praticiens/indexPraticiens.jsp", "insert");
                } else {
                    redirectWithFormData(request, response, "/Components/Praticiens/FrmPraticiens.jsp", "erreur_insertion", 
                                      cinPraticien, nom, prenom, telephone, email, specialite, false);
                }
            }
        } catch (SQLException e) {
            redirectWithFormData(request, response, "/Components/Praticiens/FrmPraticiens.jsp", "erreur_systeme", 
                              cinPraticien, nom, prenom, telephone, email, specialite, false);
        }
    }

    private void updatePraticien(HttpServletRequest request, HttpServletResponse response) 
        throws IOException {
        String cinPraticien = getTrimmedParameter(request, "cinPraticien");
        String nom = getTrimmedParameter(request, "nom");
        String prenom = getTrimmedParameter(request, "prenom");
        String telephone = getTrimmedParameter(request, "telephone");
        String email = getTrimmedParameter(request, "email");
        String specialite = getTrimmedParameter(request, "specialite");

        // Vérification des champs obligatoires
        if (areParametersEmpty(cinPraticien, nom, prenom)) {
            redirectWithFormData(request, response, "/Components/Praticiens/FrmPraticiens.jsp", "champs_vides", 
                              cinPraticien, nom, prenom, telephone, email, specialite, true);
            return;
        }

        // Validation de l'email si fourni
        if (!email.isEmpty() && !isValidEmail(email)) {
            redirectWithFormData(request, response, "/Components/Praticiens/FrmPraticiens.jsp", "email_invalide", 
                              cinPraticien, nom, prenom, telephone, email, specialite, true);
            return;
        }

        try (Connection conn = DB_Connexion.getConnection()) {
            if (conn == null) {
                redirectWithFormData(request, response, "/Components/Praticiens/FrmPraticiens.jsp", "connexion_bdd", 
                                  cinPraticien, nom, prenom, telephone, email, specialite, true);
                return;
            }

            // Vérification si le téléphone existe déjà pour un autre praticien
            if (!telephone.isEmpty() && isTelephoneExistsForOtherPraticien(conn, telephone, cinPraticien)) {
                redirectWithFormData(request, response, "/Components/Praticiens/FrmPraticiens.jsp", "telephone_existe_deja", 
                                  cinPraticien, nom, prenom, telephone, email, specialite, true);
                return;
            }

            // Vérification si l'email existe déjà pour un autre praticien
            if (!email.isEmpty() && isEmailExistsForOtherPraticien(conn, email, cinPraticien)) {
                redirectWithFormData(request, response, "/Components/Praticiens/FrmPraticiens.jsp", "email_existe_deja", 
                                  cinPraticien, nom, prenom, telephone, email, specialite, true);
                return;
            }

            String sql = "UPDATE praticiens SET nom=?, prenom=?, telephone=?, email=?, specialite=? WHERE cinPraticien=?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, nom);
                stmt.setString(2, prenom);
                stmt.setString(3, telephone.isEmpty() ? null : telephone);
                stmt.setString(4, email.isEmpty() ? null : email);
                stmt.setString(5, specialite.isEmpty() ? null : specialite);
                stmt.setString(6, cinPraticien);

                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    redirectWithSuccess(request, response, "/Components/Praticiens/indexPraticiens.jsp", "update");
                } else {
                    redirectWithFormData(request, response, "/Components/Praticiens/FrmPraticiens.jsp", "praticien_non_trouve", 
                                      cinPraticien, nom, prenom, telephone, email, specialite, true);
                }
            }
        } catch (SQLException e) {
            redirectWithFormData(request, response, "/Components/Praticiens/FrmPraticiens.jsp", "erreur_systeme", 
                              cinPraticien, nom, prenom, telephone, email, specialite, true);
        }
    }

    private void deletePraticien(HttpServletRequest request, HttpServletResponse response) 
        throws IOException {
        String cinPraticien = getTrimmedParameter(request, "cinPraticien");
        if (cinPraticien.isEmpty()) {
            redirectWithError(request, response, "/Components/Praticiens/indexPraticiens.jsp", "cin_praticien_manquant");
            return;
        }

        try (Connection conn = DB_Connexion.getConnection()) {
            if (conn == null) {
                redirectWithError(request, response, "/Components/Praticiens/indexPraticiens.jsp", "connexion_bdd");
                return;
            }

            String deleteSql = "DELETE FROM praticiens WHERE cinPraticien = ?";
            try (PreparedStatement deleteStmt = conn.prepareStatement(deleteSql)) {
                deleteStmt.setString(1, cinPraticien);
                int rowsAffected = deleteStmt.executeUpdate();
                if (rowsAffected > 0) {
                    redirectWithSuccess(request, response, "/Components/Praticiens/indexPraticiens.jsp", "delete");
                } else {
                    redirectWithError(request, response, "/Components/Praticiens/indexPraticiens.jsp", "praticien_non_trouve");
                }
            }
        } catch (SQLException e) {
            handleSQLException(e, request, response, "/Components/Praticiens/indexPraticiens.jsp", null);
        }
    }

    // Méthodes utilitaires
    private String getTrimmedParameter(HttpServletRequest request, String paramName) {
        String value = request.getParameter(paramName);
        return value != null ? value.trim() : "";
    }

    private boolean areParametersEmpty(String... params) {
        for (String param : params) {
            if (param == null || param.trim().isEmpty()) {
                return true;
            }
        }
        return false;
    }

    private boolean isCinPraticienExists(Connection conn, String cinPraticien) throws SQLException {
        String checkSql = "SELECT COUNT(*) FROM praticiens WHERE cinPraticien = ?";
        try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
            checkStmt.setString(1, cinPraticien);
            try (ResultSet rs = checkStmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    private boolean isTelephoneExists(Connection conn, String telephone) throws SQLException {
        String checkSql = "SELECT COUNT(*) FROM praticiens WHERE telephone = ?";
        try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
            checkStmt.setString(1, telephone);
            try (ResultSet rs = checkStmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    private boolean isTelephoneExistsForOtherPraticien(Connection conn, String telephone, String cinPraticien) throws SQLException {
        String checkSql = "SELECT COUNT(*) FROM praticiens WHERE telephone = ? AND cinPraticien != ?";
        try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
            checkStmt.setString(1, telephone);
            checkStmt.setString(2, cinPraticien);
            try (ResultSet rs = checkStmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    private boolean isEmailExists(Connection conn, String email) throws SQLException {
        String checkSql = "SELECT COUNT(*) FROM praticiens WHERE email = ?";
        try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
            checkStmt.setString(1, email);
            try (ResultSet rs = checkStmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    private boolean isEmailExistsForOtherPraticien(Connection conn, String email, String cinPraticien) throws SQLException {
        String checkSql = "SELECT COUNT(*) FROM praticiens WHERE email = ? AND cinPraticien != ?";
        try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
            checkStmt.setString(1, email);
            checkStmt.setString(2, cinPraticien);
            try (ResultSet rs = checkStmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    private boolean isValidEmail(String email) {
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        Pattern pattern = Pattern.compile(emailRegex);
        if (email == null) return false;
        return pattern.matcher(email).matches();
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

    private void redirectWithSuccess(HttpServletRequest request, HttpServletResponse response, 
            String path, String success) throws IOException {
        response.sendRedirect(request.getContextPath() + path + "?success=" + success);
    }

    private void redirectWithFormData(HttpServletRequest request, HttpServletResponse response, 
            String path, String error, 
            String cinPraticien, String nom, String prenom, String telephone, 
            String email, String specialite, boolean isEdit) throws IOException {
        
        StringBuilder params = new StringBuilder();
        params.append("error=").append(error);
        params.append("&edit=").append(isEdit);
        params.append("&cinPraticien=").append(cinPraticien != null ? URLEncoder.encode(cinPraticien, "UTF-8") : "");
        params.append("&nom=").append(nom != null ? URLEncoder.encode(nom, "UTF-8") : "");
        params.append("&prenom=").append(prenom != null ? URLEncoder.encode(prenom, "UTF-8") : "");
        params.append("&telephone=").append(telephone != null ? URLEncoder.encode(telephone, "UTF-8") : "");
        params.append("&email=").append(email != null ? URLEncoder.encode(email, "UTF-8") : "");
        params.append("&specialite=").append(specialite != null ? URLEncoder.encode(specialite, "UTF-8") : "");

        response.sendRedirect(request.getContextPath() + path + "?" + params.toString());
    }

    private void handleSQLException(SQLException e, HttpServletRequest request, 
        HttpServletResponse response, String path, String additionalParams) throws IOException {
        e.printStackTrace();
        String errorMessage = "erreur_systeme";
        if (e.getMessage().contains("constraint")) {
            if (e.getMessage().contains("foreign key")) {
                errorMessage = "praticien_lie_a_autre_table";
            } else if (e.getMessage().contains("primary key") || e.getMessage().contains("duplicate")) {
                if (e.getMessage().contains("telephone")) {
                    errorMessage = "telephone_existe_deja";
                } else if (e.getMessage().contains("email")) {
                    errorMessage = "email_existe_deja";
                } else {
                    errorMessage = "cin_existe_deja";
                }
            }
        }
        redirectWithError(request, response, path, errorMessage, additionalParams);
    }
}