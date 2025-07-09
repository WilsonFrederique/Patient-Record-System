-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mer. 09 juil. 2025 à 02:31
-- Version du serveur : 10.4.24-MariaDB
-- Version de PHP : 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `patient`
--

-- --------------------------------------------------------

--
-- Structure de la table `consultations`
--

CREATE TABLE `consultations` (
  `idConsult` int(11) NOT NULL,
  `idRdv` int(11) NOT NULL,
  `dateConsult` datetime NOT NULL DEFAULT current_timestamp(),
  `compteRendu` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `consultations`
--

INSERT INTO `consultations` (`idConsult`, `idRdv`, `dateConsult`, `compteRendu`, `created_at`, `updated_at`) VALUES
(45, 48, '2025-07-07 18:16:00', 'Gros coeur', '2025-05-25 18:47:06', '2025-07-07 16:16:39'),
(48, 46, '2025-07-07 18:17:00', 'Diabete', '2025-05-25 19:01:21', '2025-07-07 16:18:55'),
(79, 52, '2025-07-08 18:47:00', 'Diabete', '2025-07-08 18:47:57', '2025-07-08 19:48:52');

-- --------------------------------------------------------

--
-- Structure de la table `examens`
--

CREATE TABLE `examens` (
  `idExamen` int(11) NOT NULL,
  `idPrescrire` int(11) NOT NULL,
  `typeExamen` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dateRealisation` datetime DEFAULT NULL,
  `statut` enum('Prescrit','En cours','Réalisé','Validé','Annulé','Refusé','Résultat transmis') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Prescrit',
  `resultat` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` longblob DEFAULT NULL,
  `laboratoire` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `examens`
--

INSERT INTO `examens` (`idExamen`, `idPrescrire`, `typeExamen`, `dateRealisation`, `statut`, `resultat`, `image`, `laboratoire`, `created_at`, `updated_at`) VALUES
(31, 11, 'Biologie sanguine', '2023-07-09 08:00:00', 'Prescrit', 'Résultat en attente', NULL, '	Laboratoire Pasteur', '2025-07-08 22:51:14', '2025-07-08 22:51:14'),
(32, 15, 'Radiographie thoracique', '2024-05-10 13:00:00', 'Réalisé', 'Pas d’anomalie détectée', NULL, 'Imagerie Médicale Centre', '2025-07-08 22:52:10', '2025-07-08 23:37:31'),
(34, 16, 'Analyse d’urine', '2025-01-01 16:00:00', 'Validé', 'Présence de glucose détectée', NULL, '	BioSanté', '2025-07-08 22:54:10', '2025-07-08 22:54:10'),
(35, 10, 'Scanner abdomino-pelvien', '2025-07-08 08:00:00', 'Annulé', NULL, NULL, 'Centre Scanner Nord', '2025-07-08 22:55:26', '2025-07-08 22:55:26'),
(36, 11, 'IRM cérébrale', '2025-07-08 15:00:00', 'En cours', NULL, NULL, 'IRM Clinique Sud', '2025-07-08 22:56:14', '2025-07-08 22:56:14');

-- --------------------------------------------------------

--
-- Structure de la table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `executed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `migrations`
--

INSERT INTO `migrations` (`id`, `name`, `executed_at`) VALUES
(23, '001_create_table_patients.sql', '2025-04-26 14:27:28'),
(24, '002_create_table_praticien.sql', '2025-04-26 14:27:28'),
(25, '003_create_table_rendezVous.sql', '2025-04-26 14:27:29'),
(26, '004_create_table_consultations.sql', '2025-04-26 14:27:29'),
(31, '005_create_table_prescrires.sql', '2025-05-14 16:57:10'),
(33, '006_create_table_examens.sql', '2025-05-15 15:19:52');

-- --------------------------------------------------------

--
-- Structure de la table `patients`
--

CREATE TABLE `patients` (
  `cinPatient` varchar(14) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `age` int(11) NOT NULL,
  `sexe` varchar(50) DEFAULT NULL CHECK (`sexe` in ('Homme','Femme')),
  `adresse` varchar(50) DEFAULT NULL,
  `telephone` varchar(17) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `patients`
--

INSERT INTO `patients` (`cinPatient`, `nom`, `prenom`, `age`, `sexe`, `adresse`, `telephone`, `email`) VALUES
('0102 3014 5214', 'Mirana', 'Frizy', 16, NULL, 'Tanambao', '261 02 58 741 20', 'mirana@gmail.com'),
('0123 1234 2541', 'Jacque', 'Jeanot', 20, 'Homme', 'Ampitakely', '261 38 84 998 12', 'jacque@gmail.com'),
('0215 7120 3120', 'Solange', 'Hanta', 30, 'Femme', 'Idanda', '261 38 56 201 42', 'solange@gmail.com'),
('0235 4120 1452', 'Nomena', 'Ravaka', 18, 'Femme', 'Tanambao', '261 20 44 444 44', 'ravaka@gmail.com'),
('1', 'Jean', 'Koto', 11, NULL, 'sss', '0204444444', 'aa@gmail.com'),
('2145 0247 8999', 'Hery', 'Mirado', 20, 'Homme', 'Tsaramandroso', '261 28 45 211 10', 'hery@gmail.com');

-- --------------------------------------------------------

--
-- Structure de la table `praticiens`
--

CREATE TABLE `praticiens` (
  `cinPraticien` varchar(14) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `telephone` varchar(17) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `specialite` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `praticiens`
--

INSERT INTO `praticiens` (`cinPraticien`, `nom`, `prenom`, `telephone`, `email`, `specialite`) VALUES
('0142 3657 4120', 'RAFALY', 'Mirana', '261 02 12 312 01', 'faly@gmail.com', 'generaliste'),
('0214 5210 3201', 'RASOLONDRAIBE', 'George', '261 02 45 873 20', 'sss@gmail.com', 'ginecologue'),
('1230 1452 0021', 'MAMINIAINA', 'Felicia', '+261 02 04 568 74', 'cia@gmail.com', 'generaliste'),
('1234 0213 2014', 'Dupont', 'Marcial', '+261 33 84 745 45', 'zzz@gmail.com', 'ginecologue'),
('1452 7852 0000', 'RAMANANKASINA', 'Rija', '+261 20 00 144 25', 'kkkkkk@gmail.com', 'ginecologue'),
('7851 0213 2014', 'Manana', 'Jeane', '+261 34 84 745 01', 'dup@gmail.com', 'generaliste');

-- --------------------------------------------------------

--
-- Structure de la table `prescriptions`
--

CREATE TABLE `prescriptions` (
  `idPrescrire` int(11) NOT NULL,
  `idConsult` int(11) NOT NULL,
  `typePrescrire` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `posologie` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `datePrescrire` datetime NOT NULL DEFAULT curdate(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `prescriptions`
--

INSERT INTO `prescriptions` (`idPrescrire`, `idConsult`, `typePrescrire`, `posologie`, `datePrescrire`, `created_at`, `updated_at`) VALUES
(10, 48, 'Traitement', '1 comprimé de Paracétamol 500mg, 3 fois par jour après les repas pendant 5 jours.', '2025-05-25 22:09:00', '2025-05-25 19:10:00', '2025-07-08 20:43:36'),
(11, 45, 'Arrêt de travail', 'Reprise progressive le 6ème jour selon tolérance', '2025-07-08 22:10:00', '2025-05-25 19:10:25', '2025-07-08 20:50:34'),
(15, 79, 'Recommandations hygiéno-diététiques', '150 min/semaine d\'exercice modéré (marche rapide)', '2025-07-08 20:37:00', '2025-07-08 20:38:58', '2025-07-08 20:56:11'),
(16, 45, 'Examen', NULL, '2025-07-06 20:56:00', '2025-07-08 20:57:00', '2025-07-08 20:57:00');

-- --------------------------------------------------------

--
-- Structure de la table `rendezvous`
--

CREATE TABLE `rendezvous` (
  `idRdv` int(11) NOT NULL,
  `cinPatient` varchar(14) NOT NULL,
  `cinPraticien` varchar(14) NOT NULL,
  `dateHeure` datetime NOT NULL,
  `statut` varchar(20) NOT NULL DEFAULT 'en_attente' CHECK (`statut` in ('en_attente','confirme','annule')),
  `idRdvParent` varchar(14) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `rendezvous`
--

INSERT INTO `rendezvous` (`idRdv`, `cinPatient`, `cinPraticien`, `dateHeure`, `statut`, `idRdvParent`, `created_at`, `updated_at`) VALUES
(46, '0102 3014 5214', '7851 0213 2014', '2025-07-14 00:00:00', 'confirme', NULL, '2025-05-15 23:00:08', '2025-07-08 18:44:19'),
(48, '0123 1234 2541', '0142 3657 4120', '2025-07-14 23:01:00', 'confirme', NULL, '2025-05-15 23:01:36', '2025-07-08 18:44:12'),
(52, '2145 0247 8999', '0214 5210 3201', '2025-07-25 17:53:00', 'confirme', NULL, '2025-05-25 17:53:15', '2025-07-07 18:09:33'),
(64, '0123 1234 2541', '0214 5210 3201', '2025-07-01 08:00:00', 'en_attente', NULL, '2025-06-30 17:46:23', '2025-06-30 17:46:23'),
(79, '0123 1234 2541', '0142 3657 4120', '2025-07-08 08:00:00', 'en_attente', NULL, '2025-07-06 20:12:30', '2025-07-07 18:06:29'),
(106, '1', '1230 1452 0021', '2025-07-17 14:32:00', 'annule', NULL, '2025-07-07 12:32:13', '2025-07-07 13:06:24');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `consultations`
--
ALTER TABLE `consultations`
  ADD PRIMARY KEY (`idConsult`),
  ADD KEY `fk_consult_rdv` (`idRdv`),
  ADD KEY `idx_date_consult` (`dateConsult`);

--
-- Index pour la table `examens`
--
ALTER TABLE `examens`
  ADD PRIMARY KEY (`idExamen`),
  ADD KEY `fk_examen_prescription` (`idPrescrire`),
  ADD KEY `idx_type_examen` (`typeExamen`),
  ADD KEY `idx_date_realisation` (`dateRealisation`);

--
-- Index pour la table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Index pour la table `patients`
--
ALTER TABLE `patients`
  ADD PRIMARY KEY (`cinPatient`),
  ADD UNIQUE KEY `telephone` (`telephone`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Index pour la table `praticiens`
--
ALTER TABLE `praticiens`
  ADD PRIMARY KEY (`cinPraticien`),
  ADD UNIQUE KEY `telephone` (`telephone`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Index pour la table `prescriptions`
--
ALTER TABLE `prescriptions`
  ADD PRIMARY KEY (`idPrescrire`),
  ADD KEY `fk_presc_consult` (`idConsult`),
  ADD KEY `idx_medicament` (`typePrescrire`),
  ADD KEY `idx_date_presc` (`datePrescrire`);

--
-- Index pour la table `rendezvous`
--
ALTER TABLE `rendezvous`
  ADD PRIMARY KEY (`idRdv`),
  ADD KEY `cinPatient` (`cinPatient`),
  ADD KEY `cinPraticien` (`cinPraticien`),
  ADD KEY `idRdvParent` (`idRdvParent`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `consultations`
--
ALTER TABLE `consultations`
  MODIFY `idConsult` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=87;

--
-- AUTO_INCREMENT pour la table `examens`
--
ALTER TABLE `examens`
  MODIFY `idExamen` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT pour la table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT pour la table `prescriptions`
--
ALTER TABLE `prescriptions`
  MODIFY `idPrescrire` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT pour la table `rendezvous`
--
ALTER TABLE `rendezvous`
  MODIFY `idRdv` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=107;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `consultations`
--
ALTER TABLE `consultations`
  ADD CONSTRAINT `fk_consult_rdv` FOREIGN KEY (`idRdv`) REFERENCES `rendezvous` (`idRdv`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `examens`
--
ALTER TABLE `examens`
  ADD CONSTRAINT `fk_examen_prescription` FOREIGN KEY (`idPrescrire`) REFERENCES `prescriptions` (`idPrescrire`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `prescriptions`
--
ALTER TABLE `prescriptions`
  ADD CONSTRAINT `fk_presc_consult` FOREIGN KEY (`idConsult`) REFERENCES `consultations` (`idConsult`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `rendezvous`
--
ALTER TABLE `rendezvous`
  ADD CONSTRAINT `rendezvous_ibfk_1` FOREIGN KEY (`cinPatient`) REFERENCES `patients` (`cinPatient`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `rendezvous_ibfk_2` FOREIGN KEY (`cinPraticien`) REFERENCES `praticiens` (`cinPraticien`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `rendezvous_ibfk_3` FOREIGN KEY (`idRdvParent`) REFERENCES `praticiens` (`cinPraticien`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
