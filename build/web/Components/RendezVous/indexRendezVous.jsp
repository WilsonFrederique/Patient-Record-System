<%@page import="java.net.URLEncoder"%>
<!--Mon Css-->
<style>
    a{
        cursor: pointer;
    }
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
        @media (max-width: 768px) {
            .search-text{
                display: none;
            }
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

<!--Mon Css pour Recherche Prets entre deux dates-->
<style>
    /* Style pour le filtre de dates */
    .date-filter-container {
        padding: 1.5rem;
        background: #f9f9f9;
        border-radius: 12px;
        margin-bottom: 1.5rem;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
    }

    .date-filter-form {
        display: flex;
        flex-wrap: wrap;
        gap: 1.5rem;
        align-items: flex-end;
    }

    .date-input-group {
        flex: 1;
        min-width: 200px;
    }

    .date-input-group label {
        display: block;
        margin-bottom: 0.5rem;
        font-weight: 500;
        color: #342e37;
    }

    .date-input {
        width: 100%;
        padding: 0.75rem 1rem;
        border: 1px solid #ddd;
        border-radius: 8px;
        font-family: 'Poppins', sans-serif;
        transition: all 0.3s ease;
        background: white;
    }

    .date-input:focus {
        outline: none;
        border-color: #3c91e6;
        box-shadow: 0 0 0 3px rgba(60, 145, 230, 0.2);
    }

    .search-btn, .reset-btn {
        padding: 0.75rem 1.5rem;
        border-radius: 8px;
        font-family: 'Poppins', sans-serif;
        font-weight: 500;
        display: flex;
        align-items: center;
        gap: 0.5rem;
        cursor: pointer;
        transition: all 0.3s ease;
        border: none;
    }

    .search-btn {
        background: #3c91e6;
        color: white;
    }

    .search-btn:hover {
        background: #2b7dcc;
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(60, 145, 230, 0.3);
    }

    .reset-btn {
        background: #f1f1f1;
        color: #342e37;
    }

    .reset-btn:hover {
        background: #e1e1e1;
        transform: translateY(-2px);
    }

    /* Style pour les résultats de recherche */
    .search-results {
        margin-top: 1.5rem;
    }

    .no-results {
        text-align: center;
        padding: 2rem;
        color: #666;
        font-style: italic;
    }

    /* Animation pour les résultats */
    @keyframes fadeInUp {
        from {
            opacity: 0;
            transform: translateY(20px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    .search-results table tbody tr {
        animation: fadeInUp 0.5s ease-out forwards;
    }

    /* Responsive */
    @media (max-width: 768px) {
        .date-filter-form {
            flex-direction: column;
            gap: 1rem;
        }

        .date-input-group {
            width: 100%;
        }

        .search-btn, .reset-btn {
            width: 100%;
            justify-content: center;
        }
    }
</style>

<!--Stle Btn Recherche entre Deux dates-->
<style>
    .btn-modern {
        padding: 12px 20px;
        background: #2b7dcc;
        color: white;
        border: none;
        border-radius: 12px;
        font-size: 16px;
        font-weight: bold;
        cursor: pointer;
        box-shadow: 0 4px 14px rgba(0, 0, 0, 0.2);
        transition: all 0.3s ease;
      }

      .btn-modern:hover {
        background: #2b7dcc;
        transform: translateY(-2px);
      }
</style>

<!--Juste Stle Pour Que Ce : place-recherche-entre-deux-date Est visible et invisible Apres click Btn-->
<style>
    /* Ajoutez ceci dans votre section <style> */
    .place-recherche-entre-deux-date {
        display: none;
        transition: all 0.3s ease;
    }
    
    .place-recherche-entre-deux-date.show {
        display: block;
        animation: fadeIn 0.5s ease-out;
    }
    
    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(-10px); }
        to { opacity: 1; transform: translateY(0); }
    }
</style>

<!--Css Pour Format PDF Prêts-->
<style>
    .format-pdf {
            max-width: 100%;
            margin: 0 auto;
            background: #ffffff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .format-pdf h2 {
            text-align: center;
            margin-bottom: 30px;
            font-size: 22px;
            color: #333;
        }

        .member-info p {
            margin: 4px 0;
            font-size: 15px;
        }

        .table {
            width: 100% !important;
            border-collapse: collapse !important;
            margin-top: 20px !important;
            margin-bottom: 20px !important;
        }
        
        .table thead tr .th, .table tbody tr .td{
            padding-left: 2rem !important;
        }
        
        .table .thead .tr .th, .table .tbody .tr .td{
            border: 1px solid #ccc !important;
            padding: 10px !important;
            font-size: 14px !important;
            text-align: left !important;            
        }

        .table .thead .tr .th {
            background-color: #f0f0f0 !important;
            font-weight: bold !important;
        }

        .footer-dates p {
            margin: 6px 0 !important;
        }        
        
</style>

<!--Css Btn Telechager PDF et Annuler PDF-->
<style>
    .group-btns-telecharge-annuler {
        display: flex;
        justify-content: center;
        gap: 20px;
        margin-top: 30px;
    }

    .group-btns-telecharge-annuler button {
        width: 100%;
        padding: 12px 24px;
        font-size: 16px;
        font-weight: 600;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        transition: background-color 0.3s ease, transform 0.2s ease;
    }

    .telecharge {
        background-color: #4CAF50;
        color: white;
    }

    .telecharge:hover {
        background-color: #45a049;
        transform: scale(1.05);
    }

    .annuler {
        background-color: #f44336;
        color: white;
    }

    .annuler:hover {
        background-color: #e53935;
        transform: scale(1.05);
    }
</style>


<!--CSS pour améliorer l'apparence-->
<style>
    /* Style général du formulaire */
    #emailForm {
      display: none;
      background: #ffffff;
      border-radius: 12px;
      padding: 2rem;
      max-width: 100%;
      margin: auto;
      margin-bottom: 1.5rem;
      box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      color: #333;
    }

    /* Conteneur des labels et inputs */
    .label-input {
      display: flex;
      flex-direction: column;
      margin-bottom: 1.5rem;
    }

    .label-input label {
      margin-bottom: 0.5rem;
      font-weight: 600;
    }

    .label-input input[type="email"] {
      padding: 0.8rem;
      border: 1px solid #ccc;
      border-radius: 8px;
      font-size: 1rem;
      transition: border-color 0.3s ease;
    }

    .label-input input[type="email"]:focus {
      border-color: #007bff;
      outline: none;
    }

    /* Bloc d'informations */
    .info-et-message-destinataire {
      margin-bottom: 1.5rem;
      background-color: #f9f9f9;
      padding: 1rem;
      border-radius: 8px;
      font-size: 0.95rem;
    }

    .info-et-message-destinataire p {
      margin: 0.4rem 0;
    }

    /* Zone de message */
    .message-block {
      margin-top: 1rem;
    }

    .message-block textarea {
      padding: 1rem;
      border-radius: 8px;
      border: 1px solid #ccc;
      font-size: 1rem;
      background-color: #f0f0f0;
      resize: none;
    }

    /* Boutons */
    button.btn-send, button.btn-cancel {
      padding: 0.75rem 1.5rem;
      border: none;
      border-radius: 8px;
      font-size: 1rem;
      cursor: pointer;
      margin-top: 1rem;
      margin-right: 0.5rem;
      transition: background-color 0.3s ease;
      display: inline-flex;
      align-items: center;
      gap: 0.5rem;
    }

    /* Bouton envoyer */
    button.btn-send {
      background-color: #28a745;
      color: white;
    }

    button.btn-send:hover {
      background-color: #218838;
    }

    /* Bouton annuler */
    button.btn-cancel {
      background-color: #dc3545;
      color: white;
    }

    button.btn-cancel:hover {
      background-color: #c82333;
    }
</style>

<!--CSS pour le statut--> 
<style>
    .status {
        padding: 5px 10px;
        border-radius: 4px;
        font-size: 12px;
        font-weight: 500;
    }

    .status.en_attente {
        background-color: rgb(120, 122, 65) !important;
        color: #856404;
    }

    .status.confirme {
        background-color: rgb(65, 122, 74) !important;
        color: #155724;
        letter-spacing: 1.5 !important;
    }

    .status.annule {
        background-color: #f8d7da;
        color: #721c24;
    }

    .status.termine {
        background-color: #d1ecf1;
        color: #0c5460;
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


<!--Recherche--> 
<style>
    /* Styles pour les statuts */
    .status {
        padding: 5px 10px;
        border-radius: 20px;
        font-size: 0.8em;
        font-weight: 500;
    }
    
    .status.en_attente {
        background-color: #fff3cd;
        color: #856404;
    }
    
    .status.confirme {
        background-color: #d4edda;
        color: #155724;
    }
    
    .status.annule {
        background-color: #f8d7da;
        color: #721c24;
    }
    
    .status.termine {
        background-color: #d1ecf1;
        color: #0c5460;
    }
    
    /* Styles pour la barre de recherche */
    .search-bar {
        margin-bottom: 20px;
    }
    
    .search-container {
        display: flex;
        width: 100%;
        max-width: 500px;
    }
    
    .search-container input {
        flex: 1;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 4px 0 0 4px;
    }
    
    .search-container button {
        padding: 10px 15px;
        background-color: #4CAF50;
        color: white;
        border: none;
        border-radius: 0 4px 4px 0;
        cursor: pointer;
    }
    
    /* Styles pour les messages d'alerte */
    .alert-success {
        padding: 10px;
        background-color: #d4edda;
        color: #155724;
        border: 1px solid #c3e6cb;
        border-radius: 4px;
        margin-bottom: 15px;
    }
    
    .alert-error {
        padding: 10px;
        background-color: #f8d7da;
        color: #721c24;
        border: 1px solid #f5c6cb;
        border-radius: 4px;
        margin-bottom: 15px;
    }
    
    /* Styles pour les icônes d'action */
    .action-icons a, .action-icons button {
        margin: 0 5px;
        color: #555;
        text-decoration: none;
        background: none;
        border: none;
        cursor: pointer;
    }
    
    .action-icons a:hover {
        color: #007bff;
    }
    
    .action-icons button:hover {
        color: #dc3545;
    }
    
    .annule{
        color: black !important;
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
        <!-- ========================================= CONTENT ======================================== -->
        <section id="content">
            <!-- --------------------- Main --------------------- -->
            <main>
                <div class="head-title">
                    <div class="left">
                        <h1>LISTE DES RENDEZ-VOUS</h1>
                        <ul class="breadcrumb">
                            <li><a class="active color" href="/GestionPatient/index.jsp">Tableau de bord</a></li>
                            <li><i class='bx bx-chevron-right'></i></li>
                            <li><a class="active" href="#">Rendez-vous</a></li>
                            <li class="rotation"><i class='bx bx-chevron-right'></i></li>
                        </ul>
                    </div>
                    <a href="/GestionPatient/Components/RendezVous/FrmRendezVous.jsp" class="btn-download">
                        <i class='bx bx-plus'></i>
                        <span class="text">NOUVEAU RENDEZ-VOUS</span>
                    </a>
                </div>


                <div class="table-date">
                    <div class="orber">
                        <div class="head">
                            <h3>Les derniers rendez-vous</h3>
                            <!-- Barre de recherche -->
                            <div class="search-bar">
                                <form action="/GestionPatient/ServletRendezVous" method="GET">
                                    <input type="hidden" name="action" value="search">
                                    <div class="search-container">
                                        <input type="text" name="searchTerm" placeholder="Rechercher un rendez-vous..." 
                                               value="<%= request.getParameter("searchTerm") != null ? request.getParameter("searchTerm") : "" %>">
                                        <button type="submit"><i class='bx bx-search'></i></button>
                                    </div>
                                </form>
                            </div>
                        </div>

                        <%-- Affichage des messages de succès/erreur --%>
                        <% 
                            String success = request.getParameter("success");
                            String error = request.getParameter("error");

                            if (success != null) {
                                String message = "";
                                switch(success) {
                                    case "insert": message = "Rendez-vous ajouté avec succès"; break;
                                    case "update": message = "Rendez-vous modifié avec succès"; break;
                                    case "delete": message = "Rendez-vous supprimé avec succès"; break;
                                }
                        %>
                        <div class="alert-success">
                            <%= message %>
                        </div>
                        <% } else if (error != null) { 
                            String errorMessage = "";
                            switch(error) {
                                case "connexion_bdd": errorMessage = "Erreur de connexion à la base de données"; break;
                                case "rendezvous_non_trouve": errorMessage = "Rendez-vous non trouvé"; break;
                                case "rdv_avec_enfants": errorMessage = "Impossible de supprimer - ce rendez-vous a des rendez-vous enfants"; break;
                                case "id_rdv_manquant": errorMessage = "ID du rendez-vous manquant"; break;
                                case "term_recherche_vide": errorMessage = "Veuillez entrer un terme de recherche"; break;
                                default: errorMessage = "Erreur système: " + error;
                            }
                        %>
                        <div class="alert-error">
                            <%= errorMessage %>
                        </div>
                        <% } %>

                        <table>
                            <thead class="thead">
                                <tr>
                                    <!--<th>ID</th>-->
                                    <th>PATIENT</th>
                                    <th>PRATICIEN</th>
                                    <th>DATE & HEURE</th>
                                    <th>STATUT</th>
                                    <!--<th>RDV PARENT</th>-->
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
                                        String sql;

                                        // Vérifie si c'est une recherche
                                        if (request.getParameter("action") != null && request.getParameter("action").equals("search") 
                                            && request.getParameter("searchTerm") != null && !request.getParameter("searchTerm").isEmpty()) {
                                            String searchTerm = request.getParameter("searchTerm");
                                            sql = "SELECT r.*, p.nom as nomPatient, p.prenom as prenomPatient, "
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

                                            stmt = conn.prepareStatement(sql);
                                            String likeTerm = "%" + searchTerm + "%";
                                            for (int i = 1; i <= 9; i++) {
                                                stmt.setString(i, likeTerm);
                                            }
                                        } else {
                                            // Requête normale
                                            sql = "SELECT r.*, p.nom as nomPatient, p.prenom as prenomPatient, "
                                                + "pr.nom as nomPraticien, pr.prenom as prenomPraticien "
                                                + "FROM rendezvous r "
                                                + "LEFT JOIN patients p ON r.cinPatient = p.cinPatient "
                                                + "LEFT JOIN praticiens pr ON r.cinPraticien = pr.cinPraticien "
                                                + "ORDER BY r.dateHeure DESC";
                                            stmt = conn.prepareStatement(sql);
                                        }

                                        rs = stmt.executeQuery();

                                        while (rs.next()) {
                                            int idRdv = rs.getInt("idRdv");
                                            String cinPatient = rs.getString("cinPatient");
                                            String nomPatient = rs.getString("nomPatient");
                                            String prenomPatient = rs.getString("prenomPatient");
                                            String cinPraticien = rs.getString("cinPraticien");
                                            String nomPraticien = rs.getString("nomPraticien");
                                            String prenomPraticien = rs.getString("prenomPraticien");
                                            Timestamp dateHeure = rs.getTimestamp("dateHeure");
                                            String statut = rs.getString("statut");
                                            String idRdvParent = rs.getString("idRdvParent");
                                %>
                                <tr>
                                    <!--<td><%= idRdv %></td>-->
                                    <!--<td><%= cinPatient %> - <%= prenomPatient %> <%= nomPatient %></td>-->
                                    <td><%= prenomPatient %> <%= nomPatient %></td>
                                    <!--<td><%= cinPraticien %> - <%= prenomPraticien %> <%= nomPraticien %></td>-->
                                    <td><%= prenomPraticien %> <%= nomPraticien %></td>
                                    <td><%= new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(dateHeure) %></td>
                                    <td>
                                        <span class="status <%= statut %>">
                                            <%
                                                String statutText = "";
                                                switch(statut) {
                                                    case "en_attente": statutText = "En attente"; break;
                                                    case "confirme": statutText = "Confirmé"; break;
                                                    case "annule": statutText = "Annulé 😥"; break;
                                                    case "termine": statutText = "Terminé"; break;
                                                    default: statutText = statut;
                                                }
                                            %>
                                            <%= statutText %>
                                        </span>
                                    </td>
                                    <!--<td><%= (idRdvParent != null ? idRdvParent : "-") %></td>-->
                                    <td class="action-icons">
                                        <a href="/GestionPatient/ServletRendezVous?action=edit&idRdv=<%= idRdv %>" 
                                            aria-label="Modifier" title="Modifier">
                                            <i class='bx bx-edit'></i>
                                        </a>
                                        <form method="GET" action="/GestionPatient/ServletRendezVous" style="display:inline;">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="idRdv" value="<%= idRdv %>">
                                            <button type="submit" class="btn btn-danger btn-invisble" onclick="return confirm('⚠️ Supprimer ce rendez-vous ?')">
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
                        <a href="#"><i class='bx bx-up-arrow-alt'></i></a>
                    </div>
                </footer>
            </main>
            <!-- --------------------- Fin Main ----------------- -->
        </section>
    </body>
</html>
