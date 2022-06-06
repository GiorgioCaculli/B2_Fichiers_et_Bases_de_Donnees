/* Caculli Giorgio, Lambert Guillaume, Taminiau Tanguy */

/* Serie 6 */

/* Ex 1 TO DO */

SELECT * FROM vol WHERE (datedep >= "2020-03-01 00:00:00" AND dureevol >= "02:00:00") OR (datedep < "2020-03-10 00:00:00" AND nomaerodestination="Belgique");

/* Ex 2 */

SELECT nomaerodestination, COUNT(*) FROM vol WHERE nomaerodestination="Zaventem" GROUP BY nomaerodestination;

/* Ex 3 */

SELECT DISTINCT indcomp, numvol FROM escale WHERE (nomaero="Oviedo" OR nomaero="Madrid") GROUP BY nomaero;

/* Ex 4 */

SELECT numlic, nompil FROM pilote WHERE nompil LIKE BINARY "__%ver%";

/* Ex 5 */

SELECT numlic, nompil, nbheures FROM pilote WHERE numlic NOT IN (SELECT numlic from vol);

/* Ex 6 */

INSERT INTO pilote(numlic, nompil, nbheures) VALUES ("PIL004", "Danny", 2500) ON DUPLICATE KEY UPDATE nompil="Haddock", nbheures=1800;
SELECT * FROM pilote;

/* Ex 7 */

REPLACE INTO pilote(numlic, nompil, nbheures) VALUES ("PIL004", "Tintin", 3000);
SELECT * FROM pilote;

/* Ex 8 */

INSERT INTO vol VALUES (1, "2020-04-01 10:00:00", "01:45:00", "Boeing B004", (SELECT indcomp FROM compagnie WHERE nomcomp="Air France"), "Amsterdam", "PIL004", "NAV003");
SELECT * FROM vol;

/* Ex 9 TO DO */

/* Ex 10 */

SELECT * FROM escale WHERE (numvol, indcomp) IN (SELECT numvol, indcomp FROM vol WHERE datedep >= "2020-03-20 00:00:00" AND datedep < "2020-03-22 00:00:00");
