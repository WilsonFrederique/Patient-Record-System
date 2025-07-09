package Bibliotheque;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ServletRendezVous", urlPatterns = {"/ServletRendezVous"})
public class ServletRendezVous extends HttpServlet {

    private String additionalParams;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null) {
            redirectWithError(request, response, "/Components/RendezVous/indexRendezVous.jsp", "action_non_specifiee");
            return;
        }

        switch (action) {
            case "update":
                updateRendezVous(request, response);
                break;
            case "insert":
                insertRendezVous(request, response);
                break;
            default:
                redirectWithError(request, response, "/Components/RendezVous/indexRendezVous.jsp", "action_invalide");
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/Components/RendezVous/indexRendezVous.jsp");
            return;
        }

        switch (action) {
            case "delete":
                deleteRendezVous(request, response);
                break;
            case "edit":
                editRendezVous(request, response);
                break;
            case "search":
                searchRendezVous(request, response);
                break;
            case "getRdvParents":
                getRdvParentsList(request, response);
                break;
            default:
                redirectWithError(request, response, "/Components/RendezVous/indexRendezVous.jsp", "action_invalide");
        }
    }

    private void editRendezVous(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        String idRdv = request.getParameter("idRdv");
        if (idRdv == null || idRdv.trim().isEmpty()) {
            redirectWithError(request, response, "/Components/RendezVous/indexRendezVous.jsp", "id_rdv_manquant");
            return;
        }

        try (Connection conn = DB_Connexion.getConnection()) {
            String sql = "SELECT r.*, p.nom as nomPatient, p.prenom as prenomPatient, "
                       + "pr.nom as nomPraticien, pr.prenom as prenomPraticien, pr.specialite as specialite "
                       + "FROM rendezvous r "
                       + "LEFT JOIN patients p ON r.cinPatient = p.cinPatient "
                       + "LEFT JOIN praticiens pr ON r.cinPraticien = pr.cinPraticien "
                       + "WHERE r.idRdv = ?";

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, Integer.parseInt(idRdv));
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        // Récupération de la date
                        Timestamp dateHeure = rs.getTimestamp("dateHeure");
                        String dateHeureFormatted = "";

                        if (dateHeure != null) {
                            // Formatage pour l'input datetime-local (format: "yyyy-MM-ddTHH:mm")
                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                            dateHeureFormatted = sdf.format(dateHeure);
                        }

                        // Stocker les attributs
                        request.setAttribute("idRdv", rs.getString("idRdv"));
                        request.setAttribute("cinPatient", rs.getString("cinPatient"));
                        request.setAttribute("nomPatient", rs.getString("nomPatient"));
                        request.setAttribute("prenomPatient", rs.getString("prenomPatient"));
                        request.setAttribute("cinPraticien", rs.getString("cinPraticien"));
                        request.setAttribute("nomPraticien", rs.getString("nomPraticien"));
                        request.setAttribute("prenomPraticien", rs.getString("prenomPraticien"));
                        request.setAttribute("specialite", rs.getString("specialite"));
                        request.setAttribute("dateHeure", dateHeureFormatted); // Formaté pour l'input
                        request.setAttribute("dateHeureOriginal", rs.getTimestamp("dateHeure")); // Format original pour affichage
                        request.setAttribute("statut", rs.getString("statut"));
                        request.setAttribute("idRdvParent", rs.getString("idRdvParent"));
                        request.setAttribute("edit", "true");

                        // Charger les listes
                        loadPraticiensForForm(request);
                        loadPatientsForForm(request);

                        request.getRequestDispatcher("/Components/RendezVous/FrmRendezVous.jsp").forward(request, response);
                    } else {
                        redirectWithError(request, response, "/Components/RendezVous/indexRendezVous.jsp", "rendezvous_non_trouve");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            redirectWithError(request, response, "/Components/RendezVous/indexRendezVous.jsp", "connexion_bdd");
        } catch (Exception e) {
            e.printStackTrace();
            redirectWithError(request, response, "/Components/RendezVous/indexRendezVous.jsp", "erreur_systeme");
        }
    }
    
    private void searchRendezVous(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        String searchTerm = request.getParameter("searchTerm");

        if (searchTerm == null || searchTerm.trim().isEmpty()) {
            redirectWithError(request, response, "/Components/RendezVous/indexRendezVous.jsp", "term_recherche_vide");
            return;
        }

        try (Connection conn = DB_Connexion.getConnection()) {
            String sql = "SELECT r.*, p.nom as nomPatient, p.prenom as prenomPatient, "
                       + "pr.nom as nomPraticien, pr.prenom as prenomPraticien "
                       + "FROM rendezvous r "
                       + "LEFT JOIN patients p ON r.cinPatient = p.cinPatient "
                       + "LEFT JOIN praticiens pr ON r.cinPraticien = pr.cinPraticien "
                       + "WHERE r.idRdv LIKE ? OR "
                       + "r.cinPatient LIKE ? OR "
                       + "p.nom LIKE ? OR "
                       + "p.prenom LIKE ? OR "
                       + "r.cinPraticien LIKE ? OR "
                       + "pr.nom LIKE ? OR "
                       + "pr.prenom LIKE ? OR "
                       + "r.statut LIKE ? OR "
                       + "r.idRdvParent LIKE ? "
                       + "ORDER BY r.dateHeure DESC";

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                String likeTerm = "%" + searchTerm + "%";
                for (int i = 1; i <= 9; i++) {
                    stmt.setString(i, likeTerm);
                }

                ResultSet rs = stmt.executeQuery();
                List<Map<String, String>> resultats = new ArrayList<>();

                while (rs.next()) {
                    Map<String, String> rdv = new HashMap<>();
                    rdv.put("idRdv", rs.getString("idRdv"));
                    rdv.put("cinPatient", rs.getString("cinPatient"));
                    rdv.put("nomPatient", rs.getString("nomPatient"));
                    rdv.put("prenomPatient", rs.getString("prenomPatient"));
                    rdv.put("cinPraticien", rs.getString("cinPraticien"));
                    rdv.put("nomPraticien", rs.getString("nomPraticien"));
                    rdv.put("prenomPraticien", rs.getString("prenomPraticien"));
                    
                    Timestamp dateHeure = rs.getTimestamp("dateHeure");
                    rdv.put("dateHeure", new SimpleDateFormat("dd/MM/yyyy HH:mm").format(dateHeure));
                    
                    rdv.put("statut", rs.getString("statut"));
                    rdv.put("idRdvParent", rs.getString("idRdvParent"));
                    
                    resultats.add(rdv);
                }

                request.setAttribute("resultatsRecherche", resultats);
                request.setAttribute("searchTerm", searchTerm);
                request.getRequestDispatcher("/Components/RendezVous/indexRendezVous.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            redirectWithError(request, response, "/Components/RendezVous/indexRendezVous.jsp", "erreur_recherche");
        }
    }
    
    private void insertRendezVous(HttpServletRequest request, HttpServletResponse response) 
        throws IOException, ServletException {
        String cinPatient = getTrimmedParameter(request, "cinPatient");
        String cinPraticien = getTrimmedParameter(request, "cinPraticien");
        String dateHeureStr = getTrimmedParameter(request, "dateHeure");
        String statut = getTrimmedParameter(request, "statut");
        String idRdvParent = getTrimmedParameter(request, "idRdvParent");

        // Vérification des champs obligatoires
        if (areParametersEmpty(cinPatient, cinPraticien, dateHeureStr, statut)) {
            redirectWithFormData(request, response, "/Components/RendezVous/FrmRendezVous.jsp", "champs_vides", 
                              null, cinPatient, cinPraticien, dateHeureStr, statut, idRdvParent, false);
            return;
        }

        // Validation du statut
        if (!isValidStatut(statut)) {
            redirectWithFormData(request, response, "/Components/RendezVous/FrmRendezVous.jsp", "statut_invalide", 
                              null, cinPatient, cinPraticien, dateHeureStr, statut, idRdvParent, false);
            return;
        }

        try {
            // Conversion de la date
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            Date dateHeure = sdf.parse(dateHeureStr);
            Timestamp dateHeureTimestamp = new Timestamp(dateHeure.getTime());

            // Vérification que la date n'est pas dans le passé
            if (dateHeure.before(new Date())) {
                redirectWithFormData(request, response, "/Components/RendezVous/FrmRendezVous.jsp", "date_passee", 
                                  null, cinPatient, cinPraticien, dateHeureStr, statut, idRdvParent, false);
                return;
            }

            try (Connection conn = DB_Connexion.getConnection()) {
                if (conn == null) {
                    redirectWithFormData(request, response, "/Components/RendezVous/FrmRendezVous.jsp", "connexion_bdd", 
                                      null, cinPatient, cinPraticien, dateHeureStr, statut, idRdvParent, false);
                    return;
                }

                // Vérification que le patient existe
                if (!isPatientExists(conn, cinPatient)) {
                    redirectWithFormData(request, response, "/Components/RendezVous/FrmRendezVous.jsp", "patient_invalide", 
                                      null, cinPatient, cinPraticien, dateHeureStr, statut, idRdvParent, false);
                    return;
                }

                // Vérification que le praticien existe
                if (!isPraticienExists(conn, cinPraticien)) {
                    redirectWithFormData(request, response, "/Components/RendezVous/FrmRendezVous.jsp", "praticien_invalide", 
                                      null, cinPatient, cinPraticien, dateHeureStr, statut, idRdvParent, false);
                    return;
                }

                // Vérification du RDV parent s'il est spécifié
                if (!idRdvParent.isEmpty() && !isRdvParentValid(conn, idRdvParent)) {
                    redirectWithFormData(request, response, "/Components/RendezVous/FrmRendezVous.jsp", "rdv_parent_invalide", 
                                      null, cinPatient, cinPraticien, dateHeureStr, statut, idRdvParent, false);
                    return;
                }

                // Vérification des conflits de rendez-vous pour le patient
                if (hasPatientRdvAtSameTime(conn, cinPatient, dateHeureTimestamp, null)) {
                    redirectWithFormData(request, response, "/Components/RendezVous/FrmRendezVous.jsp", "conflit_rdv_patient", 
                                      null, cinPatient, cinPraticien, dateHeureStr, statut, idRdvParent, false);
                    return;
                }

                // Vérification des conflits de rendez-vous pour le praticien
                if (hasPraticienRdvAtSameTime(conn, cinPraticien, dateHeureTimestamp, null)) {
                    redirectWithFormData(request, response, "/Components/RendezVous/FrmRendezVous.jsp", "conflit_rdv_praticien", 
                                      null, cinPatient, cinPraticien, dateHeureStr, statut, idRdvParent, false);
                    return;
                }

                // Insertion du rendez-vous
                String sql = "INSERT INTO rendezvous (cinPatient, cinPraticien, dateHeure, statut, idRdvParent) VALUES (?, ?, ?, ?, ?)";
                try (PreparedStatement stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
                    stmt.setString(1, cinPatient);
                    stmt.setString(2, cinPraticien);
                    stmt.setTimestamp(3, dateHeureTimestamp);
                    stmt.setString(4, statut);
                    stmt.setString(5, idRdvParent.isEmpty() ? null : idRdvParent);

                    int rowsAffected = stmt.executeUpdate();
                    if (rowsAffected > 0) {
                        redirectWithSuccess(request, response, "/Components/RendezVous/indexRendezVous.jsp", "insert");
                    } else {
                        redirectWithFormData(request, response, "/Components/RendezVous/FrmRendezVous.jsp", "erreur_insertion", 
                                          null, cinPatient, cinPraticien, dateHeureStr, statut, idRdvParent, false);
                    }
                }
            } catch (SQLException e) {
                handleSQLException(e, request, response, "/Components/RendezVous/FrmRendezVous.jsp", 
                                 null, cinPatient, cinPraticien, dateHeureStr, statut, idRdvParent, false);
            }
        } catch (Exception e) {
            redirectWithFormData(request, response, "/Components/RendezVous/FrmRendezVous.jsp", "date_invalide", 
                              null, cinPatient, cinPraticien, dateHeureStr, statut, idRdvParent, false);
        }
    }

    private void updateRendezVous(HttpServletRequest request, HttpServletResponse response) 
        throws IOException, ServletException {
        // Récupération des paramètres
        String idRdv = getTrimmedParameter(request, "idRdv");
        String cinPatient = getTrimmedParameter(request, "cinPatient");
        String cinPraticien = getTrimmedParameter(request, "cinPraticien");
        String dateHeureStr = getTrimmedParameter(request, "dateHeure");
        String statut = getTrimmedParameter(request, "statut");
        String idRdvParent = getTrimmedParameter(request, "idRdvParent");

        // Debug des paramètres reçus
        System.out.println("Paramètres reçus pour mise à jour:");
        System.out.println("idRdv: " + idRdv);
        System.out.println("cinPatient: " + cinPatient);
        System.out.println("cinPraticien: " + cinPraticien);
        System.out.println("dateHeure: " + dateHeureStr);
        System.out.println("statut: " + statut);
        System.out.println("idRdvParent: " + idRdvParent);

        // Vérification des champs obligatoires
        if (areParametersEmpty(idRdv, cinPatient, cinPraticien, dateHeureStr, statut)) {
            System.out.println("Erreur: Champs obligatoires manquants");
            redirectWithFormData(request, response, "/Components/RendezVous/FrmRendezVous.jsp", 
                              "champs_vides", idRdv, cinPatient, cinPraticien, 
                              dateHeureStr, statut, idRdvParent, true);
            return;
        }

        // Validation du statut
        if (!isValidStatut(statut)) {
            System.out.println("Erreur: Statut invalide");
            redirectWithFormData(request, response, "/Components/RendezVous/FrmRendezVous.jsp", 
                              "statut_invalide", idRdv, cinPatient, cinPraticien, 
                              dateHeureStr, statut, idRdvParent, true);
            return;
        }

        try {
            // Conversion de la date
            System.out.println("Tentative de parsing de la date: " + dateHeureStr);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            Date dateHeure = sdf.parse(dateHeureStr);
            Timestamp dateHeureTimestamp = new Timestamp(dateHeure.getTime());

            System.out.println("Date parsée avec succès: " + dateHeureTimestamp);

            // Vérification que la date n'est pas dans le passé
            if (dateHeure.before(new Date())) {
                System.out.println("Erreur: Date dans le passé");
                redirectWithFormData(request, response, "/Components/RendezVous/FrmRendezVous.jsp", 
                                  "date_passee", idRdv, cinPatient, cinPraticien, 
                                  dateHeureStr, statut, idRdvParent, true);
                return;
            }

            try (Connection conn = DB_Connexion.getConnection()) {
                if (conn == null) {
                    System.out.println("Erreur: Connexion DB impossible");
                    redirectWithFormData(request, response, "/Components/RendezVous/FrmRendezVous.jsp", 
                                      "connexion_bdd", idRdv, cinPatient, cinPraticien, 
                                      dateHeureStr, statut, idRdvParent, true);
                    return;
                }

                // Vérification que le patient existe
                if (!isPatientExists(conn, cinPatient)) {
                    System.out.println("Erreur: Patient inexistant");
                    redirectWithFormData(request, response, "/Components/RendezVous/FrmRendezVous.jsp", 
                                      "patient_invalide", idRdv, cinPatient, cinPraticien, 
                                      dateHeureStr, statut, idRdvParent, true);
                    return;
                }

                // Vérification que le praticien existe
                if (!isPraticienExists(conn, cinPraticien)) {
                    System.out.println("Erreur: Praticien inexistant");
                    redirectWithFormData(request, response, "/Components/RendezVous/FrmRendezVous.jsp", 
                                      "praticien_invalide", idRdv, cinPatient, cinPraticien, 
                                      dateHeureStr, statut, idRdvParent, true);
                    return;
                }

                // Vérification du RDV parent s'il est spécifié
                if (!idRdvParent.isEmpty() && !isRdvParentValid(conn, idRdvParent)) {
                    System.out.println("Erreur: RDV parent invalide");
                    redirectWithFormData(request, response, "/Components/RendezVous/FrmRendezVous.jsp", 
                                      "rdv_parent_invalide", idRdv, cinPatient, cinPraticien, 
                                      dateHeureStr, statut, idRdvParent, true);
                    return;
                }

                // Vérification des conflits de rendez-vous pour le patient
                if (hasPatientRdvAtSameTime(conn, cinPatient, dateHeureTimestamp, idRdv)) {
                    System.out.println("Erreur: Conflit de RDV pour le patient");
                    redirectWithFormData(request, response, "/Components/RendezVous/FrmRendezVous.jsp", 
                                      "conflit_rdv_patient", idRdv, cinPatient, cinPraticien, 
                                      dateHeureStr, statut, idRdvParent, true);
                    return;
                }

                // Vérification des conflits de rendez-vous pour le praticien
                if (hasPraticienRdvAtSameTime(conn, cinPraticien, dateHeureTimestamp, idRdv)) {
                    System.out.println("Erreur: Conflit de RDV pour le praticien");
                    redirectWithFormData(request, response, "/Components/RendezVous/FrmRendezVous.jsp", 
                                      "conflit_rdv_praticien", idRdv, cinPatient, cinPraticien, 
                                      dateHeureStr, statut, idRdvParent, true);
                    return;
                }

                // Mise à jour du rendez-vous
                String sql = "UPDATE rendezvous SET cinPatient=?, cinPraticien=?, dateHeure=?, statut=?, idRdvParent=? WHERE idRdv=?";
                System.out.println("Requête SQL: " + sql);

                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, cinPatient);
                    stmt.setString(2, cinPraticien);
                    stmt.setTimestamp(3, dateHeureTimestamp);
                    stmt.setString(4, statut);
                    stmt.setString(5, idRdvParent.isEmpty() ? null : idRdvParent);
                    stmt.setInt(6, Integer.parseInt(idRdv));

                    System.out.println("Paramètres de la requête:");
                    System.out.println("1. cinPatient: " + cinPatient);
                    System.out.println("2. cinPraticien: " + cinPraticien);
                    System.out.println("3. dateHeure: " + dateHeureTimestamp);
                    System.out.println("4. statut: " + statut);
                    System.out.println("5. idRdvParent: " + (idRdvParent.isEmpty() ? "NULL" : idRdvParent));
                    System.out.println("6. idRdv: " + idRdv);

                    int rowsAffected = stmt.executeUpdate();
                    System.out.println("Lignes affectées: " + rowsAffected);

                    if (rowsAffected > 0) {
                        System.out.println("Mise à jour réussie");
                        redirectWithSuccess(request, response, "/Components/RendezVous/indexRendezVous.jsp", "update");
                    } else {
                        System.out.println("Erreur: Aucune ligne mise à jour");
                        redirectWithFormData(request, response, "/Components/RendezVous/FrmRendezVous.jsp", 
                                          "rendezvous_non_trouve", idRdv, cinPatient, cinPraticien, 
                                          dateHeureStr, statut, idRdvParent, true);
                    }
                }
            } catch (SQLException e) {
                System.out.println("Erreur SQL: " + e.getMessage());
                handleSQLException(e, request, response, "/Components/RendezVous/FrmRendezVous.jsp", 
                                 idRdv, cinPatient, cinPraticien, dateHeureStr, statut, idRdvParent, true);
            }
        } catch (java.text.ParseException e) {
            System.out.println("Erreur de parsing de date: " + e.getMessage());
            redirectWithFormData(request, response, "/Components/RendezVous/FrmRendezVous.jsp", 
                              "date_invalide", idRdv, cinPatient, cinPraticien, 
                              dateHeureStr, statut, idRdvParent, true);
        } catch (Exception e) {
            System.out.println("Erreur inattendue: " + e.getMessage());
            e.printStackTrace();
            redirectWithFormData(request, response, "/Components/RendezVous/FrmRendezVous.jsp", 
                              "erreur_systeme", idRdv, cinPatient, cinPraticien, 
                              dateHeureStr, statut, idRdvParent, true);
        }
    }

    private void deleteRendezVous(HttpServletRequest request, HttpServletResponse response) 
        throws IOException, ServletException {
        String idRdv = getTrimmedParameter(request, "idRdv");
        if (idRdv.isEmpty()) {
            redirectWithError(request, response, "/Components/RendezVous/indexRendezVous.jsp", "id_rdv_manquant");
            return;
        }

        try (Connection conn = DB_Connexion.getConnection()) {
            if (conn == null) {
                redirectWithError(request, response, "/Components/RendezVous/indexRendezVous.jsp", "connexion_bdd");
                return;
            }

            // Vérification si le RDV a des enfants
            if (hasRdvChildren(conn, idRdv)) {
                redirectWithError(request, response, "/Components/RendezVous/indexRendezVous.jsp", "rdv_avec_enfants");
                return;
            }

            // Suppression du rendez-vous
            String deleteSql = "DELETE FROM rendezvous WHERE idRdv = ?";
            try (PreparedStatement deleteStmt = conn.prepareStatement(deleteSql)) {
                deleteStmt.setInt(1, Integer.parseInt(idRdv));

                // Debug
                System.out.println("Tentative de suppression du RDV ID: " + idRdv);

                int rowsAffected = deleteStmt.executeUpdate();

                if (rowsAffected > 0) {
                    System.out.println("Suppression réussie du RDV ID: " + idRdv);
                    redirectWithSuccess(request, response, "/Components/RendezVous/indexRendezVous.jsp", "delete");
                } else {
                    System.out.println("Aucun RDV trouvé avec ID: " + idRdv);
                    redirectWithError(request, response, "/Components/RendezVous/indexRendezVous.jsp", "rendezvous_non_trouve");
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur SQL lors de la suppression: " + e.getMessage());
            e.printStackTrace();
            redirectWithError(request, response, "/Components/RendezVous/indexRendezVous.jsp", "erreur_suppression");
        } catch (NumberFormatException e) {
            System.err.println("ID RDV invalide: " + idRdv);
            redirectWithError(request, response, "/Components/RendezVous/indexRendezVous.jsp", "id_rdv_invalide");
        } catch (Exception e) {
            System.err.println("Erreur inattendue: " + e.getMessage());
            e.printStackTrace();
            redirectWithError(request, response, "/Components/RendezVous/indexRendezVous.jsp", "erreur_systeme");
        }
    }
    
    private void getRdvParentsList(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        String cinPatient = request.getParameter("cinPatient");
        if (cinPatient == null || cinPatient.trim().isEmpty()) {
            redirectWithError(request, response, "/Components/RendezVous/FrmRendezVous.jsp", "patient_invalide");
            return;
        }

        try (Connection conn = DB_Connexion.getConnection()) {
            String sql = "SELECT idRdv, dateHeure FROM rendezvous WHERE cinPatient = ? AND idRdvParent IS NULL ORDER BY dateHeure DESC";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, cinPatient);
                ResultSet rs = stmt.executeQuery();
                List<Map<String, String>> rdvParents = new ArrayList<>();

                while (rs.next()) {
                    Map<String, String> rdv = new HashMap<>();
                    rdv.put("idRdv", rs.getString("idRdv"));
                    rdv.put("dateHeure", new SimpleDateFormat("dd/MM/yyyy HH:mm").format(rs.getTimestamp("dateHeure")));
                    rdvParents.add(rdv);
                }

                request.setAttribute("rdvParents", rdvParents);
                request.getRequestDispatcher("/Components/RendezVous/selectRdvParents.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            redirectWithError(request, response, "/Components/RendezVous/FrmRendezVous.jsp", "erreur_systeme");
        }
    }

    // ==================== MÉTHODES UTILITAIRES ====================
    
    private void loadPatientsForForm(HttpServletRequest request) {
        List<Map<String, String>> patients = new ArrayList<>();

        try (Connection conn = DB_Connexion.getConnection()) {
            String sql = "SELECT cinPatient, nom, prenom FROM patients ORDER BY nom, prenom";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                ResultSet rs = stmt.executeQuery();

                while (rs.next()) {
                    Map<String, String> patient = new HashMap<>();
                    patient.put("cinPatient", rs.getString("cinPatient"));
                    patient.put("nom", rs.getString("nom"));
                    patient.put("prenom", rs.getString("prenom"));
                    patients.add(patient);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("patients", patients);
    }

    private void loadPraticiensForForm(HttpServletRequest request) {
        List<Map<String, String>> praticiens = new ArrayList<>();

        try (Connection conn = DB_Connexion.getConnection()) {
            String sql = "SELECT cinPraticien, nom, prenom, specialite FROM praticiens ORDER BY nom, prenom";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                ResultSet rs = stmt.executeQuery();

                while (rs.next()) {
                    Map<String, String> praticien = new HashMap<>();
                    praticien.put("cinPraticien", rs.getString("cinPraticien"));
                    praticien.put("nom", rs.getString("nom"));
                    praticien.put("prenom", rs.getString("prenom"));
                    praticien.put("specialite", rs.getString("specialite"));
                    praticiens.add(praticien);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("praticiens", praticiens);
    }

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

    private boolean isValidStatut(String statut) {
        return statut != null && 
               (statut.equals("en_attente") || 
                statut.equals("confirme") || 
                statut.equals("annule") || 
                statut.equals("termine"));
    }

    private boolean isRdvExists(Connection conn, String idRdv) throws SQLException {
        String checkSql = "SELECT COUNT(*) FROM rendezvous WHERE idRdv = ?";
        try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
            checkStmt.setString(1, idRdv);
            try (ResultSet rs = checkStmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    private boolean isPatientExists(Connection conn, String cinPatient) throws SQLException {
        String sql = "SELECT COUNT(*) FROM patients WHERE cinPatient = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, cinPatient);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    private boolean isPraticienExists(Connection conn, String cinPraticien) throws SQLException {
        String sql = "SELECT COUNT(*) FROM praticiens WHERE cinPraticien = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, cinPraticien);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    private boolean isRdvParentValid(Connection conn, String idRdvParent) throws SQLException {
        String sql = "SELECT COUNT(*) FROM rendezvous WHERE idRdv = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, idRdvParent);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    private boolean hasPatientRdvAtSameTime(Connection conn, String cinPatient, Timestamp dateHeure, String excludeIdRdv) throws SQLException {
        String sql = "SELECT COUNT(*) FROM rendezvous WHERE cinPatient = ? AND dateHeure = ?";
        if (excludeIdRdv != null && !excludeIdRdv.isEmpty()) {
            sql += " AND idRdv != ?";
        }

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, cinPatient);
            stmt.setTimestamp(2, dateHeure);
            if (excludeIdRdv != null && !excludeIdRdv.isEmpty()) {
                stmt.setInt(3, Integer.parseInt(excludeIdRdv));
            }

            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    private boolean hasPraticienRdvAtSameTime(Connection conn, String cinPraticien, Timestamp dateHeure, String excludeIdRdv) throws SQLException {
        String sql = "SELECT COUNT(*) FROM rendezvous WHERE cinPraticien = ? AND dateHeure = ?";
        if (excludeIdRdv != null && !excludeIdRdv.isEmpty()) {
            sql += " AND idRdv != ?";
        }

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, cinPraticien);
            stmt.setTimestamp(2, dateHeure);
            if (excludeIdRdv != null && !excludeIdRdv.isEmpty()) {
                stmt.setInt(3, Integer.parseInt(excludeIdRdv));
            }

            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
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
            String idRdv, String cinPatient, String cinPraticien, String dateHeure, 
            String statut, String idRdvParent, boolean isEdit) throws IOException, ServletException {
        
        // Charger les listes nécessaires pour le formulaire
        loadPraticiensForForm(request);
        loadPatientsForForm(request);
        
        // Stocker les attributs dans la requête
        request.setAttribute("error", error);
        request.setAttribute("idRdv", idRdv);
        request.setAttribute("cinPatient", cinPatient);
        request.setAttribute("cinPraticien", cinPraticien);
        request.setAttribute("dateHeure", dateHeure);
        request.setAttribute("statut", statut);
        request.setAttribute("idRdvParent", idRdvParent);
        request.setAttribute("edit", isEdit ? "true" : "false");
        
        // Transférer à la JSP
        try {
            request.getRequestDispatcher(path).forward(request, response);
        } catch (ServletException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + path + "?error=erreur_systeme");
        }
    }

    private void handleSQLException(Exception e, HttpServletRequest request, 
        HttpServletResponse response, String path, String additionalParams) throws IOException, ServletException {
        handleSQLException(e, request, response, path, null, null, null, null, null, null, false);
    }

    private void handleSQLException(Exception e, HttpServletRequest request, 
        HttpServletResponse response, String path, 
        String idRdv, String cinPatient, String cinPraticien, String dateHeure, 
        String statut, String idRdvParent, boolean isEdit) throws IOException, ServletException {
        
        e.printStackTrace();
        String errorMessage = "erreur_systeme";
        
        if (e instanceof SQLException) {
            SQLException sqlEx = (SQLException) e;
            if (sqlEx.getMessage().contains("constraint")) {
                if (sqlEx.getMessage().contains("foreign key")) {
                    if (sqlEx.getMessage().contains("cinPatient")) {
                        errorMessage = "patient_invalide";
                    } else if (sqlEx.getMessage().contains("cinPraticien")) {
                        errorMessage = "praticien_invalide";
                    } else if (sqlEx.getMessage().contains("idRdvParent")) {
                        errorMessage = "rdv_parent_invalide";
                    } else {
                        errorMessage = "patient_lie_a_autre_table";
                    }
                } else if (sqlEx.getMessage().contains("primary key") || sqlEx.getMessage().contains("duplicate")) {
                    errorMessage = "rdv_existe_deja";
                }
            }
        }
        
        if (path.equals("/Components/RendezVous/FrmRendezVous.jsp")) {
            redirectWithFormData(request, response, path, errorMessage, 
                              idRdv, cinPatient, cinPraticien, dateHeure, statut, idRdvParent, isEdit);
        } else {
            redirectWithError(request, response, path, errorMessage, additionalParams);
        }
    }

    private boolean hasRdvChildren(Connection conn, String idRdv) throws SQLException {
        String sql = "SELECT COUNT(*) FROM rendezvous WHERE idRdvParent = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, idRdv);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }
}