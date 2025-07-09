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
        <section id="content">
            <%
                String editMode = request.getParameter("edit");
                boolean isEditMode = "true".equals(editMode);

                String cinPraticien = "";
                if (isEditMode) {
                    cinPraticien = request.getParameter("cinPraticien") != null ? request.getParameter("cinPraticien") : "";
                }

                String nom = request.getParameter("nom") != null ? request.getParameter("nom") : "";
                String prenom = request.getParameter("prenom") != null ? request.getParameter("prenom") : "";
                String telephone = request.getParameter("telephone") != null ? request.getParameter("telephone") : "";
                String email = request.getParameter("email") != null ? request.getParameter("email") : "";
                String specialite = request.getParameter("specialite") != null ? request.getParameter("specialite") : "";

                String error = request.getParameter("error");
            %>

            <main>
                <div class="head-title">
                    <div class="left">
                        <h1>GESTION DES PRATICIENS</h1>
                        <ul class="breadcrumb">
                            <li><a class="active color" href="/GestionPatient/index.jsp">Tableau de bord</a></li>
                            <li><i class='bx bx-chevron-right' ></i></li>
                            <li>
                                <a class="active" href="/GestionPatient/Components/Praticiens/indexPraticiens.jsp">Liste des praticiens</a>
                            </li>
                            <% if (isEditMode) { %> 
                                <li><i class='bx bx-chevron-right' ></i></li>
                                <li>
                                    <a class="active" href="#">Modification</a>
                                </li>
                                <li class="rotation"><i class='bx bx-chevron-right'></i></li>
                            <% } else { %>
                                <li><i class='bx bx-chevron-right' ></i></li>
                                <li>
                                    <a class="active" href="#">Ajout de praticien</a>
                                </li>
                                <li class="rotation"><i class='bx bx-chevron-right'></i></li>
                            <% } %>
                        </ul>
                    </div>
                </div>

                <div class="todo">
                    <div class="container-frm-empl">
                        <div class="top-header">
                            <% if (isEditMode) { %>  
                                <header>MODIFICATION</header>
                            <% } else { %>
                                <header>INSCRIPTION DU PRATICIEN</header>
                            <% } %>
                            <img class="img" src="/GestionPatient/images/Logo.png" alt="Avatar">
                        </div>

                        <form action="${pageContext.request.contextPath}/ServletPraticiens" method="POST">
                            <% if (isEditMode) { %>                                                
                                <input name="cinPraticien" value="<%= cinPraticien %>" type="hidden">
                                <input type="hidden" name="action" value="update">
                            <% } else { %>
                                <input type="hidden" name="action" value="insert">
                            <% } %>

                            <div class="form first">
                                <div class="details personal">
                                    <span class="title">Informations du praticien</span>

                                    <% if (error != null) { %>
                                        <div class="alert-error">
                                            <% 
                                                String errorMessage = "";
                                                switch(error) {
                                                    case "cin_existe_deja":
                                                        errorMessage = "Ce CIN existe déjà dans la base de données";
                                                        break;
                                                    case "champs_vides":
                                                        errorMessage = "Les champs obligatoires sont requis";
                                                        break;
                                                    case "telephone_existe_deja":
                                                        errorMessage = "Ce numéro de téléphone existe déjà";
                                                        break;
                                                    case "email_existe_deja":
                                                        errorMessage = "Cet email existe déjà";
                                                        break;
                                                    case "email_invalide":
                                                        errorMessage = "L'email n'est pas valide";
                                                        break;
                                                    case "connexion_bdd":
                                                        errorMessage = "Erreur de connexion à la base de données";
                                                        break;
                                                    case "praticien_non_trouve":
                                                        errorMessage = "Praticien non trouvé";
                                                        break;
                                                    default:
                                                        errorMessage = "Une erreur est survenue: " + error;
                                                }
                                            %>
                                            <%= errorMessage %>
                                        </div>
                                    <% } %>

                                    <div class="fields">
                                        <div class="input-field-div">
                                            <label>NOM</label>
                                            <input name="nom" value="<%= nom %>" type="text" placeholder="Nom" required maxlength="50">
                                        </div>

                                        <div class="input-field-div">
                                            <label>PRÉNOM</label>
                                            <input name="prenom" value="<%= prenom %>" type="text" placeholder="Prénom" required maxlength="50">
                                        </div>
                                    </div>
                                        
                                    <div class="fields">
                                        <% if (!isEditMode) { %>
                                            <div class="input-field-div">
                                                <label>CIN PRATICIEN</label>                                                
                                                <input name="cinPraticien" type="text" placeholder="CIN du praticien" required maxlength="14">
                                            </div>
                                        <% } %>

                                        <div class="input-field-div">
                                            <label>SPÉCIALITÉ</label>
                                            <input name="specialite" value="<%= specialite %>" type="text" placeholder="Spécialité" maxlength="50">
                                        </div>
                                    </div>

                                    <div class="fields">
                                        <div class="input-field-div">
                                            <label>TÉLÉPHONE</label>
                                            <input name="telephone" value="<%= telephone %>" type="tel" placeholder="Téléphone" maxlength="17">
                                        </div>

                                        <div class="input-field-div">
                                            <label>EMAIL</label>
                                            <input name="email" value="<%= email %>" type="email" placeholder="Email" maxlength="50">
                                        </div>
                                    </div>

                                    <% if (isEditMode) { %>                                                
                                        <button type="submit" class="nextBtn">
                                            <span class="btnText">MODIFIER</span>
                                            <i class='bx bxs-download'></i>
                                        </button>
                                    <% } else { %>
                                        <button type="submit" class="nextBtn">
                                            <span class="btnText">ENREGISTRER</span>
                                            <i class='bx bxs-download'></i>
                                        </button>
                                    <% } %>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <footer class="footer">
                    <div class="footer-text">
                        <p>&copy; 2025 par Système de Gestion des Patients | Tous Droits Réservés.</p>
                    </div>

                    <div class="footer-iconTop">
                        <a href="/GestionPatient/Components/Praticiens/FrmPraticien.jsp"><i class='bx bx-up-arrow-alt'></i></a>
                    </div>
                </footer>
            </main>
        </section>
    </body>
</html>
