<%@page import="java.text.ParseException"%>
<!--Mon Css-->
<style>
    /*Container*/
    /* =========== CONTENT ========== */
        #content{
            position: relative;
            width: calc(100% - 280px);
            left: 280px;
            transition: .3s ease;
        }

        #sidebar.hide ~ #content{
            width: calc(100% - 54px);
            left: 54px;
        }

        /* ----- NAVBAR ----- */
        #content nav{
            height: 56px;
            background: #dedee980;
            padding: 0 24px;
            display: flex;
            align-items: center;
            grid-gap: 24px;
            font-family: 'Lato', sans-serif;
            position: sticky;
            top: 0;
            left: 0;
            z-index: 1000;
        }

        .admin-nom{
            color: #181718;
        }
        .admin-grad{
            color: #2d2e30;
        }

        #content nav::before{
            content: '';
            position: absolute;
            width: 40px;
            height: 40px;
            /* background: var(--blue); */
            bottom: -40px;
            left: 0;
            border-radius: 50%;
            box-shadow: -20px -20px 0 var(--light);
        }

        #content nav a{
            /* color: var(--dark); */
            color: #181718;
        }

        #content nav .bx.bx-menu{
            cursor: pointer;
        }

        #content nav .nav-link{
            font-size: 16px;
            transition: .3s ease;
        }

        #content nav .nav-link:hover{
            color: #3c91e6;
        }

        #content nav form{
            max-width: 400px;
            width: 100%;
            margin-right: auto;
        }

        #content nav form .form-input{
            display: flex;
            align-items: center;
            height: 36px;
        }

        #content nav form .form-input input{
            flex-grow: 1;
            padding: 0 16px;
            height: 100%;
            border: none;
            background: #fff;
            color: #181718;
            border-radius: 36px 0 0 36px;
            outline: none;
            width: 100%;
        }

        #content nav form .form-input button{
            width: 36px;
            height: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
            background: #fff;
            color: black;
            font-size: 18px;
            border: none;
            outline: none;
            border-radius: 0 36px 36px 0;
            cursor: pointer;
        }

        #content nav .notification{
            font-size: 20px;
            position: relative;
        }

        #content nav .notification .num{
            position: absolute;
            top: -6px;
            right: -6px;
            width: 20px;
            height: 20px;
            border-radius: 50%;
            border: 2px solid var(--light);
            background: #db504a;
            color: #f9f9f9;
            font-weight: 700;
            font-size: 11px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        #content nav .profile img{
            width: 36px;
            height: 36px;
            object-fit: cover;
            border-radius: 50%;
        }
        /* ----- FIN NAVBAR ----- */

        .right .top {
            display: flex;
            justify-content: end;
            gap: 2rem;
        }

        .them, .menu{
            font-size: 23px;
            color: #181718
        }
        
        
        
        /* --------- Main ---------- */
        #content main{
            width: 100%;
            padding: 36px 24px;
            font-family: 'Poppins', sans-serif;
            max-height: calc(100vh - 56px);
            overflow-y: auto;
        }
        #content main .head-title{
            display: flex;
            align-items: center;
            justify-content: space-between;
            grid-gap: 16px;
            flex-wrap: wrap;
        }

        #content main .head-title .left h1{
            font-size: 36px;
            font-weight: 600;
            margin-bottom: 10px;
            color: #342e37;
        }

        #content main .head-title .left .breadcrumb{
            display: flex;
            align-items: center;
            grid-gap: 16px;
        }

        #content main .head-title .left .breadcrumb li{
            color: #342e37;
        }

        #content main .head-title .left .breadcrumb li a{
            color: #3f3e3e;
            pointer-events: none;
        }

        #content main .head-title .left .breadcrumb li a.active{
            color: #8fafcf;
            pointer-events: unset;
        }

        #content main .head-title .btn-download{
            height: 36px;
            padding: 0 16px;
            border-radius: 36px;
            background: #3c91e6;
            color: #f9f9f9;
            display: flex;
            align-items: center;
            justify-content: center;
            grid-gap: 10px;
            font-weight: 500;
        }



        #content main .box-info{
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            grid-gap: 24px;
            margin-top: 36px;
        }

        #content main .box-info li{
            padding: 24px;
            background: #f9f9f9;
            border-radius: 20px;
            display: flex;
            align-items: center;
            grid-gap: 24px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.170);
        }

        #content main .box-info li .bx{
            width: 80px;
            height: 80px;
            border-radius: 10px;
            /* background: var(--grey); */
            font-size: 36px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .txt-box-top{
            color: black;
        }

        .txt-box-bottom{
            color: rgb(30, 30, 30);
        }

        #content main .box-info li:nth-child(1) .bx{
            background: #cfe8ff;
            color: #3c91e6;
        }

        #content main .box-info li:nth-child(2) .bx{
            background: rgb(189, 173, 108);
            color: rgb(68, 67, 46);
        }

        #content main .box-info li:nth-child(3) .bx{
            background: rgb(230, 175, 112);
            color: rgb(190, 120, 39);
        }

        #content main .box-info li .text h3{
            font-size: 24px;
            font-weight: 600;
        }



        #content main .table-date{
            display: flex;
            flex-wrap: wrap;
            grid-gap: 24px;
            margin-top: 24px;
            width: 100%;
            color: #342e37;
        }

        #content main .table-date > div {
            border-radius: 20px;
            background: #f9f9f9;
            padding: 24px;
            overflow: auto;
        }

        #content main .table-date .orber{
            flex-grow: 1;
            flex-basis: 500px;
        }

        #content main .table-date .head{
            display: flex;
            align-items: center;
            grid-gap: 16px;
            margin-bottom: 24px;
        }

        .thead{
            color: #1d1e1f;
            letter-spacing: 1px;
        }

        .tbody{
            color: #dbdbec;
        }

        .todo-color{
            color: rgb(170, 167, 170);
        }

        #content main .table-date .head h3{
            margin-right: auto;
            font-size: 24px;
            font-weight: 600;
            color: #342e37;
        }

        .icon-tbl{
            color: #1b1b1d;
        }

        #content main .table-date .head .bx{
            cursor: pointer;
        }

        #content main .table-date .orber table{
            width: 100%;
            border-collapse: collapse;
        }

        #content main .table-date .orber table th{
            padding-bottom: 12px;
            font-size: 13px;
            text-align: left;
            border-bottom: 1px solid var(--grey);
        }

        #content main .table-date .orber table td{
            padding: 16px 0;
        }

        #content main .table-date .orber table tr td:first-child{
            display: flex;
            align-items: center;
            grid-gap: 12px;
            padding-left: 6px;
        }

        #content main .table-date .orber table td img{
            width: 36px;
            height: 36px;
            border-radius: 50%;
            object-fit: cover;
        }

        #content main .table-date .orber table tbody tr:hover{
            background: #EEE;
        }

        #content main .table-date .orber table tr td .status{
            font-size: 10px;
            padding: 6px 16px;
            color: #f9f9f9;
            border-radius: 20px;
            font-weight: 700;
        }

        #content main .table-date .orber table tr td .status.completed{
            background: #3c91e6;
        }

        #content main .table-date .orber table tr td .status.process{
            background: rgb(204, 201, 38);
        }

        #content main .table-date .orber table tr td .status.pending{
            background: rgb(190, 120, 39);
        }

        #content main .table-date .todo{
            flex-grow: 1;
            flex-basis: 300px;
        }

        #content main .table-date .todo .todo-list{
            width: 100%;
        }

        #content main .table-date .todo .todo-list li{
            width: 100%;
            margin-bottom: 16px;
            background: #EEE;
            border-radius: 10px;
            padding: 14px 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        #content main .table-date .todo .todo-list li .bx{
            cursor: pointer;
        }

        #content main .table-date .todo .todo-list li.completed{
            border-left: 10px solid var(--blue);
        }

        #content main .table-date .todo .todo-list li.not-completed{
            border-left: 10px solid var(--orange);
        }

        #content main .table-date .todo .todo-list li:last-child{
            margin-bottom: 0;
        }
</style>


<!--Css Pour Frm-->
<style>
    /* Conteneur principal */
    .container-frm-empl {
        background: #ffffff;
        border-radius: 16px;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        padding: 2rem;
        max-width: 100%;
        margin: 2rem auto;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        transition: all 0.3s ease;
    }
    
    /* Style spécifique pour le champ textearea */
    .input-field-div.textarea-field {
        grid-column: 1 / -1; /* Prend toute la largeur disponible */
        margin-bottom: 1.5rem;
    }

    .input-field-div.textarea-field textarea {
        width: 100%;
        padding: 1rem;
        font-size: 0.95rem;
        border: 1px solid #e2e8f0;
        border-radius: 8px;
        background-color: #f8fafc;
        transition: all 0.3s ease;
        color: #1a202c;
        resize: vertical; /* Permet le redimensionnement vertical seulement */
        min-height: 150px !important;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        line-height: 1.5;
    }

    .input-field-div.textarea-field textarea:focus {
        outline: none;
        border-color: #3c91e6;
        box-shadow: 0 0 0 3px rgba(60, 145, 230, 0.2);
        background-color: #ffffff;
    }

    .input-field-div.textarea-field textarea::placeholder {
        color: #a0aec0;
        opacity: 1;
    }

    /* Animation spécifique pour le textarea */
    .input-field-div.textarea-field {
        animation: fadeIn 0.6s ease-out forwards;
        animation-delay: 0.6s;
    }

    /* Responsive pour le textarea */
    @media (max-width: 768px) {
        .input-field-div.textarea-field textarea {
            min-height: 120px;
        }
    }
    
    header{
        text-transform: uppercase;
    }

    .container-frm-empl:hover {
        box-shadow: 0 12px 40px rgba(0, 0, 0, 0.15);
    }
    
    .top-header{
        display: flex;
        align-items: center;
        justify-content: space-between;
    }
    
    .top-header img{
        width: 40px;
        height: 40px;
        object-fit: cover;
        border-radius: 50%;
    }

    /* En-tête */
    .container-frm-empl header {
        font-size: 1.8rem;
        font-weight: 600;
        color: #3c91e6;
        text-align: left;
        margin-bottom: 1.5rem;
        position: relative;
        padding-bottom: 0.5rem;
    }

    /* Formulaire */
    .container-frm-empl form {
        margin-top: 1.5rem;
    }

    /* Titre de section */
    .details .title {
        display: block;
        font-size: 1.2rem;
        font-weight: 500;
        color: #4a5568;
        margin-bottom: 1.5rem;
        padding-bottom: 0.5rem;
        border-bottom: 1px solid #e2e8f0;
    }

    /* Grille des champs */
    .fields {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 1.5rem;
        margin-bottom: 2rem;
    }

    /* Conteneur de champ */
    .input-field-div {
        position: relative;
        margin-bottom: 0.5rem;
    }

    /* Labels */
    .input-field-div label {
        display: block;
        font-size: 0.9rem;
        font-weight: 500;
        color: #4a5568;
        margin-bottom: 0.5rem;
    }

    /* Champs de formulaire */
    .input-field-div input {
        width: 100%;
        padding: 0.8rem 1rem;
        font-size: 0.95rem;
        border: 1px solid #e2e8f0;
        border-radius: 8px;
        background-color: #f8fafc;
        transition: all 0.3s ease;
        color: #1a202c;
    }

    .input-field-div input:focus {
        outline: none;
        border-color: #3c91e6;
        box-shadow: 0 0 0 3px rgba(60, 145, 230, 0.2);
        background-color: #ffffff;
    }

    .input-field-div input::placeholder {
        color: #a0aec0;
        opacity: 1;
    }

    /* Bouton */
    .nextBtn {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        padding: 0.8rem 1.5rem;
        background: linear-gradient(135deg, #3c91e6, #5aa1ff);
        color: white;
        border: none;
        border-radius: 8px;
        font-size: 1rem;
        font-weight: 500;
        cursor: pointer;
        transition: all 0.3s ease;
        margin-top: 1rem;
        width: 100%;
        box-shadow: 0 4px 6px rgba(60, 145, 230, 0.2);
    }

    .nextBtn:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 12px rgba(60, 145, 230, 0.25);
        background: linear-gradient(135deg, #3684d4, #4f94e8);
    }

    .nextBtn:active {
        transform: translateY(0);
    }

    .nextBtn .btnText {
        margin-right: 0.5rem;
    }

    .nextBtn i {
        font-size: 1.2rem;
    }

    /* Animation des champs */
    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(10px); }
        to { opacity: 1; transform: translateY(0); }
    }

    .input-field-div {
        animation: fadeIn 0.4s ease-out forwards;
        opacity: 0;
    }

    .input-field-div:nth-child(1) { animation-delay: 0.1s; }
    .input-field-div:nth-child(2) { animation-delay: 0.2s; }
    .input-field-div:nth-child(3) { animation-delay: 0.3s; }
    .input-field-div:nth-child(4) { animation-delay: 0.4s; }
    .input-field-div:nth-child(5) { animation-delay: 0.5s; }

    /* Responsive */
    @media (max-width: 768px) {
        .container-frm-empl {
            padding: 1.5rem;
            margin: 1rem;
        }

        .fields {
            grid-template-columns: 1fr;
        }

        .nextBtn {
            width: 100%;
        }
    }
</style>

<!--Mon Css Footer-->
<style>
    /*Fotter*/
    .footer{
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-items: center;
        padding: 1.5rem 3%;
        margin-bottom: 0;
        margin-top: 2rem;
        background: #dedee980;
        color: #000;
    }

    .footer-text p{
        font-size: 1.3rem;
    }

    .footer-iconTop a{
        display: inline-block;
        justify-content: center;
        align-items: center;
        padding: 0.8rem;
        background: #3c91e6;
        border-radius: .8rem;
        transition: .5s ease;
    }

    .footer-iconTop a:hover{
        box-shadow: 0 0 1rem #3c91e6;
    }

    .footer-iconTop a i{
        font-size: 1.7rem;
        color: #fff;
    }
    
    @media (max-width: 365px){
        .footer{
            flex-direction: column-reverse;
        }

        .footer p{
            text-align: center;
            margin-top: 2rem;
        }
    }
</style>

<!--Css Pour Liste de déroulantes-->
<style>
    /* Styles pour les menus déroulants */
    .form-select {
        width: 100%;
        padding: 0.8rem 1rem;
        font-size: 0.95rem;
        border: 1px solid #e2e8f0;
        border-radius: 8px;
        background-color: #f8fafc;
        transition: all 0.3s ease;
        color: #1a202c;
        appearance: none;
        background-repeat: no-repeat;
        background-position: right 1rem center;
        background-size: 16px 12px;
        cursor: pointer;
    }

    .form-select:focus {
        outline: none;
        border-color: #3c91e6;
        box-shadow: 0 0 0 3px rgba(60, 145, 230, 0.2);
        background-color: #ffffff;
    }

    /* Style des options */
    .form-select option {
        padding: 0.5rem;
        background-color: white;
        color: #1a202c;
    }

    .form-select option:checked {
        background-color: #3c91e6;
        color: white;
    }

    /* Style pour le hover des options (fonctionne dans certains navigateurs) */
    .form-select option:hover {
        background-color: #ebf4ff;
    }

    /* Style personnalisé pour le conteneur du select */
    .input-field-div select {
        width: 100%;
        padding: 0.8rem 1rem;
        font-size: 0.95rem;
        border: 1px solid #e2e8f0;
        border-radius: 8px;
        background-color: #f8fafc;
        transition: all 0.3s ease;
        color: #1a202c;
        appearance: none;
        background-repeat: no-repeat;
        background-position: right 1rem center;
        background-size: 16px 12px;
        cursor: pointer;
    }

    .input-field-div select:focus {
        outline: none;
        border-color: #3c91e6;
        box-shadow: 0 0 0 3px rgba(60, 145, 230, 0.2);
        background-color: #ffffff;
    }

    /* Style pour le conteneur du select avec animation */
    .input-field-div {
        position: relative;
        margin-bottom: 1.5rem;
        animation: fadeIn 0.4s ease-out forwards;
        opacity: 0;
    }

    /* Animation spécifique pour chaque select */
    .input-field-div:nth-child(1) { animation-delay: 0.1s; }
    .input-field-div:nth-child(2) { animation-delay: 0.2s; }
    .input-field-div:nth-child(3) { animation-delay: 0.3s; }
    .input-field-div:nth-child(4) { animation-delay: 0.4s; }

    /* Style pour le pseudo-élément flèche (alternative) */
    .input-field-div::after {
        /*content: "";*/
        position: absolute;
        top: 50%;
        right: 1rem;
        width: 0;
        height: 0;
        pointer-events: none;
        border-left: 6px solid transparent;
        border-right: 6px solid transparent;
        border-top: 6px solid #4a5568;
        transform: translateY(-50%);
    }

    /* Style pour le hover */
    .input-field-div:hover select {
        border-color: #cbd5e0;
    }

    /* Style pour les options groupées */
    optgroup {
        font-weight: 600;
        color: #4a5568;
        background-color: #f8fafc;
    }

    /* Style pour les options désactivées */
    option:disabled {
        color: #a0aec0;
        background-color: #f8fafc;
    }

    /* Style pour le focus-visible (accessibilité) */
    .form-select:focus-visible {
        outline: 2px solid #3c91e6;
        outline-offset: 2px;
    }
</style>


<!--Css pour  les messages d'erreur ou Notification-->
<style>
    /* Style pour les messages d'erreur */
    .alert-error {
        padding: 1rem;
        margin-bottom: 1.5rem;
        border-radius: 8px;
        font-size: 0.95rem;
        display: flex;
        align-items: center;
        animation: fadeIn 0.3s ease-out;
    }

    /* Style spécifique pour l'erreur "livre indisponible" */
    .alert-error[data-error="livre_indisponible"] {
        background-color: #fff4f4;
        border-left: 4px solid #ff5252;
        color: #ff5252;
        box-shadow: 0 2px 8px rgba(255, 82, 82, 0.1);
    }

    /* Icône pour le message d'erreur */
    .alert-error[data-error="livre_indisponible"]::before {
        content: "⚠️";
        margin-right: 0.75rem;
        font-size: 1.2rem;
    }

    /* Animation pour l'apparition du message */
    @keyframes fadeIn {
        from {
            opacity: 0;
            transform: translateY(-10px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    /* Bouton de fermeture optionnel */
    .alert-error .close-btn {
        margin-left: auto;
        background: none;
        border: none;
        color: inherit;
        cursor: pointer;
        font-size: 1.1rem;
        opacity: 0.7;
        transition: opacity 0.2s;
    }

    .alert-error .close-btn:hover {
        opacity: 1;
    }
</style>


<!--Css Message Erreur-->
<style>
    .alert-error {
        position: relative;
        margin: 20px auto;
        max-width: 100%;
        padding: 15px 25px;
        background-color: #ffe5e5;
        color: #d8000c;
        border-left: 6px solid #d8000c;
        border-radius: 10px;
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
        font-family: 'Segoe UI', sans-serif;
        font-size: 16px;
        animation: fadeIn 0.4s ease;
    }

    .close-btn {
        position: absolute;
        top: 8px;
        right: 12px;
        background: none;
        border: none;
        font-size: 20px;
        color: #d8000c;
        cursor: pointer;
    }

    @keyframes fadeIn {
        from {
            opacity: 0;
            transform: translateY(-10px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
</style>


<style>
    .rotation {
        transform: rotate(90deg);
        transform-origin: center;
        display: inline-block;
    }
    
    .color {
        color: #333 !important;
    }
    
    .flex{
        display: flex;
        align-items: center;
        justify-content: space-between;
    }
    
    .btn-annul {
        display: inline-block; /* Pour garder la div ajustée au contenu */
      }

      .btn-annul .cancelBtn {
        display: inline-flex;
        align-items: center;
        gap: 8px; /* Espace entre le texte et l’icône */
        padding: 10px 20px;
        background-color: #f44336; /* Rouge d’annulation */
        color: #fff;
        text-decoration: none;
        border-radius: 5px;
        transition: background-color 0.3s ease, transform 0.2s ease;
      }

      .btn-annul .cancelBtn:hover {
        background-color: #d32f2f; /* Teinte plus foncée au survol */
        transform: scale(1.05); /* Léger zoom au survol */
      }

      .btn-annul .btnText {
        font-size: 17px;
      }

      .btn-annul i {
        font-size: 18px;
      }

</style>


<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.sql.*" %>
<%@ page import="Bibliotheque.DB_Connexion" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>

<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>WiFre</title>
    </head>
    <body>        
        <!--SidBar et NavBar-->
        <jsp:include page="/Components/SidBar/NavSidBar.jsp" />
        
        <section id="content">
            <%
                String editMode = request.getParameter("edit");
                boolean isEditMode = "true".equals(editMode);

                // Initialisation des variables
                String idConsult = "";
                String idRdv = "";
                String dateConsultValue = "";
                String compteRendu = "";

                // Récupérer la liste des rendez-vous confirmés avec noms et prénoms
                java.util.List<java.util.Map<String, String>> rdvList = new java.util.ArrayList<>();
                Connection conn = null;
                try {
                    conn = DB_Connexion.getConnection();
                    if (conn != null) {
                        String sql = "SELECT r.idRdv, r.dateHeure, r.cinPatient, r.cinPraticien, " +
                                    "p.nom AS nomPatient, p.prenom AS prenomPatient, " +
                                    "pr.nom AS nomPraticien, pr.prenom AS prenomPraticien " +
                                    "FROM rendezvous r " +
                                    "JOIN patients p ON r.cinPatient = p.cinPatient " +
                                    "JOIN praticiens pr ON r.cinPraticien = pr.cinPraticien " +
                                    "WHERE r.statut = 'confirme'";
                        PreparedStatement stmt = conn.prepareStatement(sql);
                        ResultSet rs = stmt.executeQuery();

                        while (rs.next()) {
                            java.util.Map<String, String> rdv = new java.util.HashMap<>();
                            rdv.put("idRdv", rs.getString("idRdv"));

                            // Formater la date pour l'affichage
                            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
                            String dateHeure = sdf.format(rs.getTimestamp("dateHeure"));
                            rdv.put("dateHeure", dateHeure);

                            // Informations patient
                            rdv.put("nomPatient", rs.getString("nomPatient"));
                            rdv.put("prenomPatient", rs.getString("prenomPatient"));

                            // Informations praticien
                            rdv.put("nomPraticien", rs.getString("nomPraticien"));
                            rdv.put("prenomPraticien", rs.getString("prenomPraticien"));

                            rdvList.add(rdv);
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (conn != null) {
                        try {
                            conn.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                }

                if (isEditMode) {
                    idConsult = request.getParameter("idConsult") != null ? request.getParameter("idConsult") : "";
                    idRdv = request.getParameter("idRdv") != null ? request.getParameter("idRdv") : "";
                    compteRendu = request.getParameter("compteRendu") != null ? request.getParameter("compteRendu") : "";

                    // Gestion de la date
                    String dateConsultParam = request.getParameter("dateConsult");
                    if (dateConsultParam != null && !dateConsultParam.isEmpty()) {
                        try {
                            // Convertir de la date affichée (dd/MM/yyyy HH:mm) vers le format datetime-local (yyyy-MM-dd'T'HH:mm)
                            SimpleDateFormat inputFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
                            SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                            Date date = inputFormat.parse(dateConsultParam);
                            dateConsultValue = outputFormat.format(date);
                        } catch (ParseException e) {
                            // Si la conversion échoue, essayer avec le format datetime-local directement
                            dateConsultValue = dateConsultParam;
                        }
                    }
                } else {
                    // Pré-remplir avec la date actuelle en mode création
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                    dateConsultValue = sdf.format(new Date());
                }

                String error = (String) request.getAttribute("error");
                String success = (String) request.getAttribute("success");
            %>

            <main>
                <div class="head-title">
                    <div class="left">
                        <h1>GESTION DES CONSULTATIONS</h1>
                        <ul class="breadcrumb">
                            <li><a class="active color" href="/GestionPatient/index.jsp">Tableau de bord</a></li>
                            <li><i class='bx bx-chevron-right'></i></li>
                            <li>
                                <a class="active" href="/GestionPatient/Components/Consultations/indexConsultations.jsp">Liste des consultations</a>
                            </li>
                            <% if (isEditMode) { %> 
                                <li><i class='bx bx-chevron-right'></i></li>
                                <li><a class="active" href="#">Modification</a></li>
                            <% } else { %>
                                <li><i class='bx bx-chevron-right'></i></li>
                                <li><a class="active" href="#">Nouveau consultation</a></li>
                            <% } %>
                            <li class="rotation"><i class='bx bx-chevron-right'></i></li>
                        </ul>
                    </div>
                </div>

                <div class="todo">
                    <div class="container-frm-empl">
                        <div class="top-header">
                            <header><%= isEditMode ? "MODIFICATION DE CONSULTATION" : "NOUVELLE CONSULTATION" %></header>
                            <img class="img" src="/GestionPatient/images/Logo.png" alt="Avatar">
                        </div>

                        <% if (error != null && !error.isEmpty()) { %>
                            <div class="alert-error">
                                <% 
                                    String errorMessage = "";
                                    switch(error) {
                                        case "champs_vides":
                                            errorMessage = "Tous les champs obligatoires doivent être remplis";
                                            break;
                                        case "date_invalide":
                                            errorMessage = "La date doit être valide";
                                            break;
                                        case "date_future":
                                            errorMessage = "La date ne peut pas être dans le futur";
                                            break;
                                        case "connexion_bdd":
                                            errorMessage = "Erreur de connexion à la base de données";
                                            break;
                                        case "consultation_non_trouvee":
                                            errorMessage = "Consultation non trouvée";
                                            break;
                                        case "rdv_invalide":
                                            errorMessage = "Rendez-vous invalide ou inexistant";
                                            break;
                                        case "rdv_non_confirme":
                                            errorMessage = "Le rendez-vous doit être confirmé";
                                            break;
                                        case "consultation_existe_deja":
                                            errorMessage = "Une consultation existe déjà pour ce rendez-vous";
                                            break;
                                        case "erreur_systeme":
                                            errorMessage = "Erreur système lors de l'opération. Veuillez réessayer.";
                                            break;
                                        default:
                                            errorMessage = "Erreur: " + error;
                                    }
                                %>
                                <%= errorMessage %>
                                <button class="close-btn" onclick="this.parentElement.style.display='none'">×</button>
                            </div>
                        <% } %>

                        <% if (success != null && !success.isEmpty()) { %>
                            <div class="alert-success">
                                <% 
                                    String successMessage = "";
                                    switch(success) {
                                        case "insert":
                                            successMessage = "Consultation ajoutée avec succès";
                                            break;
                                        case "update":
                                            successMessage = "Consultation modifiée avec succès";
                                            break;
                                        default:
                                            successMessage = "Opération réussie";
                                    }
                                %>
                                <%= successMessage %>
                                <button class="close-btn" onclick="this.parentElement.style.display='none'">×</button>
                            </div>
                        <% } %>

                        <form action="/GestionPatient/ServletConsultations" method="POST" onsubmit="return validateForm()">
                            <% if (isEditMode) { %>                                                
                                <input type="hidden" name="idConsult" value="<%= idConsult %>">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="idRdv" value="<%= idRdv %>">
                            <% } else { %>
                                <input type="hidden" name="action" value="insert">
                            <% } %>

                            <div class="form first">
                                <div class="details personal">
                                    <span class="title">Détails de la consultation</span>

                                    <div class="fields">
                                        <% if (isEditMode) { %>
                                            <div class="input-field-div">
                                                <label>ID CONSULTATION</label>                                                
                                                <input type="text" value="<%= idConsult %>" disabled>
                                            </div>
                                        <% } %>

                                        <div class="input-field-div">
                                            <label>RENDEZ-VOUS *</label>
                                            <% if (isEditMode) { %>
                                                <select name="idRdvDisplay" disabled class="select-field">
                                                    <% for (java.util.Map<String, String> rdv : rdvList) { 
                                                        if (rdv.get("idRdv").equals(idRdv)) { %>
                                                            <option value="<%= rdv.get("idRdv") %>" selected>
                                                                RDV #<%= rdv.get("idRdv") %> - 
                                                                <%= rdv.get("dateHeure") %> - 
                                                                Patient: <%= rdv.get("prenomPatient") %> <%= rdv.get("nomPatient") %> - 
                                                                Praticien: <%= rdv.get("prenomPraticien") %> <%= rdv.get("nomPraticien") %>
                                                            </option>
                                                        <% }
                                                    } %>
                                                </select>
                                            <% } else { %>
                                                <select name="idRdv" required class="select-field">
                                                    <option value="">-- Sélectionnez un rendez-vous --</option>
                                                    <% for (java.util.Map<String, String> rdv : rdvList) { %>
                                                        <option value="<%= rdv.get("idRdv") %>" 
                                                            <%= idRdv.equals(rdv.get("idRdv")) ? "selected" : "" %>>
                                                            RDV #<%= rdv.get("idRdv") %> - 
                                                            <%= rdv.get("dateHeure") %> - 
                                                            Patient: <%= rdv.get("prenomPatient") %> <%= rdv.get("nomPatient") %> - 
                                                            Praticien: <%= rdv.get("prenomPraticien") %> <%= rdv.get("nomPraticien") %>
                                                        </option>
                                                    <% } %>
                                                </select>
                                            <% } %>
                                        </div>

                                        <div class="input-field-div">
                                            <label>DATE CONSULTATION *</label>
                                            <input name="dateConsult" type="datetime-local" placeholder="Date de la consultation" required
                                                   value="<%= dateConsultValue %>" id="dateConsultInput">
                                        </div>
                                    </div>

                                    <div class="fields">
                                        <div class="input-field-div textarea-field">
                                            <label>COMPTE RENDU</label>
                                            <textarea name="compteRendu" rows="5" placeholder="Compte rendu médical..."><%= compteRendu %></textarea>
                                        </div>
                                    </div>

                                    <div class="form-buttons flex">
                                        <div>
                                            <% if (isEditMode) { %>                                                
                                                <button type="submit" class="nextBtn">
                                                    <span class="btnText">MODIFIER</span>
                                                    <i class='bx bxs-edit'></i>
                                                </button>
                                            <% } else { %>
                                                <button type="submit" class="nextBtn">
                                                    <span class="btnText">ENREGISTRER</span>
                                                    <i class='bx bxs-save'></i>
                                                </button>
                                            <% } %>
                                        </div>
                                        
                                        <div class="btn-annul">
                                            <a href="/GestionPatient/Components/Consultations/indexConsultations.jsp" class="cancelBtn">
                                                <span class="btnText">ANNULER</span>
                                                <i class='bx bx-x'></i>
                                            </a>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </main>
        </section>

        <script>
            function validateForm() {
                const dateConsultInput = document.getElementById('dateConsultInput');
                const dateConsult = new Date(dateConsultInput.value);
                const now = new Date();

                // Validation de la date
                if (dateConsult > now) {
                    alert("La date de consultation ne peut pas être dans le futur");
                    return false;
                }

                return true;
            }

            // Pré-remplir la date actuelle si en mode création
            document.addEventListener('DOMContentLoaded', function() {
                <% if (!isEditMode) { %>
                    const now = new Date();
                    // Format pour datetime-local: YYYY-MM-DDTHH:MM
                    const formattedDate = now.toISOString().slice(0, 16);
                    document.getElementById('dateConsultInput').value = formattedDate;
                <% } %>
            });
        </script>
    </body>
</html>
