<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
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


<!--Css Pour Erreur-->
<style>
    .alert-error {
        background-color: #fef2f2;
        color: #b91c1c;
        border: 1px solid #fca5a5;
        padding: 15px 20px;
        border-radius: 12px;
        margin: 20px 0;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        position: relative;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        animation: fadeInDown 0.5s ease;
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .alert-error::before {
        content: "⚠️";
        font-size: 1.3rem;
    }

    .alert-error .close-btn {
        position: absolute;
        right: 15px;
        top: 50%;
        transform: translateY(-50%);
        background: transparent;
        border: none;
        color: #b91c1c;
        font-size: 1.2rem;
        cursor: pointer;
        transition: color 0.2s ease;
    }

    .alert-error .close-btn:hover {
        color: #7f1d1d;
    }

    @keyframes fadeInDown {
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
        
        <!--Container-->
        <!-- ========================================= CONTENT ======================================== -->
        <%@page import="java.net.URLEncoder"%>
        <section id="content">
            <%
                // Correction: Vérifier d'abord les attributs puis les paramètres
                String editAttr = (String) request.getAttribute("edit");
                String editParam = request.getParameter("edit");
                boolean isEditMode = "true".equals(editAttr) || "true".equals(editParam);

                // Récupération des valeurs
                String idRdv = request.getAttribute("idRdv") != null ? (String) request.getAttribute("idRdv") : 
                              request.getParameter("idRdv") != null ? request.getParameter("idRdv") : "";

                String cinPatient = request.getAttribute("cinPatient") != null ? (String) request.getAttribute("cinPatient") : 
                                   request.getParameter("cinPatient") != null ? request.getParameter("cinPatient") : "";

                String nomPatient = request.getAttribute("nomPatient") != null ? (String) request.getAttribute("nomPatient") : "";
                String prenomPatient = request.getAttribute("prenomPatient") != null ? (String) request.getAttribute("prenomPatient") : "";
                String cinPraticien = request.getAttribute("cinPraticien") != null ? (String) request.getAttribute("cinPraticien") : 
                                     request.getParameter("cinPraticien") != null ? request.getParameter("cinPraticien") : "";

                String nomPraticien = request.getAttribute("nomPraticien") != null ? (String) request.getAttribute("nomPraticien") : "";
                String prenomPraticien = request.getAttribute("prenomPraticien") != null ? (String) request.getAttribute("prenomPraticien") : "";

                String dateHeureValue = request.getAttribute("dateHeure") != null ? (String) request.getAttribute("dateHeure") : 
                                       request.getParameter("dateHeure") != null ? request.getParameter("dateHeure") : "";

                String statut = request.getAttribute("statut") != null ? (String) request.getAttribute("statut") : 
                               request.getParameter("statut") != null ? request.getParameter("statut") : "en_attente";

                String idRdvParent = request.getAttribute("idRdvParent") != null ? (String) request.getAttribute("idRdvParent") : 
                                    request.getParameter("idRdvParent") != null ? request.getParameter("idRdvParent") : "";

                String error = request.getParameter("error");
            %>

            <main>
                <div class="head-title">
                    <div class="left">
                        <h1>GESTION DES RENDEZ-VOUS</h1>
                        <ul class="breadcrumb">
                            <li><a class="active color" href="/GestionPatient/index.jsp">Tableau de bord</a></li>
                            <li><i class='bx bx-chevron-right'></i></li>
                            <li>
                                <a class="active" href="/GestionPatient/Components/RendezVous/indexRendezVous.jsp">Liste des rendez-vous</a>
                            </li>
                            <% if (isEditMode) { %> 
                                <li><i class='bx bx-chevron-right'></i></li>
                                <li><a class="active" href="#">Modification</a></li>
                            <% } else { %>
                                <li><i class='bx bx-chevron-right'></i></li>
                                <li><a class="active" href="#">Nouveau rendez-vous</a></li>
                            <% } %>
                            <li class="rotation"><i class='bx bx-chevron-right'></i></li>
                        </ul>
                    </div>
                </div>

                <div class="todo">
                    <div class="container-frm-empl">
                        <div class="top-header">
                            <% if (isEditMode) { %>  
                                <header>MODIFICATION DE RENDEZ-VOUS</header>
                            <% } else { %>
                                <header>NOUVEAU RENDEZ-VOUS</header>
                            <% } %>
                            <img class="img" src="/GestionPatient/images/Logo.png" alt="Avatar">
                        </div>

                        <% if (error != null) { %>
                            <div class="alert-error">
                                <%-- Afficher le message d'erreur --%>
                                <%= error %>
                                <button class="close-btn" onclick="this.parentElement.style.display='none'">×</button>
                            </div>
                        <% } %>

                        <form action="/GestionPatient/ServletRendezVous" method="POST" id="rdvForm">
                            <% if (isEditMode) { %>
                                <input type="hidden" name="idRdv" value="<%= idRdv %>">
                                <input type="hidden" name="action" value="update">
                            <% } else { %>
                                <input type="hidden" name="action" value="insert">
                            <% } %>

                            <div class="form first">
                                <div class="details personal">
                                    <span class="title">Détails du rendez-vous</span>

                                    <div class="fields">
                                        <% if (isEditMode) { %>
                                            <div class="input-field-div">
                                                <label>ID RENDEZ-VOUS</label>                                                
                                                <input type="text" value="<%= idRdv %>" disabled>
                                            </div>
                                        <% } %>

                                        <div class="input-field-div">
                                            <label>CIN PATIENT *</label>
                                            <% if (isEditMode) { %>
                                                <input type="text" value="<%= cinPatient %> - <%= prenomPatient %> <%= nomPatient %>" readonly>
                                                <input type="hidden" name="cinPatient" value="<%= cinPatient %>">
                                            <% } else { %>
                                                <select name="cinPatient" id="cinPatient" required>
                                                    <option value="">Sélectionnez un patient</option>
                                                    <% 
                                                    List<Map<String, String>> patients = (List<Map<String, String>>) request.getAttribute("patients");
                                                    if(patients == null) {
                                                        patients = new ArrayList<>();
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
                                                    }

                                                    for(Map<String, String> patient : patients) { 
                                                        String selected = patient.get("cinPatient").equals(cinPatient) ? "selected" : "";
                                                    %>
                                                        <option value="<%= patient.get("cinPatient") %>" <%= selected %>>
                                                            <%= patient.get("cinPatient") %> - <%= patient.get("prenom") %> <%= patient.get("nom") %>
                                                        </option>
                                                    <% } %>
                                                </select>
                                            <% } %>
                                        </div>

                                        <div class="input-field-div">
                                            <label>CIN PRATICIEN *</label>
                                            <select name="cinPraticien" id="cinPraticien" required>
                                                <option value="">Sélectionnez un praticien</option>
                                                <% 
                                                List<Map<String, String>> praticiens = (List<Map<String, String>>) request.getAttribute("praticiens");
                                                if(praticiens == null) {
                                                    praticiens = new ArrayList<>();
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
                                                }

                                                for(Map<String, String> praticien : praticiens) { 
                                                    String selected = praticien.get("cinPraticien").equals(cinPraticien) ? "selected" : "";
                                                %>
                                                    <option value="<%= praticien.get("cinPraticien") %>" <%= selected %>>
                                                        <%= praticien.get("cinPraticien") %> - <%= praticien.get("prenom") %> <%= praticien.get("nom") %> (<%= praticien.get("specialite") %>)
                                                    </option>
                                                <% } %>
                                            </select>
                                        </div>

                                        <div class="input-field-div">
                                            <label>DATE ET HEURE *</label>
                                            <%
                                                String dateValue = "";
                                                if (dateHeureValue != null && !dateHeureValue.isEmpty()) {
                                                    // Si la date vient déjà formatée correctement (depuis le servlet)
                                                    if (dateHeureValue.contains("T")) {
                                                        dateValue = dateHeureValue;
                                                    } 
                                                    // Si la date vient de la base de données (format timestamp)
                                                    else {
                                                        try {
                                                            // Essayez de parser la date selon différents formats
                                                            SimpleDateFormat[] possibleFormats = {
                                                                new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"),
                                                                new SimpleDateFormat("dd/MM/yyyy HH:mm"),
                                                                new SimpleDateFormat("yyyy-MM-dd'T'HH:mm")
                                                            };

                                                            Date parsedDate = null;
                                                            for (SimpleDateFormat format : possibleFormats) {
                                                                try {
                                                                    parsedDate = format.parse(dateHeureValue);
                                                                    break;
                                                                } catch (java.text.ParseException e) {
                                                                    // Continuer avec le format suivant
                                                                }
                                                            }

                                                            if (parsedDate != null) {
                                                                SimpleDateFormat uiFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                                                                dateValue = uiFormat.format(parsedDate);
                                                            } else {
                                                                dateValue = dateHeureValue; // Fallback
                                                            }
                                                        } catch (Exception e) {
                                                            dateValue = dateHeureValue; // Fallback
                                                            e.printStackTrace();
                                                        }
                                                    }
                                                }
                                            %>
                                            <input name="dateHeure" id="dateHeure" type="datetime-local" 
                                                   value="<%= dateValue %>" required>
                                        </div>                                        

                                        <div class="input-field-div">
                                            <label>STATUT *</label>
                                            <select name="statut" required>
                                                <option value="en_attente" <%= "en_attente".equals(statut) ? "selected" : "" %>>En attente</option>
                                                <option value="confirme" <%= "confirme".equals(statut) ? "selected" : "" %>>Confirmé</option>
                                                <option value="annule" <%= "annule".equals(statut) ? "selected" : "" %>>Annulé</option>
                                                <!--<option value="termine" <%= "termine".equals(statut) ? "selected" : "" %>>Terminé</option>-->
                                            </select>
                                        </div>
                                    </div>

                                    <div class="form-buttons">
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
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Footer -->
                <footer class="footer">
                    <div class="footer-text">
                        <p>&copy; 2025 par Système de Gestion des Patients | Tous Droits Réservés.</p>
                    </div>
                    <div class="footer-iconTop">
                        <a href="/GestionPatient/Components/RendezVous/FrmRendezVous.jsp"><i class='bx bx-up-arrow-alt'></i></a>
                    </div>
                </footer>
            </main>
        </section>

        <style>
            .patient-info, .praticien-info {
                display: block;
                margin-top: 5px;
                font-size: 0.9em;
                color: #666;
            }

            .input-field-div {
                position: relative;
            }

            .btn-search-patient, 
            .btn-search-praticien, 
            .btn-search-rdv {
                position: absolute;
                right: 10px;
                top: 50%;
                transform: translateY(-50%);
                background: none;
                border: none;
                cursor: pointer;
                color: #666;
            }

            .btn-search-rdv {
                position: relative;
                display: block;
                margin-top: 5px;
                padding: 5px 10px;
                background-color: #f0f0f0;
                border-radius: 4px;
                font-size: 0.8em;
            }

            .btn-search-rdv:hover {
                background-color: #e0e0e0;
            }

            .form-buttons {
                display: flex;
                justify-content: space-between;
                margin-top: 20px;
            }

            .nextBtn {
                display: inline-flex;
                align-items: center;
                padding: 10px 20px;
                background-color: #d4edda;
                color: #155724;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }

            .nextBtn:hover {
                background-color: #c3e6cb;
            }

            .alert-error {
                padding: 10px;
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
                border-radius: 4px;
                margin-bottom: 15px;
                position: relative;
            }

            .close-btn {
                position: absolute;
                right: 10px;
                top: 10px;
                background: none;
                border: none;
                cursor: pointer;
                color: #721c24;
            }
        </style>

        <script>
            document.addEventListener('DOMContentLoaded', function() {
                const dateInput = document.getElementById('dateHeure');

                // Formatage initial de la date si nécessaire
                if(dateInput && dateInput.value) {
                    // Convertir tous les formats de date possibles en format datetime-local
                    const dateValue = dateInput.value;

                    // Format 1: "dd/MM/yyyy HH:mm"
                    if(dateValue.includes(' ')) {
                        const [datePart, timePart] = dateValue.split(' ');
                        const [day, month, year] = datePart.split('/');
                        dateInput.value = `${year}-${month.padStart(2, '0')}-${day.padStart(2, '0')}T${timePart}`;
                    }
                    // Format 2: "yyyy-MM-dd HH:mm:ss"
                    else if(dateValue.includes('-') && dateValue.includes(':')) {
                        const [datePart, timePart] = dateValue.split(' ');
                        dateInput.value = `${datePart}T${timePart.substring(0, 5)}`;
                    }
                }

                // Validation avant soumission
                const form = document.getElementById('rdvForm');
                if(form) {
                    form.addEventListener('submit', function(e) {
                        // Validation de la date
                        if(dateInput && dateInput.value) {
                            const selectedDate = new Date(dateInput.value);
                            const now = new Date();

                            // Tolérance de 5 minutes pour éviter les problèmes de synchronisation
                            now.setMinutes(now.getMinutes() - 5);

                            if(selectedDate < now) {
                                alert("La date du rendez-vous ne peut pas être dans le passé");
                                e.preventDefault();
                                dateInput.focus();
                                return false;
                            }
                        }
                        return true;
                    });
                }
            });

            function searchPatient() {
                // Implémentez la recherche de patient ici
                alert("Fonctionnalité de recherche de patient à implémenter");
            }

            function searchPraticien() {
                window.open('/GestionPatient/ServletRendezVous?action=getPraticiens', 
                            'RecherchePraticien', 
                            'width=800,height=600');
            }

            function searchRdvParent() {
                const cinPatient = document.getElementById('cinPatient').value;
                if(cinPatient) {
                    window.open('/GestionPatient/ServletRendezVous?action=getRdvParents&cinPatient=' + cinPatient, 
                                'RechercheRdvParent', 
                                'width=800,height=600');
                } else {
                    alert("Veuillez d'abord saisir un patient");
                }
            }
        </script>
        
        <!--Scrip pour Date time--> 
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                const dateInput = document.getElementById('dateHeure');

                // Debug: Afficher la valeur de l'input
                console.log("Date input value:", dateInput.value);

                // Si la valeur est vide mais qu'on a une date dans les attributs
                if (dateInput && !dateInput.value && '<%= dateValue %>' !== '') {
                    dateInput.value = '<%= dateValue %>';
                    console.log("Forced date input value to:", dateInput.value);
                }

                // Validation avant soumission
                const form = document.getElementById('rdvForm');
                if(form) {
                    form.addEventListener('submit', function(e) {
                        if(dateInput && dateInput.value) {
                            const selectedDate = new Date(dateInput.value);
                            const now = new Date();
                            now.setMinutes(now.getMinutes() - 5); // Tolérance de 5 minutes

                            if(selectedDate < now) {
                                alert("La date du rendez-vous ne peut pas être dans le passé");
                                e.preventDefault();
                                dateInput.focus();
                                return false;
                            }
                        }
                        return true;
                    });
                }
            });
        </script>
                                    
        <!-- Liens JavaScript -->
        <script src="/GestionPatient/js/script.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </body>
</html>
