/* EXEMPLE 1 */

CREATE DATABASE IF NOT EXISTS exemple1_BDSQL CHARACTER SET = 'utf8';

USE exemple1_BDSQL;

CREATE TABLE IF NOT EXISTS personne (
numregnat CHAR(15) NOT NULL,
nomp VARCHAR(50) NOT NULL,
prenomp1 VARCHAR(50) NOT NULL,
prenomp2 VARCHAR(50),
prenomp3 VARCHAR(50),
PRIMARY KEY(numregnat)
)ENGINE=INNODB;

create table if not exists voiture (
numchassis char(17) not null,
marque varchar(60) not null,
vitmax smallint,
numregnat char(15) not null,
primary key(numchassis),
key(numregnat)
)engine=innodb;

ALTER TABLE voiture ADD CONSTRAINT fkvoiturepersonne FOREIGN KEY (numregnat) REFERENCES personne(numregnat);

/* EXEMPLE 2 */

CREATE DATABASE IF NOT EXISTS exemple2_BDSQL CHARACTER SET = 'utf8';

USE exemple2_BDSQL;

create table if not exists voiture (
numchassis char(17) not null,
marque varchar(60) not null,
vitmax smallint not null,
primary key(numchassis)
)engine=innodb;

create table if not exists personne (
numregnat char(15) not null,
nomp varchar(50) not null,
prenomp varchar(50) not null,
primary key(numregnat)
)engine=innodb;

create table if not exists utilise (
datedutil datetime not null,
numregnat char(15) not null,
numchassis char(17) not null,
primary key(numregnat, numchassis),
key(numchassis)
) engine=innodb;

alter table utilise add constraint fkutilisepersonne foreign key(numregnat) references personne(numregnat), 
add constraint fkutilisevoiture foreign key(numchassis) references voiture(numchassis);

/* EXEMPLE 3 */

CREATE DATABASE IF NOT EXISTS exemple3_BDSQL CHARACTER SET = 'utf8';

USE exemple3_BDSQL;

create table if not exists serie (
idserie smallint not null AUTO_INCREMENT,
noms varchar(60) not null,
budget NUMERIC(11,2) not null,
primary key (idserie)
)engine=innodb;

create table if not exists episode (
idserie2 smallint not null,
numep mediumint not null,
titreep varchar(60) not null,
primary key(idserie2, numep)
)engine=innodb;

alter table episode add constraint fkepisodeserie foreign key (idserie2) references serie(idserie);













