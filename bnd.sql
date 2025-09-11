-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 11. Sep 2025 um 07:36
-- Server-Version: 10.4.32-MariaDB
-- PHP-Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `bnd`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `achievements`
--

CREATE TABLE `achievements` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `icon` varchar(100) DEFAULT 'default_badge.png'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `commands`
--

CREATE TABLE `commands` (
  `id` int(10) UNSIGNED NOT NULL,
  `program_id` int(11) NOT NULL,
  `keyword` varchar(50) NOT NULL,
  `description` varchar(100) NOT NULL,
  `explanation` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `emails`
--

CREATE TABLE `emails` (
  `id` int(11) NOT NULL,
  `template_id` int(11) NOT NULL,
  `recipient_id` int(11) NOT NULL,
  `sent_at` datetime NOT NULL DEFAULT current_timestamp(),
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `is_phishing_copy` tinyint(1) NOT NULL DEFAULT 0,
  `phishing_analysis_data_copy` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`phishing_analysis_data_copy`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `email_templates`
--

CREATE TABLE `email_templates` (
  `id` int(11) NOT NULL,
  `sender_name` varchar(255) NOT NULL,
  `sender_email` varchar(255) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `body_html` longtext NOT NULL,
  `is_phishing` tinyint(1) NOT NULL DEFAULT 0,
  `target_level_id` int(11) DEFAULT NULL,
  `phishing_analysis_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`phishing_analysis_data`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `email_templates`
--

INSERT INTO `email_templates` (`id`, `sender_name`, `sender_email`, `subject`, `body_html`, `is_phishing`, `target_level_id`, `phishing_analysis_data`) VALUES
(1, 'BND Missionsleitung', 'mission@bnd.bund.de', 'Ihre erste Mission wartet!', '<html><head><style>body { font-family: Arial, sans-serif; background-color: #0d0d0d; color: #e0e0e0; margin: 0; padding: 20px; } .container { background-color: #1a1a1a; border: 1px solid #333; border-radius: 8px; padding: 25px; box-shadow: 0 0 15px rgba(0, 255, 127, 0.1); } h2 { color: #00ff7f; border-bottom: 2px solid #00ff7f; padding-bottom: 10px; margin-bottom: 20px; } p { margin-bottom: 10px; line-height: 1.6; } .highlight { color: #f0e68c; font-weight: bold; } .command { background-color: #2a2a2a; padding: 8px 12px; border-radius: 5px; font-family: \"Courier New\", monospace; color: #00ff7f; display: inline-block; margin-top: 10px; } .signature { margin-top: 30px; padding-top: 10px; border-top: 1px dashed #333; font-size: 0.9em; color: #aaa; }</style></head><body><div class=\"container\"><h2>Willkommen bei der Cyber-Abwehr, Rekrut!</h2><p>Ihre Ausbildung beginnt jetzt. Ihre erste Aufgabe ist von entscheidender Bedeutung, um Ihre Fähigkeiten in der Netzwerkanalyse zu testen.</p><p>Wir haben verdächtige Aktivitäten in unserem Trainings-Netzwerk (<span class=\"highlight\">10.0.10.0/24</span>) festgestellt. Ihre erste Mission ist es, sich einen Überblick über alle aktiven Geräte in diesem Subnetz zu verschaffen.</p><p>Führen Sie dazu den folgenden Befehl in Ihrer <strong>Konsole</strong> aus:</p><p><span class=\"command\">nmap -sn 10.0.10.0/24</span></p><p>Analysieren Sie die Ausgabe sorgfältig auf verdächtige Adressen. Nach Abschluss des Scans erhalten Sie weitere Anweisungen.</p><div class=\"signature\"><p>Mit freundlichen Grüßen,</p><p>Schmidt<br>Ausbilder, BND Cyber-Abteilung</p></div></div></body></html>', 0, 1, NULL),
(2, 'Ausbilder Schmidt', 'schmidt@bnd.de', 'Neue Aufgabe: Detailanalyse des Verdächtigen!', '<html><head><style>body { font-family: Arial, sans-serif; background-color: #0d0d0d; color: #e0e0e0; margin: 0; padding: 20px; } .container { background-color: #1a1a1a; border: 1px solid #333; border-radius: 8px; padding: 25px; box-shadow: 0 0 15px rgba(0, 255, 127, 0.1); } h2 { color: #00ff7f; border-bottom: 2px solid #00ff7f; padding-bottom: 10px; margin-bottom: 20px; } p { margin-bottom: 10px; line-height: 1.6; } .highlight { color: #f0e68c; font-weight: bold; } .command { background-color: #2a2a2a; padding: 8px 12px; border-radius: 5px; font-family: \"Courier New\", monospace; color: #00ff7f; display: inline-block; margin-top: 10px; } .signature { margin-top: 30px; padding-top: 10px; border-top: 1px dashed #333; font-size: 0.9em; color: #aaa; }</style></head><body><div class=\"container\"><h2>Detailanalyse erforderlich: Verdächtiger Host entdeckt!</h2><p>Rekrut,</p><p>Ihr erster Netzwerk-Scan war erfolgreich und hat mehrere aktive Hosts gezeigt. Besonders auffällig ist die IP-Adresse <span class=\"highlight\">10.0.10.13</span>, die verdächtige Muster aufweist.</p><p>Ihre nächste Aufgabe ist es, eine detaillierte Analyse dieses Hosts durchzuführen, um alle offenen Ports, laufenden Dienste, das Betriebssystem und mögliche Spuren zu finden.</p><p>Führen Sie dazu einen <strong>aggressiven Nmap-Scan</strong> auf diesem Host durch:</p><p><span class=\"command\">nmap -A 10.0.10.13</span></p><p>Analysieren Sie die Ergebnisse genau und melden Sie alle gefundenen Anomalien.</p><div class=\"signature\"><p>Schmidt<br>Ausbilder, BND Cyber-Abteilung</p></div></div></body></html>', 0, NULL, NULL),
(3, 'Bundeskanzleramt', 'kanzler@bundeskanzleramt.de', 'Wichtige Anweisung vom Bundeskanzleramt (Phishing-Versuch)', '<html><head><style>body { font-family: Arial, sans-serif; background-color: #0d0d0d; color: #e0e0e0; margin: 0; padding: 20px; } .container { background-color: #1a1a1a; border: 1px solid #333; border-radius: 8px; padding: 25px; box-shadow: 0 0 15px rgba(255, 0, 0, 0.2); } h2 { color: #ff4d4d; border-bottom: 2px solid #ff4d4d; padding-bottom: 10px; margin-bottom: 20px; } p { margin-bottom: 10px; line-height: 1.6; } .highlight { color: #f0e68c; font-weight: bold; } .warning { color: #ff4d4d; font-weight: bold; } .command { background-color: #2a2a2a; padding: 8px 12px; border-radius: 5px; font-family: \"Courier New\", monospace; color: #00ff7f; display: inline-block; margin-top: 10px; } .signature { margin-top: 30px; padding-top: 10px; border-top: 1px dashed #333; font-size: 0.9em; color: #aaa; }</style></head><body><div class=\"container\"><h2>DRINGEND: Neue Sicherheitsrichtlinien!</h2><p><span class=\"warning\">WICHTIG:</span> An alle Mitarbeiter des BND!</p><p>Aufgrund der jüngsten Cyber-Vorfälle ist es zwingend erforderlich, dass alle Mitarbeiter umgehend die neuen Sicherheitsrichtlinien bestätigen.</p><p>Bitte klicken Sie auf den folgenden Link, um Ihre Identität zu verifizieren und die Richtlinien einzusehen:</p><p><a href=\"http://secure-bnd-portal.ru/direktive.php\" target=\"_blank\" class=\"command\" style=\"color: #ff4d4d;\">Zum BND Sicherheitsportal</a></p><p>Ihre sofortige Kooperation ist entscheidend für die nationale Sicherheit.</p><div class=\"signature\"><p>Mit freundlichen Grüßen,</p><p>Das Bundeskanzleramt<br>Abteilung für Cybersicherheit</p></div></div></body></html>', 1, NULL, NULL),
(4, 'Ausbilder Schmidt', 'schmidt@bnd.de', 'Aktion erforderlich: Kritische Schwachstelle!', '<html><head><style>body { font-family: Arial, sans-serif; background-color: #0d0d0d; color: #e0e0e0; margin: 0; padding: 20px; } .container { background-color: #1a1a1a; border: 1px solid #333; border-radius: 8px; padding: 25px; box-shadow: 0 0 15px rgba(0, 255, 127, 0.1); } h2 { color: #00ff7f; border-bottom: 2px solid #00ff7f; padding-bottom: 10px; margin-bottom: 20px; } p { margin-bottom: 10px; line-height: 1.6; } .highlight { color: #f0e68c; font-weight: bold; } .command { background-color: #2a2a2a; padding: 8px 12px; border-radius: 5px; font-family: \"Courier New\", monospace; color: #00ff7f; display: inline-block; margin-top: 10px; } .signature { margin-top: 30px; padding-top: 10px; border-top: 1px dashed #333; font-size: 0.9em; color: #aaa; }</style></head><body><div class=\"container\"><h2>Aktion erforderlich: Kritische Schwachstelle!</h2><p>Rekrut,</p><p>Ihre aggressive Analyse des Hosts 10.0.10.13 war höchst aufschlussreich! Es wurde bestätigt: Ein offener Port <span class=\"highlight\">1337</span>, der einen aktiven Trojaner-Dienst beherbergt.</p><p>Dies ist der Ausgangspunkt der Bedrohung und muss sofort eliminiert werden. Sie müssen diesen Port auf dem kompromittierten System unverzüglich blockieren.</p><p>Nutzen Sie dafür das Ihnen vertraute \"ufw\"-Tool. Führen Sie den folgenden Befehl in Ihrer Konsole aus:</p><p><span class=\"command\">sudo ufw deny 1337</span></p><p>Bestätigen Sie die Ausführung und warten Sie auf die Systemmeldung. Dies wird die Bedrohung eindämmen.</p><div class=\"signature\"><p>Mit höchster Priorität,</p><p>Schmidt<br>Ausbilder, BND Cyber-Abteilung</p></div></div></body></html>', 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `levels`
--

CREATE TABLE `levels` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `entry_point_file` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `malware`
--

CREATE TABLE `malware` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `type` varchar(50) NOT NULL COMMENT 'z.B. Trojaner, Ransomware, Spyware',
  `description` text NOT NULL,
  `effect_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`effect_json`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `missions`
--

CREATE TABLE `missions` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `missions`
--

INSERT INTO `missions` (`id`, `name`, `description`) VALUES
(1, 'Netzwerk-Analyse und Eindämmung', 'Identifizieren Sie verdächtige Aktivitäten im internen Netzwerk und neutralisieren Sie die Bedrohung.'),
(2, 'Phishing-Analyse und Berichterstattung', 'Analysieren Sie einen Phishing-Versuch, identifizieren Sie die Quelle und melden Sie den Vorfall.');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `mission_progress`
--

CREATE TABLE `mission_progress` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `mission_id` int(11) NOT NULL,
  `current_step` int(11) NOT NULL DEFAULT 1,
  `status` enum('active','completed','failed') NOT NULL DEFAULT 'active',
  `is_completed` tinyint(1) NOT NULL DEFAULT 0,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `mission_steps`
--

CREATE TABLE `mission_steps` (
  `id` int(11) NOT NULL,
  `mission_id` int(11) NOT NULL,
  `step_number` int(11) NOT NULL,
  `next_step_id` int(11) DEFAULT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `npc_actors`
--

CREATE TABLE `npc_actors` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `origin_country` varchar(50) NOT NULL,
  `ip_range` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `preferred_malware_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `player_devices`
--

CREATE TABLE `player_devices` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `hostname` varchar(100) DEFAULT 'default-pc',
  `os_type` varchar(50) DEFAULT 'Linux',
  `gateway_ip` varchar(45) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `ports` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '{"80":{"status":"closed"},"443":{"status":"closed"},"22":{"status":"closed"}}' CHECK (json_valid(`ports`)),
  `firewall_rules` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '[]' CHECK (json_valid(`firewall_rules`)),
  `installed_software` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '[]' CHECK (json_valid(`installed_software`)),
  `event_log` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


--
-- Tabellenstruktur für Tabelle `programs`
--

CREATE TABLE `programs` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `executable_name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `is_unlocked` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `programs`
--

INSERT INTO `programs` (`id`, `name`, `executable_name`, `description`, `is_unlocked`) VALUES
(1, 'Nmap', 'nmap', 'Netzwerk-Scanner zum Erkennen von Hosts und Diensten.', 1),
(2, 'UFW Firewall', 'ufw', 'Einfache Firewall-Verwaltung für Linux.', 0),
(3, 'E-Mail Header Analyse', 'analyze_email_header', 'Tool zur detaillierten Analyse von E-Mail-Headern.', 0),
(4, 'WHOIS Abfrage', 'whois', 'Abfrage von Registrierungsdaten für IP-Adressen und Domains.', 0),
(5, 'Phishing Melde-Tool', 'report_phishing_ip', 'Tool zum Melden von Phishing-Quellen.', 0);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `device_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



--
-- Tabellenstruktur für Tabelle `user_achievements`
--

CREATE TABLE `user_achievements` (
  `user_id` int(11) NOT NULL,
  `achievement_id` int(10) UNSIGNED NOT NULL,
  `earned_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `user_favorites`
--

CREATE TABLE `user_favorites` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `url` varchar(2048) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `achievements`
--
ALTER TABLE `achievements`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `commands`
--
ALTER TABLE `commands`
  ADD PRIMARY KEY (`id`),
  ADD KEY `program_id` (`program_id`);

--
-- Indizes für die Tabelle `emails`
--
ALTER TABLE `emails`
  ADD PRIMARY KEY (`id`),
  ADD KEY `emails_ibfk_1` (`template_id`),
  ADD KEY `emails_ibfk_2` (`recipient_id`);

--
-- Indizes für die Tabelle `email_templates`
--
ALTER TABLE `email_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `levels`
--
ALTER TABLE `levels`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `malware`
--
ALTER TABLE `malware`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `missions`
--
ALTER TABLE `missions`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `mission_progress`
--
ALTER TABLE `mission_progress`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id_mission_id` (`user_id`,`mission_id`),
  ADD KEY `mission_id` (`mission_id`);

--
-- Indizes für die Tabelle `mission_steps`
--
ALTER TABLE `mission_steps`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mission_id_step_number` (`mission_id`,`step_number`),
  ADD KEY `next_step_id` (`next_step_id`);

--
-- Indizes für die Tabelle `npc_actors`
--
ALTER TABLE `npc_actors`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `player_devices`
--
ALTER TABLE `player_devices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indizes für die Tabelle `programs`
--
ALTER TABLE `programs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `executable_name` (`executable_name`);

--
-- Indizes für die Tabelle `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `ip_address` (`ip_address`);

--
-- Indizes für die Tabelle `user_achievements`
--
ALTER TABLE `user_achievements`
  ADD PRIMARY KEY (`user_id`,`achievement_id`),
  ADD KEY `achievement_id` (`achievement_id`);

--
-- Indizes für die Tabelle `user_favorites`
--
ALTER TABLE `user_favorites`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `achievements`
--
ALTER TABLE `achievements`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `commands`
--
ALTER TABLE `commands`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `emails`
--
ALTER TABLE `emails`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `email_templates`
--
ALTER TABLE `email_templates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT für Tabelle `levels`
--
ALTER TABLE `levels`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `malware`
--
ALTER TABLE `malware`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `missions`
--
ALTER TABLE `missions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT für Tabelle `mission_progress`
--
ALTER TABLE `mission_progress`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT für Tabelle `mission_steps`
--
ALTER TABLE `mission_steps`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT für Tabelle `npc_actors`
--
ALTER TABLE `npc_actors`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `player_devices`
--
ALTER TABLE `player_devices`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT für Tabelle `programs`
--
ALTER TABLE `programs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT für Tabelle `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT für Tabelle `user_favorites`
--
ALTER TABLE `user_favorites`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `commands`
--
ALTER TABLE `commands`
  ADD CONSTRAINT `commands_ibfk_1` FOREIGN KEY (`program_id`) REFERENCES `programs` (`id`) ON DELETE CASCADE;

--
-- Constraints der Tabelle `emails`
--
ALTER TABLE `emails`
  ADD CONSTRAINT `emails_ibfk_1` FOREIGN KEY (`template_id`) REFERENCES `email_templates` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `emails_ibfk_2` FOREIGN KEY (`recipient_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints der Tabelle `mission_progress`
--
ALTER TABLE `mission_progress`
  ADD CONSTRAINT `mission_progress_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `mission_progress_ibfk_2` FOREIGN KEY (`mission_id`) REFERENCES `missions` (`id`) ON DELETE CASCADE;

--
-- Constraints der Tabelle `mission_steps`
--
ALTER TABLE `mission_steps`
  ADD CONSTRAINT `mission_steps_ibfk_1` FOREIGN KEY (`mission_id`) REFERENCES `missions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `mission_steps_ibfk_2` FOREIGN KEY (`next_step_id`) REFERENCES `mission_steps` (`id`) ON DELETE SET NULL;

--
-- Constraints der Tabelle `player_devices`
--
ALTER TABLE `player_devices`
  ADD CONSTRAINT `player_devices_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints der Tabelle `user_achievements`
--
ALTER TABLE `user_achievements`
  ADD CONSTRAINT `user_achievements_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_achievements_ibfk_2` FOREIGN KEY (`achievement_id`) REFERENCES `achievements` (`id`) ON DELETE CASCADE;

--
-- Constraints der Tabelle `user_favorites`
--
ALTER TABLE `user_favorites`
  ADD CONSTRAINT `user_favorites_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
