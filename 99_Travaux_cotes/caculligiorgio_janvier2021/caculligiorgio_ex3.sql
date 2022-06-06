/* CACULLI GIORGIO LA196672 - Examen Janvier 2021 */

/* Ex 1 */

SELECT idavatar AS identifiant, surnomava AS surnom, DATE_FORMAT(datecreation, '%d/%m/%Y') AS date_de_creation
FROM avatar WHERE DATEDIFF(datemiseenligne, datecreation) < 20 ORDER BY datemiseenligne DESC, datecreation;

/* Ex 2 */

SELECT CONCAT(idmonde, ' : ', nbmonstres) AS monde_monstres,
       CASE
           WHEN reserveabonne = 0 THEN 'pas réservé pour les abonnés'
           ELSE 'réservé pour les abonnés'
           END AS abonnement
FROM monde WHERE developpeur LIKE BINARY '%soft%';

/* Ex 3 */

SELECT developpeur AS dev, GROUP_CONCAT(idmonde SEPARATOR ',') AS mondes_dev FROM monde
WHERE reserveabonne = 0 GROUP BY developpeur ORDER BY COUNT(idmonde) DESC;

/* Ex 4 */

SELECT idavatar AS id_avatar, surnomava AS surnom_avatar,
       REVERSE(surnomava) AS avatar_a_lenvers
FROM avatar WHERE niveau IN (SELECT MAX(niveau) FROM avatar);

/* Ex 5 TO DO */

SELECT
       CASE
           WHEN bonusattaque < 4 THEN 'attaque faible'
           WHEN bonusattaque < 8 THEN 'attaque moyenne'
           ELSE 'attaque forte'
           END AS type_attaque,
       COUNT(bonusattaque) AS tot_compet,
       COUNT(bonusdefense) AS tot_defense
FROM competence GROUP BY bonusattaque;

/* Ex 6 TO DO */

SELECT DISTINCT idavatar AS id_ava, surnomava AS surnom, idjoueur AS id_jou,
       CASE
           WHEN abonne = 1 THEN 'abonné'
           ELSE 'non abonné'
           END AS abonnement
FROM avatar
    INNER JOIN joueur USING(idjoueur)
    INNER JOIN possede USING (idavatar)
    INNER JOIN competence USING (idcompet);

/* Ex 7 */

SELECT idavatar AS id_vainqueur, surnomava AS surnom_vainqueur, idavatarvictoire AS id_perdant,
       (SELECT surnomava FROM avatar WHERE id_perdant = idavatar) AS surnom_perdant,
       CASE
           WHEN niveau > (SELECT niveau FROM avatar WHERE id_perdant = idavatar) THEN 'Victoire sans panache'
           ELSE 'Belle victoire'
           END AS type_victoire
FROM avatar WHERE idavatarvictoire IS NOT NULL;

/* Ex 8 TO DO */

SELECT idjoueur AS id_joueur,
       CASE
           WHEN pseudojoueur IS NULL THEN 'pas de pseudo'
           ELSE pseudojoueur
           END AS pseudo
FROM joueur INNER JOIN a_visite ON idjoueur = a_visite.idavatar;

/* Ex 9 TO DO */

SELECT idmonde AS mondes_nonjouables FROM monde;

/* Ex 10 */

SELECT idcompet AS id_competence, nomcompet AS nom_competence, GROUP_CONCAT(idavatar, ' ', surnomava ORDER BY idavatar ASC SEPARATOR '*/*') AS avatars
FROM competence
    LEFT JOIN possede USING(idcompet)
    LEFT JOIN avatar USING(idavatar)
GROUP BY idcompet;
