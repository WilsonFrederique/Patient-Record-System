<%@page import="java.net.URLEncoder"%>
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
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.170);
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
            color: rgba(0, 0, 0, 0.908);
        }

        .todo-color{
            color: rgba(0, 0, 0, 0.908);
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

<!--Mon Css Pour Order Table-->
<style>
    .orber {
        background: white;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
        overflow: hidden;
        transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
    }

    .orber:hover {
        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
    }

    .orber .head {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 1.5rem;
        background: #f9f9f9;
        border-bottom: 1px solid var(--border-color);
    }

    .orber .head h3 {
        margin: 0;
        font-size: 1.25rem;
        font-weight: 600;
        color: #342e37;
    }

    .orber .head .icon-tbl {
        font-size: 1.2rem;
        color: #342e37;
        cursor: pointer;
        transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
        padding: 0.5rem;
        border-radius: 50%;
    }

    .orber .head .icon-tbl:hover {
        background: rgba(0, 0, 0, 0.05);
        transform: scale(1.1);
    }

    .orber table {
        width: 100%;
        border-collapse: separate;
        border-spacing: 0;
    }

    .orber thead {
        position: sticky;
        top: 0;
        background: white;
        z-index: 10;
    }
    
    .orber thead tr th{
        padding-left: 0;        
    }

    .orber th {
        padding: 1rem 1.5rem;
        text-align: left;
        font-weight: 600;
        color: #342e37;
        border-bottom: 2px solid var(--border-color);
        background: #f9f9f9;
        position: relative;
    }

    .orber th:after {
        content: "";
        position: absolute;
        bottom: -2px;
        left: 0;
        width: 0;
        height: 2px;
        background: #3c91e6;
        transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
    }

    .orber th:hover:after {
        width: 100%;
    }

    .orber td {
        padding: 1.25rem 1.5rem;
        border-bottom: 1px solid var(--border-color);
        transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
    }

    .orber tr:last-child td {
        border-bottom: none;
    }

    .orber tr:hover td {
        background: #f5f5f5;
    }

    .orber td:first-child {
        display: flex;
        align-items: center;
        gap: 1rem;
    }

    .orber td img {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        object-fit: cover;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    .orber td p {
        margin: 0;
        font-weight: 500;
    }

    /* Status badges */
    .status {
        display: inline-block;
        padding: 0.5rem 1rem;
        border-radius: 20px;
        font-size: 0.75rem;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
    }

    .status.completed {
        background: #3c91e6;
        color: white;
    }

    .status.process {
        background: #ffc107;
        color: #333;
    }

    .status.pending {
        background: #ff6b6b;
        color: white;
    }

    /* Animation for table rows */
    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(10px); }
        to { opacity: 1; transform: translateY(0); }
    }

    .orber tbody tr {
        animation: fadeIn 0.4s ease-out forwards;
        opacity: 0;
    }

    .orber tbody tr:nth-child(1) { animation-delay: 0.1s; }
    .orber tbody tr:nth-child(2) { animation-delay: 0.2s; }
    .orber tbody tr:nth-child(3) { animation-delay: 0.3s; }
    .orber tbody tr:nth-child(4) { animation-delay: 0.4s; }
    .orber tbody tr:nth-child(5) { animation-delay: 0.5s; }

    /* Responsive adjustments */
    @media (max-width: 768px) {
        .orber .head {
            flex-direction: column;
            align-items: flex-start;
            gap: 1rem;
        }

        .orber .head .icon-tbl {
            align-self: flex-end;
        }

        .orber td {
            padding: 1rem;
        }

        .orber td:first-child {
            flex-direction: column;
            align-items: flex-start;
            gap: 0.5rem;
        }
    }
    
    
    
    /*Search*/
    .search-container {
        display: flex;
        align-items: center;
        transition: all 0.3s ease;
    }
    
    .search-input {
        border: 1px solid #ddd;
        border-radius: 20px;
        padding: 0.5rem 1rem;
        margin-right: 0.5rem;
        width: 0;
        opacity: 0;
        transition: all 0.3s ease;
    }
    
    .search-input.active {
        display: block !important;
        width: 200px;
        opacity: 1;
    }
    
    .search-icon {
        cursor: pointer;
        transition: all 0.3s ease;
    }
    
    .search-icon:hover {
        color: #3c91e6;
        transform: scale(1.1);
    }
    
    
    
    /*Btn Actions*/
    /* Style pour le conteneur des actions */
    td.action-icons {
        display: flex;
        gap: 1rem;
        padding: 0.75rem 1.5rem;
    }

    /* Style de base pour les liens des icônes */
    td.action-icons a {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 36px;
        height: 36px;
        border-radius: 50%;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        color: #5f6368;
        background-color: transparent;
    }

    /* Style pour les icônes */
    td.action-icons a i {
        font-size: 1.25rem;
        transition: transform 0.2s ease;
    }

    /* Style au survol */
    td.action-icons a:hover {
        transform: translateY(-2px);
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    }

    /* Style spécifique pour l'icône d'édition */
    td.action-icons a:first-child:hover {
        color: #3c91e6;
        background-color: rgba(60, 145, 230, 0.1);
    }

    /* Style spécifique pour l'icône de suppression */
    td.action-icons a:last-child:hover {
        color: #ff6b6b;
        background-color: rgba(255, 107, 107, 0.1);
    }

    /* Animation au clic */
    td.action-icons a:active {
        transform: scale(0.95);
    }

    /* Effet de vague au clic (effet matériel) */
    td.action-icons a {
        position: relative;
        overflow: hidden;
    }

    td.action-icons a::after {
        content: "";
        position: absolute;
        top: 50%;
        left: 50%;
        width: 5px;
        height: 5px;
        background: rgba(0, 0, 0, 0.1);
        opacity: 0;
        border-radius: 100%;
        transform: scale(1, 1) translate(-50%, -50%);
        transform-origin: 50% 50%;
    }

    td.action-icons a:active::after {
        animation: ripple 0.6s ease-out;
    }

    @keyframes ripple {
        0% {
            transform: scale(0, 0);
            opacity: 0.5;
        }
        100% {
            transform: scale(20, 20);
            opacity: 0;
        }
    }

    /* Version responsive */
    @media (max-width: 768px) {
        td.action-icons {
            gap: 0.75rem;
            padding: 0.5rem;
        }

        td.action-icons a {
            width: 32px;
            height: 32px;
        }

        td.action-icons a i {
            font-size: 1.1rem;
        }
    }
    
    /* Style spécifique pour le bouton de suppression invisible */
    .btn-invisble {
        border: none;
        outline: none;
        background: transparent;
        padding: 0;
        cursor: pointer;
        position: relative;
        overflow: hidden;
        width: 36px;
        height: 36px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        border-radius: 50%;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        color: #5f6368;
    }

    /* Style de l'icône à l'intérieur du bouton */
    .btn-invisble i {
        font-size: 1.25rem;
        transition: all 0.2s ease;
    }

    /* Effet au survol */
    .btn-invisble:hover {
        transform: translateY(-2px);
        color: #ff6b6b;
        background-color: rgba(255, 107, 107, 0.1);
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    }

    /* Effet au clic */
    .btn-invisble:active {
        transform: scale(0.95);
    }

    /* Animation de ripple (onde) au clic */
    .btn-invisble::after {
        content: "";
        position: absolute;
        top: 50%;
        left: 50%;
        width: 5px;
        height: 5px;
        background: rgba(255, 107, 107, 0.3);
        opacity: 0;
        border-radius: 100%;
        transform: scale(1, 1) translate(-50%, -50%);
        transform-origin: 50% 50%;
    }

    .btn-invisble:active::after {
        animation: ripple 0.6s ease-out;
    }

    @keyframes ripple {
        0% {
            transform: scale(0, 0);
            opacity: 0.5;
        }
        100% {
            transform: scale(20, 20);
            opacity: 0;
        }
    }

    /* Version responsive */
    @media (max-width: 768px) {
        .btn-invisble {
            width: 32px;
            height: 32px;
        }

        .btn-invisble i {
            font-size: 1.1rem;
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
        color: #323946;
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

<!--Css pour Retardataires-->
<style>
    .modern-btn {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        padding: 12px 20px;
        border-radius: 8px;
        background: linear-gradient(135deg, #3c91e6 0%, #2b7dcc 100%);
        color: white;
        border: none;
        font-family: 'Poppins', sans-serif;
        font-weight: 500;
        font-size: 14px;
        cursor: pointer;
        transition: all 0.3s ease;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }
    
    .modern-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        background: linear-gradient(135deg, #2b7dcc 0%, #1a6bb2 100%);
    }
    
    .modern-btn:active {
        transform: translateY(0);
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }
    
    .modern-btn i {
        font-size: 18px;
    }
</style>

<!--styles spécifiques pour la liste des retardataires-->
<style>
    .retardataire-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 12px 16px;
                margin-bottom: 8px;
                background: #fff8f8;
                border-left: 5px solid #ff6b6b;
                border-radius: 4px;
                transition: all 0.3s ease;
            }
            
            .retardataire-item:hover {
                background: #ffeeee;
                transform: translateX(5px);
            }
            
            .retardataire-info {
                display: flex;
                flex: 1;
                justify-content: space-between;
            }
            
            .retardataire-info span {
                flex: 1;
                text-align: left;
                padding: 0 8px;
            }
            
            .retardataire-info .nom {
                font-weight: 600;
                color: #342e37;
            }
            
            .retardataire-info .date1, .retardataire-info .date2, .retardataire-info .jours{
                font-weight: 700;
            }
            
            .dateRetour{
                color: rgb(190, 59, 26);
            }
            
            .datePreter{
                color: rgb(22, 11, 144);
            }
            
            .retardataire-actions {
                display: flex;
                gap: 8px;
            }
            
            .retardataire-actions i {
                cursor: pointer;
                padding: 6px;
                border-radius: 50%;
                transition: all 0.2s ease;
            }
            
            .retardataire-actions i:hover {
                background: rgba(0,0,0,0.1);
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


<%@page import="Bibliotheque.DB_Connexion"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.DataSource" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>WiFre</title>
    </head>
    <body>        
        <!--SidBar et NavBar-->
        <jsp:include page="/Components/SidBar/NavSidBar.jsp" />
        
        <!--Container-->
        <section id="content">
            <!-- --------------------- Main --------------------- -->
            <main>
                <div class="head-title">
                    <div class="left">
                        <h1>LISTE DES PRESCRIPTIONS</h1>
                        <ul class="breadcrumb">
                            <li><a class="active color" href="/GestionPatient/index.jsp">Tableau de bord</a></li>
                            <li><i class='bx bx-chevron-right' ></i></li>
                            <li>
                                <a class="active" href="/GestionPatient/Components/Prescriptions/indexPrescriptions.jsp">Liste des prescriptions</a>
                            </li>
                            <li class="rotation"><i class='bx bx-chevron-right'></i></li>
                        </ul>
                    </div>
                    <a href="/GestionPatient/Components/Prescriptions/FrmPrescriptions.jsp" class="btn-download">
                        <i class='bx bx-plus' ></i>
                        <span class="text">NOUVELLE PRESCRIPTION</span>
                    </a>
                </div>

                <!-- *********************************************** -->

                <!--Liste des prescriptions en attente-->
                <div class="table-date">
                    <div class="todo liste-des-en-attente" style="display: none;">
                        <div class="">
                            <div class="head">
                                <h3>Prescriptions en attente</h3>
                            </div>
                            <ul class="todo-list todo-color">
                                <li class="not-completed">
                                    <div class="prescription-info">
                                        <span class="consult">Consultation</span>
                                        <span class="type">Type</span>
                                        <span class="date">Date Prescription</span>
                                        <span class="status">Statut</span>
                                    </div>
                                    <div class="prescription-actions">
                                        <i class='bx bx-dots-vertical-rounded bg-hover-icon'></i>
                                    </div>
                                </li>

                                <%
                                    try (
                                        Connection conn = DB_Connexion.getConnection();
                                        PreparedStatement stmt = conn.prepareStatement(
                                            "SELECT p.idPrescrire, p.idConsult, p.typePrescrire, p.posologie, p.datePrescrire " +
                                            "FROM prescriptions p " +
                                            "WHERE p.statut = 'en_attente' " +
                                            "ORDER BY p.datePrescrire ASC"
                                        );
                                    ) {
                                        try (ResultSet rs = stmt.executeQuery()) {
                                            boolean hasResults = false;
                                            java.text.SimpleDateFormat displayFormat = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm");

                                            while (rs.next()) {
                                                hasResults = true;
                                                String idPrescrire = rs.getString("idPrescrire");
                                                String idConsult = rs.getString("idConsult");
                                                String typePrescrire = rs.getString("typePrescrire");
                                                String posologie = rs.getString("posologie");

                                                java.sql.Timestamp datePrescrireTimestamp = rs.getTimestamp("datePrescrire");
                                                String datePrescrireFormatted = (datePrescrireTimestamp != null)
                                                    ? displayFormat.format(datePrescrireTimestamp)
                                                    : "N/A";
                                %>
                                <li class="not-completed">
                                    <div class="prescription-info">
                                        <span class="consult">Consult #<%= idConsult %></span>
                                        <span class="type"><%= typePrescrire %></span>
                                        <span class="date"><%= datePrescrireFormatted %></span>
                                        <span class="status led-blink" style="color: #db504a; font-weight: bold;">
                                            En attente
                                        </span>
                                    </div>
                                    <div class="prescription-actions">
                                        <button type="submit" style="background: none; border: none; cursor: pointer;">
                                            <i class='bx bx-check' title="Marquer comme complété"></i>
                                        </button>
                                    </div>
                                </li>
                                <%
                                            }

                                            if (!hasResults) {
                                %>
                                <li class="not-completed">
                                    <div class="prescription-info" style="justify-content: center;">
                                        <span style="text-align: center; font-style: italic; color: #666;">
                                            Aucune prescription en attente
                                        </span>
                                    </div>
                                </li>
                                <%
                                            }
                                        }
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                %>
                                <li class="not-completed">
                                    <div class="prescription-info" style="justify-content: center;">
                                        <span style="text-align: center; color: #db504a;">
                                            Erreur lors du chargement des prescriptions
                                        </span>
                                    </div>
                                </li>
                                <%
                                    }
                                %>
                            </ul>
                        </div>
                    </div>
                </div>


                <!--Liste de toutes les prescriptions-->
                <div class="table-date">
                    <!--Order-->
                    <div class="orber">
                        <div class="head">
                            <h3>Dernières prescriptions</h3>
                            <div class="btn-en-attente">
<!--                                <button class="modern-btn" id="toggleEnAttente">
                                    <i class='bx bx-time-five'></i>
                                    <span>En attente</span>
                                </button>-->
                            </div>
                            <a href="/GestionPatient/Components/Prescriptions/indexPrescriptions.jsp">
                                <i class='bx bx-filter icon-tbl'></i>                                
                            </a>
                        </div>
                        <table>
                            <thead class="thead">
                                <tr>
                                    <th>ID PRESCRIPTION</th>
                                    <th>CONSULTATION</th>
                                    <th>TYPE</th>
                                    <th>POSOLOGIE</th>
                                    <th>DATE</th>
                                    <th>ACTIONS</th>
                                </tr>
                            </thead>
                            <tbody class="tbody">

                                <%
                                    Connection conn = null;
                                    PreparedStatement stmt = null;
                                    ResultSet rs = null;
                                    try {
                                        conn = DB_Connexion.getConnection();
                                        String sql = "SELECT * FROM prescriptions ORDER BY datePrescrire DESC";
                                        stmt = conn.prepareStatement(sql);
                                        rs = stmt.executeQuery();
                                        while (rs.next()) {
                                            String idPrescrire = rs.getString("idPrescrire");
                                            String idConsult = rs.getString("idConsult");
                                            String typePrescrire = rs.getString("typePrescrire");
                                            String posologie = rs.getString("posologie");

                                            // Correction pour les dates
                                            java.sql.Timestamp datePrescrireTimestamp = rs.getTimestamp("datePrescrire");

                                            // Conversion en java.util.Date
                                            java.util.Date datePrescrire = null;

                                            if (datePrescrireTimestamp != null) {
                                                datePrescrire = new java.util.Date(datePrescrireTimestamp.getTime());
                                            }

                                            // Formatage des dates pour l'affichage
                                            SimpleDateFormat dateTimeFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
                                            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");

                                            String datePrescrireFormatted = datePrescrire != null ? dateTimeFormat.format(datePrescrire) : "N/A";
                                            String datePrescrireShort = datePrescrire != null ? dateFormat.format(datePrescrire) : "N/A";
                                %>

                                <tr>
                                    <td>
                                        <p><%= idPrescrire %></p>
                                    </td>
                                    <td>
                                        <p>Consult #<%= idConsult %></p>
                                    </td>
                                    <td><%= typePrescrire %></td>
                                    <td><%= posologie != null ? posologie : "N/A" %></td>
                                    <td><span class="status completed"><%= datePrescrireShort %></span></td>
                                    <td class="action-icons">
                                        <a href="/GestionPatient/Components/Prescriptions/FrmPrescriptions.jsp?edit=true&idPrescrire=<%= idPrescrire %>&idConsult=<%= idConsult %>&typePrescrire=<%= typePrescrire %>&posologie=<%= posologie != null ? URLEncoder.encode(posologie, "UTF-8") : "" %>&datePrescrire=<%= datePrescrireFormatted %>" 
                                           aria-label="Edit" title="Edit">
                                            <i class='bx bx-edit'></i>
                                        </a>
                                        <form method="get" action="<%= request.getContextPath() %>/ServletPrescriptions" style="display:inline;">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="idPrescrire" value="<%= idPrescrire %>">
                                            <button type="submit" class="btn-invisble" 
                                                    onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette prescription ?')">
                                                <i class='bx bx-trash'></i>
                                            </button>
                                        </form>
                                    </td>
                                </tr>

                                <%
                                        }
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    } finally {
                                        // Fermeture des ressources
                                        if (rs != null) rs.close();
                                        if (stmt != null) stmt.close();
                                        if (conn != null) conn.close();
                                    }
                                %>      
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Footer -->
                <footer class="footer">
                    <div class="footer-text">
                        <p>&copy; 2025 par Système de Gestion de Patients | Tous droits réservés.</p>
                    </div>

                    <div class="footer-iconTop">
                        <a href="/GestionPatient/Components/Prescriptions/indexPrescriptions.jsp"><i class='bx bx-up-arrow-alt'></i></a>
                    </div>
                </footer>
            </main>
            <!-- --------------------- Fin Main ----------------- -->
        </section>
        
        
        <!--Script Pour Ce input Search dans Order-->
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                const searchIcon = document.querySelector('.search-icon');
                const searchInput = document.querySelector('.search-input');

                searchIcon.addEventListener('click', function() {
                    searchInput.classList.toggle('active');

                    // Focus sur l'input quand il apparaît
                    if (searchInput.classList.contains('active')) {
                        searchInput.focus();
                    }
                });

                // Optionnel: Fermer la recherche si on clique en dehors
                document.addEventListener('click', function(e) {
                    if (!e.target.closest('.search-container')) {
                        searchInput.classList.remove('active');
                    }
                });
            });
        </script>
        
        
                <!-- Script Pour Visible et Invisible les listes de retardataire -->
                <script>
                    // Fonction pour gérer l'affichage des retardataires
                    function toggleRetardataires() {
                        const listeRetardataires = document.querySelector('.liste-des-retardataires');
                        const isVisible = localStorage.getItem('retardatairesVisible') === 'true';
                        
                        // Basculer l'état
                        const newState = !isVisible;
                        localStorage.setItem('retardatairesVisible', newState);
                        
                        // Appliquer le style
                        listeRetardataires.style.display = newState ? 'block' : 'none';
                        
                        // Mettre à jour le texte du bouton
                        const btnText = document.querySelector('#toggleRetardataires span');
                        btnText.textContent = newState ? 'Masquer retardataires' : 'Retardataires';
                    }
                    
                    // Initialiser l'état au chargement de la page
                    document.addEventListener('DOMContentLoaded', function() {
                        const isVisible = localStorage.getItem('retardatairesVisible') === 'true';
                        const listeRetardataires = document.querySelector('.liste-des-retardataires');
                        const btnText = document.querySelector('#toggleRetardataires span');
                        
                        listeRetardataires.style.display = isVisible ? 'block' : 'none';
                        btnText.textContent = isVisible ? 'Masquer retardataires' : 'Retardataires';
                    });
                    
                    // Ajouter l'événement click au bouton
                    document.getElementById('toggleRetardataires').addEventListener('click', toggleRetardataires);
                </script>
    </body>
</html>
