CREATE DATABASE IF NOT EXISTS ex1 CHARACTER SET = 'utf8';

/*---------------------------------------------
COLMANT : remarque générale : mettre engine=innodb après chaque table entre la parenthèse fermante et le ; (sinon pas de clé étrangère)
---------------------------------------------*/

USE ex1;

CREATE TABLE IF NOT EXISTS patient (
/*---------------------------------------------
COLMANT : numérique (voir dictionnaire des données pour les types et tailles)
---------------------------------------------*/
    numpat char(15) NOT NULL,
	/*---------------------------------------------
COLMANT : 80 d'après DD (même chose avec les autres colonnes, il faut que tu consultes le dictionnaire des données pour voir
quelles sont les tailles et types prévus)
---------------------------------------------*/
    nompat VARCHAR(50) NOT NULL,
    prenompat VARCHAR(50) NOT NULL,
	/*---------------------------------------------
COLMANT : toutes les colonnes sont not null car aucune colonne facultative [0-1] dans le schéma relationnel
---------------------------------------------*/
    ruepat VARCHAR(50),
    numeropat VARCHAR(5),
    cppat INTEGER,
    villepat VARCHAR(50),
    PRIMARY KEY(numpat)
);

CREATE TABLE IF NOT EXISTS medecin (
    nummed char(15) NOT NULL,
    nommed VARCHAR(50) NOT NULL,
	/*---------------------------------------------
COLMANT : not null
---------------------------------------------*/
    prenommed VARCHAR(50),
    PRIMARY KEY(nummed)
);

CREATE TABLE IF NOT EXISTS consulte (
/*---------------------------------------------
COLMANT : datetime et pas date
---------------------------------------------*/
    datecons DATE NOT NULL,
    prixcons NUMERIC(4,2) NOT NULL,
    payecons BOOLEAN NULL DEFAULT FALSE,
    numpat char(15) NOT NULL,
    nummed char(15) NOT NULL,
    PRIMARY KEY(datecons, numpat, nummed),
	/*---------------------------------------------
COLMANT : tu peux juste mettre numpat seul et il faut ajouter un autre index pour nummed
---------------------------------------------*/
    KEY(numpat, nummed)
);

/*---------------------------------------------
COLMANT : pas de IGNORE dans les alter table (ignore, c'est pour les insert)
---------------------------------------------*/
ALTER IGNORE TABLE consulte ADD CONSTRAINT fkconsultepatient FOREIGN KEY(numpat) REFERENCES patient(numpat);
ALTER IGNORE TABLE consulte ADD CONSTRAINT fkconsultemedecin FOREIGN KEY(nummed) REFERENCES medecin(nummed);

CREATE DATABASE IF NOT EXISTS ex2 CHARACTER SET = 'utf8';

USE ex2;

CREATE TABLE IF NOT EXISTS editeur (
    numedit CHAR(15) NOT NULL,
    nomedit VARCHAR(50) NOT NULL,
    PRIMARY KEY(numedit)
);

CREATE TABLE IF NOT EXISTS ouvrage (
    isbnouv CHAR(15) NOT NULL,
    titouv VARCHAR(50) NOT NULL,
    catouv VARCHAR(50) NOT NULL,
    numedit CHAR(15) NOT NULL,
    PRIMARY KEY(isbnouv),
    KEY(numedit)
);

CREATE TABLE IF NOT EXISTS auteur (
/*---------------------------------------------
COLMANT : numérique (voir DD)
---------------------------------------------*/
    numaut CHAR(15) NOT NULL,
    nomaut VARCHAR(50) NOT NULL,
    prenomaut VARCHAR(50) NOT NULL,
    pseudoaut VARCHAR(50),
    datenaut DATE NOT NULL,
    datedaut DATE,
    PRIMARY KEY(numaut)
);

CREATE TABLE IF NOT EXISTS ecrit (
    numaut CHAR(15) NOT NULL,
    isbnouv CHAR(15) NOT NULL,
    PRIMARY KEY(numaut, isbnouv),
	/*---------------------------------------------
COLMANT : juste isbnouv car numaut déjà indexé avec la PK
---------------------------------------------*/
    KEY(numaut, isbnouv)
);

ALTER IGNORE TABLE ecrit ADD CONSTRAINT fkecritauteur FOREIGN KEY(numaut) REFERENCES auteur(numaut);
ALTER IGNORE TABLE ecrit ADD CONSTRAINT fkecritouvrage FOREIGN KEY(isbnouv) REFERENCES ouvrage(isbnouv);

/*---------------------------------------------
COLMANT : il manque la clé étrangère entre ouvrage et editeur
---------------------------------------------*/

CREATE DATABASE IF NOT EXISTS ex3 CHARACTER SET = 'utf8';

USE ex3;

CREATE TABLE IF NOT EXISTS editeur (
    numedit CHAR(15) NOT NULL,
    nomedit VARCHAR(50) NOT NULL,
    PRIMARY KEY(numedit)
);

CREATE TABLE IF NOT EXISTS ouvrage (
    isbnouv char(15) NOT NULL,
    titouv VARCHAR(50) NOT NULL,
    catouv VARCHAR(50) NOT NULL,
    PRIMARY KEY(isbnouv)
);

CREATE TABLE IF NOT EXISTS exemplaire (
    isbnouv CHAR(15) NOT NULL,
    numex INT UNSIGNED NOT NULL,
    dateimp DATE NOT NULL,
    numedit CHAR(15) NOT NULL,
    PRIMARY KEY(isbnouv, numex),
	/*---------------------------------------------
COLMANT : juste numedit (isbnouv est déjà indexé grâce à PK)
---------------------------------------------*/
    KEY(isbnouv, numedit)
);

CREATE TABLE IF NOT EXISTS auteur (
/*---------------------------------------------
COLMANT : numérique
---------------------------------------------*/
    numaut CHAR(15) NOT NULL,
    nomaut VARCHAR(50) NOT NULL,
    prenomaut VARCHAR(50) NOT NULL,
    pseudoaut VARCHAR(50),
    datenaut DATE NOT NULL,
    datedaut DATE,
    PRIMARY KEY(numaut)
);

CREATE TABLE IF NOT EXISTS ecrit (
    isbnouv CHAR(15) NOT NULL,
    numaut CHAR(15) NOT NULL,
    PRIMARY KEY(isbnouv, numaut),
	/*---------------------------------------------
COLMANT : juste numaut
---------------------------------------------*/
    KEY(isbnouv, numaut)
);
/*---------------------------------------------
COLMANT : pas ignore
---------------------------------------------*/

ALTER IGNORE TABLE exemplaire ADD CONSTRAINT fkexemplaireouvrage FOREIGN KEY(isbnouv) REFERENCES ouvrage(isbnouv);
ALTER IGNORE TABLE exemplaire ADD CONSTRAINT fkexemplaireediteur FOREIGN KEY(numedit) REFERENCES editeur(numedit);

ALTER IGNORE TABLE ecrit ADD CONSTRAINT fkecritouvrage FOREIGN KEY(isbnouv) REFERENCES ouvrage(isbnouv);
ALTER IGNORE TABLE ecrit ADD CONSTRAINT fkecritauteur FOREIGN KEY(numaut) REFERENCES auteur(numaut);

CREATE DATABASE IF NOT EXISTS ex4 CHARACTER SET = 'utf8';

USE ex4;

CREATE TABLE IF NOT EXISTS editeur (
    numedit CHAR(15) NOT NULL,
    nomedit VARCHAR(50) NOT NULL,
    PRIMARY KEY (numedit)
);

CREATE TABLE IF NOT EXISTS emprenteur (
/*---------------------------------------------
COLMANT : numérique (voir DD)
---------------------------------------------*/
    numemp CHAR(15) NOT NULL,
    nomemp VARCHAR(50) NOT NULL,
    prenemp VARCHAR(50) NOT NULL,
    numtelemp VARCHAR(15) NOT NULL,
    PRIMARY KEY (numemp)
);

CREATE TABLE IF NOT EXISTS exemplaire (
    isbnouv CHAR(15) NOT NULL,
    numex INT UNSIGNED NOT NULL,
    dateimp DATE NOT NULL,
    dateemp DATE,
    numedit CHAR(15) NOT NULL,
    numemp char(15),
    PRIMARY KEY (isbnouv, numex),
	/*---------------------------------------------
COLMANT : il faut indexer séparément numedit et numemp (donc deux fois key), pas besoin d'indexer isbnouv car déjà fait avec PK
---------------------------------------------*/
    KEY(isbnouv, numedit, numemp)
);

CREATE TABLE IF NOT EXISTS ouvrage (
    isbnouv CHAR(15) NOT NULL,
    titouv VARCHAR(50) NOT NULL,
    catouv VARCHAR(50) NOT NULL,
    PRIMARY KEY (isbnouv)
);

CREATE TABLE IF NOT EXISTS auteur (
/*---------------------------------------------
COLMANT : numérique (voir DD)
---------------------------------------------*/
    numaut CHAR(15) NOT NULL,
    nomaut VARCHAR(50) NOT NULL,
    prenomaut VARCHAR(50) NOT NULL,
    pseudoaut VARCHAR(50),
    datenaut DATE NOT NULL,
    datedaut DATE,
    PRIMARY KEY (numaut)
);

CREATE TABLE IF NOT EXISTS ecrit (
    isbnouv CHAR(15) NOT NULL,
    numaut CHAR(15) NOT NULL,
    PRIMARY KEY (isbnouv, numaut),
	/*---------------------------------------------
COLMANT : il faut indexer numaut seul
---------------------------------------------*/
    KEY(isbnouv, numaut)
);

/*---------------------------------------------
COLMANT : pas IGNORE
---------------------------------------------*/

ALTER IGNORE TABLE exemplaire ADD CONSTRAINT fkexemplaireouvrage FOREIGN KEY (isbnouv) REFERENCES ouvrage(isbnouv);
ALTER IGNORE TABLE exemplaire ADD CONSTRAINT fkexemplaireediteur FOREIGN KEY (numedit) REFERENCES editeur(numedit);
ALTER IGNORE TABLE exemplaire ADD CONSTRAINT fkexemplaireemprenteur FOREIGN KEY (numemp) REFERENCES emprenteur(numemp);

ALTER IGNORE TABLE ecrit ADD CONSTRAINT fkecritouvrage FOREIGN KEY (isbnouv) REFERENCES ouvrage(isbnouv);
ALTER IGNORE TABLE ecrit ADD CONSTRAINT fkecritauteur FOREIGN KEY (numaut) REFERENCES auteur(numaut);

CREATE DATABASE IF NOT EXISTS ex5 CHARACTER SET = 'utf8';

USE ex5;

CREATE TABLE IF NOT EXISTS cours (
    codecours CHAR(15) NOT NULL,
    intcours VARCHAR(50) NOT NULL,
    PRIMARY KEY (codecours)
);

CREATE TABLE IF NOT EXISTS localecole (
    numloc CHAR(15) NOT NULL,
    nbplacloc INT UNSIGNED NOT NULL,
    PRIMARY KEY (numloc)
);

CREATE TABLE IF NOT EXISTS anneecours (
    intsection VARCHAR(50) NOT NULL,
    intannee INT UNSIGNED NOT NULL,
    nbetudannee INT UNSIGNED NOT NULL,
    PRIMARY KEY (intsection, intannee)
);

CREATE TABLE IF NOT EXISTS coursdonne (
/*---------------------------------------------
COLMANT : jour = intitulé du jour donc varchar (ex : lundi)
---------------------------------------------*/
    jour DATE NOT NULL,
	/*---------------------------------------------
COLMANT : format time
---------------------------------------------*/
    heure VARCHAR(5) NOT NULL,
    numloc CHAR(15) NOT NULL,
    duree INT UNSIGNED NOT NULL,
    codecours CHAR(15) NOT NULL,
    intsection VARCHAR(50) NOT NULL,
    intannee INT UNSIGNED NOT NULL,
    PRIMARY KEY (jour, heure, numloc),
	/*---------------------------------------------
COLMANT : 3 index : 1 pour numloc, un autre pour codecours et un dernier pour intsection et intannee
---------------------------------------------*/
    KEY(numloc, codecours, intsection, intannee)
);

ALTER IGNORE TABLE coursdonne ADD CONSTRAINT fkcoursdonnelocalecole FOREIGN KEY (numloc) REFERENCES localecole(numloc);
ALTER IGNORE TABLE coursdonne ADD CONSTRAINT fkcoursdonnecours FOREIGN KEY (codecours) REFERENCES cours(codecours);
/*---------------------------------------------
COLMANT : comme PK combinée, la clé étrangère = foreign key(intsection, intannee) references anneecours(intsection, intannee)
---------------------------------------------*/
ALTER IGNORE TABLE coursdonne ADD CONSTRAINT fkcoursdonneanneecours1 FOREIGN KEY (intsection) REFERENCES anneecours(intsection);
ALTER IGNORE TABLE coursdonne ADD CONSTRAINT fkcoursdonneanneecours2 FOREIGN KEY (intannee) REFERENCES anneecours(intannee);

CREATE DATABASE IF NOT EXISTS ex6 CHARACTER SET = 'utf8';

USE ex6;

CREATE TABLE IF NOT EXISTS piece (
/*---------------------------------------------
COLMANT : numérique (voir DD)
---------------------------------------------*/
    idpiece CHAR(15) NOT NULL,
    nompiece VARCHAR(50) NOT NULL,
    dureepiece INT UNSIGNED NOT NULL,
    PRIMARY KEY (idpiece)
);

CREATE TABLE IF NOT EXISTS auteur (
/*---------------------------------------------
COLMANT : numérique (voir DD)
---------------------------------------------*/
    idaut CHAR(15) NOT NULL,
    nomaut VARCHAR(50) NOT NULL,
    preaut VARCHAR(50) NOT NULL,
    PRIMARY KEY (idaut)
);

CREATE TABLE IF NOT EXISTS ecrit (
    idaut CHAR(15) NOT NULL,
    idpiece CHAR(15) NOT NULL,
    PRIMARY KEY (idaut, idpiece),
	/*---------------------------------------------
COLMANT : juste idpiece, idaut déjà indexé par la PK
---------------------------------------------*/
    KEY(idaut, idpiece)
);

CREATE TABLE IF NOT EXISTS acteur (
/*---------------------------------------------
COLMANT : numérique (voir DD)
---------------------------------------------*/
    idacteur CHAR(15) NOT NULL,
    nomacteur VARCHAR(50) NOT NULL,
    preacteur VARCHAR(50) NOT NULL,
    PRIMARY KEY (idacteur)
);

CREATE TABLE IF NOT EXISTS representation (
    idpiece CHAR(15) NOT NULL,
    daterep DATE NOT NULL,
    PRIMARY KEY (idpiece, daterep),
	/*---------------------------------------------
COLMANT : idpiece déjà indexé car première colonne de la PK
---------------------------------------------*/
    KEY(idpiece)
);

CREATE TABLE IF NOT EXISTS spectateur (
/*---------------------------------------------
COLMANT : numérique (voir DD)
---------------------------------------------*/
    idspect CHAR(15) NOT NULL,
    nomspect VARCHAR(50) NOT NULL,
    prespect VARCHAR(50) NOT NULL,
    PRIMARY KEY (idspect)
);

CREATE TABLE IF NOT EXISTS jouedans (
    idacteur CHAR(15) NOT NULL,
    idpiece CHAR(15) NOT NULL,
    daterep DATE NOT NULL,
    remuneration NUMERIC(6,2),
    PRIMARY KEY (idacteur, idpiece, daterep),
	/*---------------------------------------------
COLMANT : retirer idacteur car déjà indexé par la PK
---------------------------------------------*/
    KEY(idacteur, idpiece, daterep)
);

CREATE TABLE IF NOT EXISTS assiste (
    idspect CHAR(15) NOT NULL,
    idpiece CHAR(15) NOT NULL,
    daterep DATE NOT NULL,
    PRIMARY KEY (idspect, idpiece, daterep),
	/*---------------------------------------------
COLMANT : retirer idspect car déjà indexé par la PK
---------------------------------------------*/
    KEY(idspect, idpiece, daterep)
);

/*---------------------------------------------
COLMANT : pas de IGNORE...
---------------------------------------------*/

ALTER IGNORE TABLE ecrit ADD CONSTRAINT fkecritauteur FOREIGN KEY (idaut) REFERENCES auteur(idaut);
ALTER IGNORE TABLE ecrit ADD CONSTRAINT fkecritpiece FOREIGN KEY (idpiece) REFERENCES piece(idpiece);

ALTER IGNORE TABLE representation ADD CONSTRAINT fkrepresentationpiece FOREIGN KEY (idpiece) REFERENCES piece(idpiece);

ALTER IGNORE TABLE jouedans ADD CONSTRAINT fkjouedansacteur FOREIGN KEY (idacteur) REFERENCES acteur(idacteur);
/*---------------------------------------------
COLMANT : clé étrangère vers representation (et pas piece) avec (idpiece, daterep)
---------------------------------------------*/
ALTER IGNORE TABLE jouedans ADD CONSTRAINT fkjouedanspiece FOREIGN KEY (idpiece) REFERENCES piece(idpiece);
ALTER IGNORE TABLE jouedans ADD CONSTRAINT fkjouedansrepresentation FOREIGN KEY (daterep) REFERENCES representation(daterep);

ALTER IGNORE TABLE assiste ADD CONSTRAINT fkassistespectateur FOREIGN KEY (idspect) REFERENCES spectateur(idspect);
/*---------------------------------------------
COLMANT : clé étrangère vers representation (et pas piece) avec (idpiece, daterep)
---------------------------------------------*/
ALTER IGNORE TABLE assiste ADD CONSTRAINT fkassistepiece FOREIGN KEY (idpiece) REFERENCES piece(idpiece);
ALTER IGNORE TABLE assiste ADD CONSTRAINT fkassisterepresentation FOREIGN KEY (daterep) REFERENCES representation(daterep);

CREATE DATABASE IF NOT EXISTS ex7 CHARACTER SET = 'utf8';

USE ex7;

CREATE TABLE IF NOT EXISTS club (
/*---------------------------------------------
COLMANT : numérique (voir DD)
---------------------------------------------*/
    matclub CHAR(15) NOT NULL,
    nomclub VARCHAR(50) NOT NULL,
	/*---------------------------------------------
COLMANT : not null car pas [0-1] dans le schéma relationnel
---------------------------------------------*/
    budgetclub NUMERIC(9,2),
    PRIMARY KEY (matclub)
);

CREATE TABLE IF NOT EXISTS joueur (
    matjou CHAR(15) NOT NULL,
    nomjou VARCHAR(50) NOT NULL,
    prejou VARCHAR(50) NOT NULL,
    datenjou DATE NOT NULL,
    matclub CHAR(15) NOT NULL,
    PRIMARY KEY (matjou),
    KEY(matclub)
);

CREATE TABLE IF NOT EXISTS entreineur (
    matent CHAR(15) NOT NULL,
    noment VARCHAR(50) NOT NULL,
    preent VARCHAR(50) NOT NULL,
    datenent DATE NOT NULL,
    PRIMARY KEY (matent)
);

CREATE TABLE IF NOT EXISTS entraine (
    matclub CHAR(15) NOT NULL,
    matent CHAR(15) NOT NULL,
    PRIMARY KEY (matclub, matent),
	/*---------------------------------------------
COLMANT : il faut indexer matent seul (matclub, c'est dééjà fait car première colonne de la PK)
---------------------------------------------*/
    KEY(matclub, matent)
);

CREATE TABLE IF NOT EXISTS categorie (
    codecat CHAR(15) NOT NULL,
    nomcat VARCHAR(50) NOT NULL,
    PRIMARY KEY (codecat)
);

CREATE TABLE IF NOT EXISTS equipe (
    codecat CHAR(15) NOT NULL,
    matclub CHAR(15) NOT NULL,
    surnomeq VARCHAR(50) NOT NULL,
    PRIMARY KEY (codecat, matclub),
	/*---------------------------------------------
COLMANT : il faut indexer matclub seul (codecat, c'est déjà fait car première colonne de la PK)
---------------------------------------------*/
    KEY(codecat, matclub)
);

CREATE TABLE IF NOT EXISTS matchcomplet (
/*---------------------------------------------
COLMANT : il y a deux fois le codecat (une fois pour chaque équipe comme pour matclub)
---------------------------------------------*/
    codecat CHAR(15) NOT NULL,
    matclub1 CHAR(15) NOT NULL,
    matclub2 CHAR(15) NOT NULL,
    datemat DATE NOT NULL,
    lieumat VARCHAR(50) NOT NULL,
    scoreloc INT UNSIGNED NOT NULL,
    scorevis INT UNSIGNED NOT NULL,
	/*---------------------------------------------
COLMANT : PK = codecat, matclub1, datemat
---------------------------------------------*/
    PRIMARY KEY (codecat, matclub1, matclub2, datemat),
	/*---------------------------------------------
COLMANT : il manque un index pour l'équipe visiteuse (avec codecatvis, matclubvis ensemble dans un index) à la place de l'index ci-dessous
---------------------------------------------*/
    KEY(codecat, matclub1, matclub2)
);

ALTER IGNORE TABLE joueur ADD CONSTRAINT fkjoueurclub FOREIGN KEY (matclub) REFERENCES club(matclub);

ALTER IGNORE TABLE entraine ADD CONSTRAINT fkentraineclub FOREIGN KEY (matclub) REFERENCES club(matclub);
ALTER IGNORE TABLE entraine ADD CONSTRAINT fkentraineentraineur FOREIGN KEY (matent) REFERENCES entreineur(matent);

ALTER IGNORE TABLE equipe ADD CONSTRAINT fkequipecategorie FOREIGN KEY (codecat) REFERENCES categorie(codecat);
ALTER IGNORE TABLE equipe ADD CONSTRAINT fkequipeclub FOREIGN KEY (matclub) REFERENCES club(matclub);

/*---------------------------------------------
COLMANT : PK combinée dans equipe donc foreign key(codecatloc, matclubloc) references equipe(codecat, matclub), même chose pour visiteur
---------------------------------------------*/
ALTER IGNORE TABLE matchcomplet ADD CONSTRAINT fkmatchcompletcategorie FOREIGN KEY (codecat) REFERENCES categorie(codecat);
ALTER IGNORE TABLE matchcomplet ADD CONSTRAINT fkmatchcompletclub1 FOREIGN KEY (matclub1) REFERENCES club(matclub);
ALTER IGNORE TABLE matchcomplet ADD CONSTRAINT fkmatchcompletclub2 FOREIGN KEY (matclub2) REFERENCES club(matclub);