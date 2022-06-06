CREATE DATABASE IF NOT EXISTS caculligiorgio_ex2 CHARACTER SET = 'utf8';

USE caculligiorgio_ex2;

CREATE TABLE IF NOT EXISTS eleve (
    mateleve VARCHAR(50) NOT NULL,
    nomeleve VARCHAR(50) NOT NULL,
    prenomeleve VARCHAR(50) NOT NULL,
    prenomeleve2 VARCHAR(50) NULL,
    datenaiseleve DATE NOT NULL,
    idclasse INTEGER(3) NOT NULL,
    PRIMARY KEY(mateleve),
    KEY(idclasse)
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS classe (
    idclasse INTEGER(3) AUTO_INCREMENT NOT NULL,
    annee VARCHAR(20) NOT NULL,
    nbmaxeleves INTEGER(3) NOT NULL,
    PRIMARY KEY(idclasse)
) ENGINE=INNODB;

ALTER TABLE eleve ADD CONSTRAINT fk_fait_partie FOREIGN KEY(idclasse) REFERENCES classe(idclasse);

CREATE TABLE IF NOT EXISTS enseignant (
    matenseignant CHAR(15) NOT NULL,
    nomenseignant VARCHAR(50) NOT NULL,
    prenomenseignant VARCHAR(50) NOT NULL,
    dateentreefonction DATETIME NOT NULL,
    nomsyndicat VARCHAR(25) NULL,
    PRIMARY KEY(matenseignant),
    KEY(nomsyndicat)
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS syndicat (
    nomsyndicat VARCHAR(25) NOT NULL,
    budget REAL(10,2) NOT NULL,
    PRIMARY KEY(nomsyndicat)
) ENGINE=INNODB;

ALTER TABLE enseignant ADD CONSTRAINT fk_est_represente_par FOREIGN KEY(nomsyndicat) REFERENCES syndicat(nomsyndicat);

CREATE TABLE IF NOT EXISTS donne_cours(
    matenseignant CHAR(15) NOT NULL,
    idclasse INTEGER(3) NOT NULL,
    KEY(matenseignant, idclasse)
) ENGINE=INNODB;

ALTER TABLE donne_cours ADD CONSTRAINT fk_donne_cours_enseignant FOREIGN KEY(matenseignant) REFERENCES enseignant(matenseignant);
ALTER TABLE donne_cours ADD CONSTRAINT fk_donne_cours_classe FOREIGN KEY(idclasse) REFERENCES classe(idclasse);

