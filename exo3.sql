
g. Valeur du stock

/*CREATE VIEW pour recuperer la nouvelle colonne SUMMA et pour trouver la valeur du stock donc la somme de cette colonne*/
CREATE OR REPLACE VIEW  valeur_stock AS

SELECT 
    NOART  ARTN°,
    LIBELLE  LIBL,
	STOCK  ST,
	PRIXINVENT  PRX,
	ROUND((STOCK*PRIXINVENT),2) AS SOMME
	
FROM

  articles

GROUP BY
    NOART,
	 LIBELLE,
	 STOCK,
	 PRIXINVENT 
	 
/*on utilise la vue pour recuperer la colonne SUMMA*/


SELECT  
	SUM(SOMME) FROM valeur_stock


/* Numéros et libellés des articles triés dans l'ordre décroissant des stocks*/
SELECT
 
 ARTN°,
 LIBL,
 SOMME
FROM
	valeur_stock
ORDER BY
 SOMME DESC

/*i) Liste pour chaque article (numéro et libellé) du prix d'achat maximum, minimum et moyen*/
 SELECT
	ART.NOART,
	ART.LIBELLE,
	MIN(ach.PRIXACHAT) AS MIN_PRIX,
	MAX(ach.PRIXACHAT) AS MAX_PRIX,
	AVG(ach.PRIXACHAT) AS MOYEN_PRIX


FROM 
	articles ART
INNER JOIN
    acheter ACH
ON
	ACH.NOART= ART.NOART
	
GROUP BY
	ART.NOART,
	ART.LIBELLE

/*j) Délai moyen pour chaque fournisseur proposant au moins 2 articles ?*/

CREATE OR REPLACE VIEW delay_moeyn_four AS
SELECT 
    A.LIBELLE,
    F.NOFOUR, 
    F.NOMFOUR, 
    F.ADRFOUR, 
    F.VILLEFOUR, 
    AVG(ACH.DELAI) AS DELAY_MOYEN
FROM 
	acheter ACH
INNER JOIN fournisseurs F ON F.NOFOUR = ACH.NOFOUR
INNER JOIN articles A ON A.NOART = ACH.NOART
GROUP BY 
   A.LIBELLE,
   F.NOFOUR,
   F.NOMFOUR,
   F.ADRFOUR,
   F.VILLEFOUR