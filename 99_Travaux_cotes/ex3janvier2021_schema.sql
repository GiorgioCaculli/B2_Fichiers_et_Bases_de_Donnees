/*
* création des tables et clés étrangères
*/

drop database if exists ue204_janvier2021_ex3;
create database if not exists ue204_janvier2021_ex3 character set = 'utf8';
use ue204_janvier2021_ex3;

create table avatar(
	idavatar int unsigned not null,
	surnomava varchar(40) not null,
	datecreation date not null,
	niveau smallint not null,
	classe varchar(20) not null,
	datemiseenligne datetime,
	idavatarvictoire int unsigned,
	idavatardefaite int unsigned,
	idjoueur int not null,
	primary key(idavatar),
	key(idavatarvictoire),
	key(idavatardefaite),
	key(idjoueur)
)engine=innodb;

create table competence (
	idcompet int unsigned not null,
	nomcompet varchar(40) not null,
	bonusattaque smallint not null,
	bonusdefense smallint not null,
	primary key(idcompet)
) engine=innodb;

create table joueur (
	idjoueur int not null,
	pseudojoueur varchar(40),
	abonne boolean not null,
	primary key(idjoueur)
)engine=innodb;

create table monde (
	idmonde int unsigned not null,
	nbmonstres int not null,
	datedispo date not null,
	reserveabonne boolean not null,
	developpeur varchar(40) not null,
	primary key(idmonde)
)engine=innodb;

create table a_visite (
	idmonde int unsigned not null,
	idavatar int unsigned not null,
	datevisite datetime not null,
	nbpointsgagnes int not null,
	primary key(idmonde, idavatar, datevisite),
	key(idavatar)
)engine=innodb;

create table possede (
	idcompet int unsigned not null,
	idavatar int unsigned not null,
	dateacquisition datetime not null,
	nbpointsdepenses int not null,
	primary key(idcompet, idavatar),
	key(idavatar)
)engine=innodb;

alter table avatar add constraint fkavatarvictoire
     foreign key (idavatarvictoire)
     references avatar (idavatar),
	 add constraint fkavatardefaite foreign key(idavatardefaite) 
	 references avatar(idavatar),
	 add constraint fkavatarjoueur foreign key(idjoueur)
	 references joueur(idjoueur);

alter table possede add constraint fkpossedeavatar
     foreign key (idavatar)
     references avatar (idavatar),
	 add constraint fkpossedecompetence foreign key(idcompet) references competence(idcompet);
	 
alter table a_visite add constraint fkavisiteavatar
     foreign key (idavatar)
     references avatar (idavatar),
	 add constraint fkavisitemonde foreign key(idmonde) references monde(idmonde);

	 
/*
* remplissage des tables
*/

insert into joueur(idjoueur, pseudojoueur, abonne) values 
(1, 'AlbusD', 1),
(2, null, 1),
(3, 'SiriusB', 0),
(4, null, 1),
(5, null, 0),
(6, 'RonW', 1),
(7, 'HarryP', 1),
(8, 'HermioneG', 1),
(9, 'SeverusR', 1),
(10, 'MinervaM', 0) ;

insert into competence(idcompet, nomcompet, bonusattaque, bonusdefense) values
(1, 'Attaque de feu', 10, 1),
(2, 'Force de frappe', 5, 5),
(3, 'Carapace de tortue', 1, 10),
(4, 'Bouclier de Thor', 4, 7),
(5, 'Eclair de Zeus', 9, 1),
(6, 'Arc d''Arrow', 6, 1),
(7, 'Cri de Black Canary', 4, 6),
(8, 'Dresseur de dragons', 8, 8),
(9, 'Invocation des démons', 10, 10),
(10, 'Costume de Super-Man', 1, 1) ;
 
insert into monde(idmonde, nbmonstres, datedispo, reserveabonne, developpeur) values 
(1, 100, '2020-01-01', 0, 'Obisoft'),
(2, 50, '2020-10-01', 1, 'Macrosoft'),
(3, 150, '2021-05-04', 0, 'Obisoft'),
(4, 203, '2020-05-04', 1, 'Saga'),
(5, 140, '2020-09-01', 0, 'Nontendo'),
(6, 203, '2021-03-10', 0, 'Babysoft'),
(7, 50, '2021-02-01', 1, 'Nontendo'),
(8, 120, '2021-01-01', 1, 'Saga') ;
 
insert into avatar(idavatar, surnomava, datecreation, niveau, classe, datemiseenligne, idavatarvictoire, idavatardefaite, idjoueur) values 
(1, 'Alb9tor', '2020-04-06', 2, 'sorcier', '2020-08-01 10:00:00', null, null, 1),
(2, 'Aaa9aa', '2019-04-25', 1, 'sorcier', null, 1, null, 2),
(3, 'Ame9p', '2020-01-05', 5, 'orc', '2020-03-01 08:00:00', 1, 2, 3),
(4, 'artic9', '2020-06-03', 2, 'paladin', '2020-06-10 09:00:00', null, 2, 3),
(5, 'bluefish5', '2020-06-01', 1, 'barbare', '2020-06-08 04:30:00', 3, null, 1),
(6, 'moon2mars', '2020-09-01', 5, 'amazone', null, null, null, 5),
(7, 'gedeon7win', '2020-10-05', 3, 'nécromancien', '2020-10-10 05:03:01', 5, 2, 1) ;

update avatar set idavatardefaite = 2 where idavatar = 1;

update avatar set idavatardefaite = 7 where idavatar = 5;
 
insert into possede(idavatar, idcompet, dateacquisition, nbpointsdepenses) values 
(1, 1, '2020-07-30', 200),
(2, 4, '2020-05-04', 300),
(3, 2, '2020-07-30', 150),
(1, 4, '2020-06-30', 100),
(1, 9, '2020-10-04', 500),
(3, 10, '2020-01-08', 50),
(3, 8, '2020-11-01', 320),
(3, 4, '2020-12-01', 200),
(2, 8, '2020-12-03', 100),
(6, 8, '2020-12-01', 150),
(5, 6, '2020-07-01', 200);
 
insert into a_visite(idavatar, idmonde, datevisite, nbpointsgagnes) values 
(1, 3, '2020-06-01 10:00:00', 150),
(1, 4, '2020-06-02 08:00:00', 500),
(2, 1, '2020-07-01 06:00:00', 600),
(3, 4, '2020-07-01 14:00:00', 50),
(4, 4, '2020-07-10 15:00:00', 120),
(4, 4, '2020-08-10 12:00:00', 100),
(1, 3, '2020-08-05 09:32:10', 600);