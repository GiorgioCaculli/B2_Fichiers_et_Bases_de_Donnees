/* Caculli Giorgio : Serie 8 */

/* Ex 1 */
/*------------------------------
COLMANT : tu pouvais aussi récupérer directement le nombre de mois : timestampdiff(MONTH,...) et faire %12
------------------------------*/
SELECT numpass,
       CONCAT(prepass, ' ', nompass),
       CONCAT(
           TIMESTAMPDIFF(YEAR, datenais, NOW()),
           ' ans et ',
           FLOOR((DATEDIFF(NOW(), datenais) - (TIMESTAMPDIFF(YEAR, datenais, NOW()) * 365)) / 30),
           ' mois'
           )
FROM passager;

/* Ex 2 */
/*------------------------------
COLMANT : année = 2020...
------------------------------*/
SELECT * FROM vol WHERE DAYOFYEAR(datedep) >= 50 AND DAYOFYEAR(datedep) <= 70;

/* Ex 2 bis */
/*------------------------------
COLMANT : année = 2020...
------------------------------*/
SELECT indcomp, datedep, aeroport.paysaero, pilote.nompil FROM vol
    INNER JOIN aeroport ON aeroport.nomaero = vol.nomaerodestination
    INNER JOIN pilote ON pilote.numlic = vol.numlic
WHERE DAYOFYEAR(datedep) >= 50 AND DAYOFYEAR(datedep) <= 70;

/* Ex 3 */
/*------------------------------
COLMANT : concat pour indcomp et numvol
------------------------------*/
SELECT indcomp, CONCAT('Departure : ', DATE_FORMAT(datedep, '%D %M %Y at %h%p')), CONCAT('Flight time : ', DATE_FORMAT(dureevol, '%Hh%im%Ss')) FROM vol;

/* Ex 4 */
/*------------------------------
COLMANT : OK
------------------------------*/
SELECT * FROM passager;
INSERT INTO passager VALUES( 'PASS09', 'Lagaffe', 'Gaston', STR_TO_DATE('02/06/1985', '%d/%m/%Y'), 'gaston@lagaffe.net');
SELECT * FROM passager;

/* Ex 5 */
/*------------------------------
COLMANT : concat pour indcomp et numvol + adddate pour la première date... + >= 2 (condition pour vol continental : < 2)
------------------------------*/
SELECT indcomp, datedep, SUBDATE(datedep, INTERVAL 2 MONTH), SUBDATE(datedep, INTERVAL 3 HOUR), SUBDATE(SUBDATE(datedep, INTERVAL 2 MONTH), INTERVAL 10 DAY), IF(TIME(HOUR(dureevol)) > 2, 'Vol long courrier', 'Vol continental' ) FROM vol;

/* Ex 6 */
/*------------------------------
COLMANT : concat pour indcomp et numvol
------------------------------*/
SELECT indcomp, datedep, dureevol, SUBTIME(ADDTIME(datedep, dureevol), '00:15:00'), ADDTIME(ADDTIME(datedep, dureevol), '00:15:00') FROM vol;
