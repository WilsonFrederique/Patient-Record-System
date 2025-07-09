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

@WebServlet(name = "ServletPatients", urlPatterns = {"/ServletPatients"})
public class ServletPatients extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        if (action == null) {
            redirectWithError(request, response, "/Components/Patients/indexPatients.jsp", "action_non_specifiee");
            return;
        }
        
        switch (action) {
            case "update":
                updatePatient(request, response);
                break;
            case "insert":
                insertPatient(request, response);
                break;
            default:
                redirectWithError(request, response, "/Components/Patients/indexPatients.jsp", "action_invalide");
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/Components/Patients/indexPatients.jsp");
            return;
        }

        switch (action) {
            case "delete":
                deletePatient(request, response);
                break;
            case "search":
                searchPatients(request, response);
                break;
            case "edit":
                editPatient(request, response);
                break;
            default:
                redirectWithError(request, response, "/Components/Patients/indexPatients.jsp", "action_invalide");
        }
    }

    private void editPatient(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        String cinPatient = request.getParameter("cinPatient");
        if (cinPatient == null || cinPatient.trim().isEmpty()) {
            redirectWithError(request, response, "/Components/Patients/indexPatients.jsp", "cin_patient_manquant");
            return;
        }

        try (Connection conn = DB_Connexion.getConnection()) {
            String sql = "SELECT * FROM patients WHERE cinPatient = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, cinPatient);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        // Conversion des valeurs de sexe pour le formulaire
                        String sexeDB = rs.getString("sexe");
                        String sexeForm = "";
                        if ("Homme".equals(sexeDB)) {
                            sexeForm = "Masculin";
                        } else if ("Femme".equals(sexeDB)) {
                            sexeForm = "Feminin";
                        }

                        request.setAttribute("cinPatient", rs.getString("cinPatient"));
                        request.setAttribute("nom", rs.getString("nom"));
                        request.setAttribute("prenom", rs.getString("prenom"));
                        request.setAttribute("sexe", sexeForm);
                        request.setAttribute("age", rs.getString("age"));
                        request.setAttribute("adresse", rs.getString("adresse"));
                        request.setAttribute("telephone", rs.getString("telephone"));
                        request.setAttribute("email", rs.getString("email"));
                        request.setAttribute("edit", "true");
                        
                        request.getRequestDispatcher("/Components/Patients/FrmPatient.jsp").forward(request, response);
                    } else {
                        redirectWithError(request, response, "/Components/Patients/indexPatients.jsp", "patient_non_trouve");
                    }
                }
            }
        } catch (SQLException e) {
            handleSQLException(e, request, response, "/Components/Patients/indexPatients.jsp", null);
        }
    }
    
    private void searchPatients(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        String searchTerm = request.getParameter("searchTerm");

        if (searchTerm == null || searchTerm.trim().isEmpty()) {
            redirectWithError(request, response, "/Components/Patients/indexPatients.jsp", "term_recherche_vide");
            return;
        }

        try (Connection conn = DB_Connexion.getConnection()) {
            String sql = "SELECT * FROM patients WHERE "
                       + "cinPatient LIKE ? OR "
                       + "nom LIKE ? OR "
                       + "prenom LIKE ? OR "
                       + "sexe LIKE ? OR "
                       + "adresse LIKE ? OR "
                       + "telephone LIKE ? OR "
                       + "email LIKE ? "
                       + "ORDER BY nom ASC";

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                String likeTerm = "%" + searchTerm + "%";
                stmt.setString(1, likeTerm);
                stmt.setString(2, likeTerm);
                stmt.setString(3, likeTerm);
                stmt.setString(4, likeTerm);
                stmt.setString(5, likeTerm);
                stmt.setString(6, likeTerm);
                stmt.setString(7, likeTerm);

                ResultSet rs = stmt.executeQuery();
                List<Map<String, String>> resultats = new ArrayList<>();

                while (rs.next()) {
                    Map<String, String> patient = new HashMap<>();
                    patient.put("cinPatient", rs.getString("cinPatient"));
                    patient.put("nom", rs.getString("nom"));
                    patient.put("prenom", rs.getString("prenom"));
                    patient.put("sexe", rs.getString("sexe"));
                    patient.put("age", rs.getString("age"));
                    patient.put("adresse", rs.getString("adresse"));
                    patient.put("telephone", rs.getString("telephone"));
                    patient.put("email", rs.getString("email"));
                    resultats.add(patient);
                }

                request.setAttribute("resultatsRecherche", resultats);
                request.setAttribute("searchTerm", searchTerm);
                request.getRequestDispatcher("/Components/Patients/indexPatients.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            redirectWithError(request, response, "/Components/Patients/indexPatients.jsp", "erreur_recherche");
        }
    }
    
    private void insertPatient(HttpServletRequest request, HttpServletResponse response) 
        throws IOException {
        String cinPatient = getTrimmedParameter(request, "cinPatient");
        String nom = getTrimmedParameter(request, "nom");
        String prenom = getTrimmedParameter(request, "prenom");
        String sexe = getTrimmedParameter(request, "sexe");
        String ageStr = getTrimmedParameter(request, "age");
        String adresse = getTrimmedParameter(request, "adresse");
        String telephone = getTrimmedParameter(request, "telephone");
        String email = getTrimmedParameter(request, "email");

        // Vérification des champs obligatoires
        if (areParametersEmpty(cinPatient, nom, prenom, ageStr)) {
            redirectWithFormData(request, response, "/Components/Patients/FrmPatient.jsp", "champs_vides", 
                              cinPatient, nom, prenom, sexe, ageStr, adresse, telephone, email, false);
            return;
        }

        // Validation de l'email si fourni
        if (!email.isEmpty() && !isValidEmail(email)) {
            redirectWithFormData(request, response, "/Components/Patients/FrmPatient.jsp", "email_invalide", 
                              cinPatient, nom, prenom, sexe, ageStr, adresse, telephone, email, false);
            return;
        }

        try {
            int age = Integer.parseInt(ageStr);
            if (age <= 0) {
                redirectWithFormData(request, response, "/Components/Patients/FrmPatient.jsp", "age_invalide", 
                                  cinPatient, nom, prenom, sexe, ageStr, adresse, telephone, email, false);
                return;
            }

            // Conversion des valeurs de sexe pour la base de données
            String sexeDB = "";
            if ("Masculin".equals(sexe)) {
                sexeDB = "Homme";
            } else if ("Feminin".equals(sexe)) {
                sexeDB = "Femme";
            }

            try (Connection conn = DB_Connexion.getConnection()) {
                if (conn == null) {
                    redirectWithFormData(request, response, "/Components/Patients/FrmPatient.jsp", "connexion_bdd", 
                                      cinPatient, nom, prenom, sexe, ageStr, adresse, telephone, email, false);
                    return;
                }

                // Vérification si le CIN existe déjà
                if (isCinPatientExists(conn, cinPatient)) {
                    redirectWithFormData(request, response, "/Components/Patients/FrmPatient.jsp", "cin_existe_deja", 
                                      cinPatient, nom, prenom, sexe, ageStr, adresse, telephone, email, false);
                    return;
                }

                // Vérification si le téléphone existe déjà
                if (!telephone.isEmpty() && isTelephoneExists(conn, telephone)) {
                    redirectWithFormData(request, response, "/Components/Patients/FrmPatient.jsp", "telephone_existe_deja", 
                                      cinPatient, nom, prenom, sexe, ageStr, adresse, telephone, email, false);
                    return;
                }

                // Vérification si l'email existe déjà
                if (!email.isEmpty() && isEmailExists(conn, email)) {
                    redirectWithFormData(request, response, "/Components/Patients/FrmPatient.jsp", "email_existe_deja", 
                                      cinPatient, nom, prenom, sexe, ageStr, adresse, telephone, email, false);
                    return;
                }

                String sql = "INSERT INTO patients (cinPatient, nom, prenom, sexe, age, adresse, telephone, email) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, cinPatient);
                    stmt.setString(2, nom);
                    stmt.setString(3, prenom);
                    stmt.setString(4, sexeDB.isEmpty() ? null : sexeDB);
                    stmt.setInt(5, age);
                    stmt.setString(6, adresse.isEmpty() ? null : adresse);
                    stmt.setString(7, telephone.isEmpty() ? null : telephone);
                    stmt.setString(8, email.isEmpty() ? null : email);

                    int rowsAffected = stmt.executeUpdate();
                    if (rowsAffected > 0) {
                        redirectWithSuccess(request, response, "/Components/Patients/indexPatients.jsp", "insert");
                    } else {
                        redirectWithFormData(request, response, "/Components/Patients/FrmPatient.jsp", "erreur_insertion", 
                                          cinPatient, nom, prenom, sexe, ageStr, adresse, telephone, email, false);
                    }
                }
            } catch (SQLException e) {
                redirectWithFormData(request, response, "/Components/Patients/FrmPatient.jsp", "erreur_systeme", 
                                  cinPatient, nom, prenom, sexe, ageStr, adresse, telephone, email, false);
            }
        } catch (NumberFormatException e) {
            redirectWithFormData(request, response, "/Components/Patients/FrmPatient.jsp", "age_invalide", 
                              cinPatient, nom, prenom, sexe, ageStr, adresse, telephone, email, false);
        }
    }

    private void updatePatient(HttpServletRequest request, HttpServletResponse response) 
        throws IOException {
        String cinPatient = getTrimmedParameter(request, "cinPatient");
        String nom = getTrimmedParameter(request, "nom");
        String prenom = getTrimmedParameter(request, "prenom");
        String sexe = getTrimmedParameter(request, "sexe");
        String ageStr = getTrimmedParameter(request, "age");
        String adresse = getTrimmedParameter(request, "adresse");
        String telephone = getTrimmedParameter(request, "telephone");
        String email = getTrimmedParameter(request, "email");

        // Vérification des champs obligatoires
        if (areParametersEmpty(cinPatient, nom, prenom, ageStr)) {
            redirectWithFormData(request, response, "/Components/Patients/FrmPatient.jsp", "champs_vides", 
                              cinPatient, nom, prenom, sexe, ageStr, adresse, telephone, email, true);
            return;
        }

        // Validation de l'email si fourni
        if (!email.isEmpty() && !isValidEmail(email)) {
            redirectWithFormData(request, response, "/Components/Patients/FrmPatient.jsp", "email_invalide", 
                              cinPatient, nom, prenom, sexe, ageStr, adresse, telephone, email, true);
            return;
        }

        try {
            int age = Integer.parseInt(ageStr);
            if (age <= 0) {
                redirectWithFormData(request, response, "/Components/Patients/FrmPatient.jsp", "age_invalide", 
                                  cinPatient, nom, prenom, sexe, ageStr, adresse, telephone, email, true);
                return;
            }

            // Conversion des valeurs de sexe pour la base de données
            String sexeDB = "";
            if ("Masculin".equals(sexe)) {
                sexeDB = "Homme";
            } else if ("Feminin".equals(sexe)) {
                sexeDB = "Femme";
            }

            try (Connection conn = DB_Connexion.getConnection()) {
                if (conn == null) {
                    redirectWithFormData(request, response, "/Components/Patients/FrmPatient.jsp", "connexion_bdd", 
                                      cinPatient, nom, prenom, sexe, ageStr, adresse, telephone, email, true);
                    return;
                }

                // Vérification si le téléphone existe déjà pour un autre patient
                if (!telephone.isEmpty() && isTelephoneExistsForOtherPatient(conn, telephone, cinPatient)) {
                    redirectWithFormData(request, response, "/Components/Patients/FrmPatient.jsp", "telephone_existe_deja", 
                                      cinPatient, nom, prenom, sexe, ageStr, adresse, telephone, email, true);
                    return;
                }

                // Vérification si l'email existe déjà pour un autre patient
                if (!email.isEmpty() && isEmailExistsForOtherPatient(conn, email, cinPatient)) {
                    redirectWithFormData(request, response, "/Components/Patients/FrmPatient.jsp", "email_existe_deja", 
                                      cinPatient, nom, prenom, sexe, ageStr, adresse, telephone, email, true);
                    return;
                }

                String sql = "UPDATE patients SET nom=?, prenom=?, sexe=?, age=?, adresse=?, telephone=?, email=? WHERE cinPatient=?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, nom);
                    stmt.setString(2, prenom);
                    stmt.setString(3, sexeDB.isEmpty() ? null : sexeDB);
                    stmt.setInt(4, age);
                    stmt.setString(5, adresse.isEmpty() ? null : adresse);
                    stmt.setString(6, telephone.isEmpty() ? null : telephone);
                    stmt.setString(7, email.isEmpty() ? null : email);
                    stmt.setString(8, cinPatient);

                    int rowsAffected = stmt.executeUpdate();
                    if (rowsAffected > 0) {
                        redirectWithSuccess(request, response, "/Components/Patients/indexPatients.jsp", "update");
                    } else {
                        redirectWithFormData(request, response, "/Components/Patients/FrmPatient.jsp", "patient_non_trouve", 
                                          cinPatient, nom, prenom, sexe, ageStr, adresse, telephone, email, true);
                    }
                }
            } catch (SQLException e) {
                redirectWithFormData(request, response, "/Components/Patients/FrmPatient.jsp", "erreur_systeme", 
                                  cinPatient, nom, prenom, sexe, ageStr, adresse, telephone, email, true);
            }
        } catch (NumberFormatException e) {
            redirectWithFormData(request, response, "/Components/Patients/FrmPatient.jsp", "age_invalide", 
                              cinPatient, nom, prenom, sexe, ageStr, adresse, telephone, email, true);
        }
    }

    private void deletePatient(HttpServletRequest request, HttpServletResponse response) 
        throws IOException {
        String cinPatient = getTrimmedParameter(request, "cinPatient");
        if (cinPatient.isEmpty()) {
            redirectWithError(request, response, "/Components/Patients/indexPatients.jsp", "cin_patient_manquant");
            return;
        }

        try (Connection conn = DB_Connexion.getConnection()) {
            if (conn == null) {
                redirectWithError(request, response, "/Components/Patients/indexPatients.jsp", "connexion_bdd");
                return;
            }

            String deleteSql = "DELETE FROM patients WHERE cinPatient = ?";
            try (PreparedStatement deleteStmt = conn.prepareStatement(deleteSql)) {
                deleteStmt.setString(1, cinPatient);
                int rowsAffected = deleteStmt.executeUpdate();
                if (rowsAffected > 0) {
                    redirectWithSuccess(request, response, "/Components/Patients/indexPatients.jsp", "delete");
                } else {
                    redirectWithError(request, response, "/Components/Patients/indexPatients.jsp", "patient_non_trouve");
                }
            }
        } catch (SQLException e) {
            handleSQLException(e, request, response, "/Components/Patients/indexPatients.jsp", null);
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

    private boolean isCinPatientExists(Connection conn, String cinPatient) throws SQLException {
        String checkSql = "SELECT COUNT(*) FROM patients WHERE cinPatient = ?";
        try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
            checkStmt.setString(1, cinPatient);
            try (ResultSet rs = checkStmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    private boolean isTelephoneExists(Connection conn, String telephone) throws SQLException {
        String checkSql = "SELECT COUNT(*) FROM patients WHERE telephone = ?";
        try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
            checkStmt.setString(1, telephone);
            try (ResultSet rs = checkStmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    private boolean isTelephoneExistsForOtherPatient(Connection conn, String telephone, String cinPatient) throws SQLException {
        String checkSql = "SELECT COUNT(*) FROM patients WHERE telephone = ? AND cinPatient != ?";
        try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
            checkStmt.setString(1, telephone);
            checkStmt.setString(2, cinPatient);
            try (ResultSet rs = checkStmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    private boolean isEmailExists(Connection conn, String email) throws SQLException {
        String checkSql = "SELECT COUNT(*) FROM patients WHERE email = ?";
        try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
            checkStmt.setString(1, email);
            try (ResultSet rs = checkStmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    private boolean isEmailExistsForOtherPatient(Connection conn, String email, String cinPatient) throws SQLException {
        String checkSql = "SELECT COUNT(*) FROM patients WHERE email = ? AND cinPatient != ?";
        try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
            checkStmt.setString(1, email);
            checkStmt.setString(2, cinPatient);
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
            String cinPatient, String nom, String prenom, String sexe, String age, 
            String adresse, String telephone, String email, boolean isEdit) throws IOException {
        
        StringBuilder params = new StringBuilder();
        params.append("error=").append(error);
        params.append("&edit=").append(isEdit);
        params.append("&cinPatient=").append(cinPatient != null ? URLEncoder.encode(cinPatient, "UTF-8") : "");
        params.append("&nom=").append(nom != null ? URLEncoder.encode(nom, "UTF-8") : "");
        params.append("&prenom=").append(prenom != null ? URLEncoder.encode(prenom, "UTF-8") : "");
        params.append("&sexe=").append(sexe != null ? URLEncoder.encode(sexe, "UTF-8") : "");
        params.append("&age=").append(age != null ? URLEncoder.encode(age, "UTF-8") : "");
        params.append("&adresse=").append(adresse != null ? URLEncoder.encode(adresse, "UTF-8") : "");
        params.append("&telephone=").append(telephone != null ? URLEncoder.encode(telephone, "UTF-8") : "");
        params.append("&email=").append(email != null ? URLEncoder.encode(email, "UTF-8") : "");

        response.sendRedirect(request.getContextPath() + path + "?" + params.toString());
    }

    private void handleSQLException(SQLException e, HttpServletRequest request, 
        HttpServletResponse response, String path, String additionalParams) throws IOException {
        e.printStackTrace();
        String errorMessage = "erreur_systeme";
        if (e.getMessage().contains("constraint")) {
            if (e.getMessage().contains("foreign key")) {
                errorMessage = "patient_lie_a_autre_table";
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