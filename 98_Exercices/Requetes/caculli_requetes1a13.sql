/* Requetes 1 a 13 - CACULLI GIORGIO: LA196672 */

/* EX 1 */
/*------------------
COLMANT : OK
------------------*/
SELECT * FROM compagnie;

/* EX 2 */
/*------------------
COLMANT : OK
------------------*/
SELECT nomcomp FROM compagnie WHERE nbavions > 12;

/* EX 3 */
/*------------------
COLMANT : il faut utiliser like binary pour respecter la casse (majuscules et minuscules)
------------------*/
SELECT * FROM passager WHERE nompass='Dupont';

/* EX 4 */
/*------------------
COLMANT : il manque SMITH + deuxième solution avec in
------------------*/
SELECT * FROM passager WHERE nompass='Dupont' OR nompass='Leblanc';

/* EX 5 */
/*------------------
COLMANT : OK
------------------*/
SELECT * FROM vol WHERE datedep>='2020-03-10' AND dureevol<'03:00:00';

/* EX 6 */
/*------------------
COLMANT : OK
------------------*/
SELECT nomaero FROM aeroport WHERE vaccin1 IS NOT NULL OR vaccin2 IS NOT NULL OR vaccin3 IS NOT NULL;

/* EX 7 */
/*------------------
COLMANT : OK
------------------*/
SELECT * FROM pilote WHERE nompil='Tanguy' XOR nbheures>1000;

/* EX 8 */
/*------------------
COLMANT : OK
------------------*/
SELECT indcomp, numvol FROM vol WHERE datedep>='2020-02-10 00:00:00' AND datedep<='2020-03-20 23:59:59';

/* EX 9 */
/*------------------
COLMANT : OK
------------------*/
SELECT * FROM passager WHERE prepass LIKE BINARY 'T%m';

/* EX 10 */
/*------------------
COLMANT : OK
------------------*/
ALTER TABLE compagnie ADD FULLTEXT full_nomcomp(nomcomp);
SELECT * FROM compagnie WHERE MATCH(nomcomp) AGAINST('+Brussels -Airlines' IN BOOLEAN MODE);

/* EX 11 */
/*------------------
COLMANT : OK
------------------*/
SELECT * FROM vol ORDER BY datedep DESC;

/* EX 12 */
/*------------------
COLMANT : OK
------------------*/
SELECT nomaero, paysaero FROM aeroport ORDER BY paysaero, nomaero LIMIT 5;

/* EX 13 */
/*------------------
COLMANT : OK
------------------*/
SELECT nomaero, paysaero FROM aeroport ORDER BY paysaero, nomaero LIMIT 5 OFFSET 5;
