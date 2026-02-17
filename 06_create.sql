-- =====================================
-- SCHEMA (DATABASE)
-- =====================================
CREATE SCHEMA IF NOT EXISTS company
DEFAULT CHARACTER SET utf8
DEFAULT COLLATE utf8_czech_ci;

USE company;

-- =========================
-- TABULKA: servers
-- =========================
CREATE TABLE servers (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(30) NOT NULL UNIQUE,
    os VARCHAR(30) NOT NULL,
    os_ver VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
) ENGINE=InnoDB;

-- =========================
-- TABULKA: services
-- =========================
CREATE TABLE services (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(30) NOT NULL,
    s_type ENUM('aplikační', 'síťová') NOT NULL,
    s_ver VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
) ENGINE=InnoDB;

-- ==========================================
-- POMOCNÁ TABULKA: services_running_on_servers
-- ==========================================
CREATE TABLE services_running_on_servers (
    servers_id INT UNSIGNED NOT NULL,
    services_id INT UNSIGNED NOT NULL,
    domain VARCHAR(255) NULL,
    IPv4 VARCHAR(15) NULL,
    IPv6 VARCHAR(39) NULL,
    port INT NULL,
    protocol VARCHAR(20) NULL,
    mode VARCHAR(20) NULL,
    startup DATETIME NULL,

    -- složený primární klíč
    PRIMARY KEY (servers_id, services_id),

    -- cizí klíče
    CONSTRAINT fk_sros_server
        FOREIGN KEY (servers_id)
        REFERENCES servers(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_sros_service
        FOREIGN KEY (services_id)
        REFERENCES services(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;
