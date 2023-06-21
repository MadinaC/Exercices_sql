
    Exo1
    Donner la liste des titres des représentations
  

    SELECT r.titre_representation
    FROM representation r


    SELECT r.titre_representation
    FROM representation r
    WHERE r.lieu = "Opéra Bastille" 


    SELECT m.nom,r.titre_representation
    FROM  representation r, musicien m
    WHERE m.representation_id  = r.num_represenatation

    SELECT r.titre_representation,p.tarif
    FROM  representation r, programmer p
    WHERE r.num_represenatation = p.representation_id
    AND p.date = '2014-09-14'

    Exo2

     Quel est le nombre total:

        SELECT 
        COUNT(n_etudiant) AS nbr_tot_ets
        FROM
        etudiant

    La note la plus haute et la note la plus bas

    SELECT MAX(note)
    FROM evaluer

    SELECT MIN(note)
    FROM evaluer  
'exo2.C   Quelles sont les moyennes de chaque étudiant dans chacune des matières ? (utilisez CREATE VIEW)'

SELECT
	et.n_etudiant,
	et.nom  nom_etu,
	et.prenom  prenom_etu,
	m.code  code_mat,
	m.libelle  libelle_mat,
	m.coeff coeff_mat,
	AVG(ev.note) AS moy_notes

FROM 
 	etudiant et
 	INNER JOIN evaluation ev
 		ON et.n_etudiant = ev.n_etudiant
 	
 	INNER JOIN matiere m
 	 ON ev.code_mat = m.code
 	 
 	GROUP BY
 		et.n_etudiant,
		et.nom,
		et.prenom,
		m.code ,
		m.libelle ,
		m.coeff 
	ORDER BY
		et.n_etudiant ASC,
		m.coeff  DESC

  Quelle est la moyenne générale de chaque étudiant  
    SELECT
        n_etudiant,
        nom_etu,
        prenom_etu,
        ROUND (SUM(moy_notes*coeff_mat)/SUM(coeff_mat),2) moy_notes
        
	FROM 
	   moy_etu_mat
	   
	GROUP BY
        n_etudiant,
        nom_etu,
        prenom_etu
        
	ORDER BY
        n_etudiant ASC
        ;

    f) Quelle est la moyenne générale de la promotion ? (cf. question e) 

SELECT 
COUNT(n_etudiant) AS nbr_tot_ets
FROM
  etudiant 
  
/*DROP TABLE IF EXISTS matiere,evaluer,etudiant*/
  
CREATE OR REPLACE VIEW moy_etu_mat AS

SELECT
	et.n_etudiant,
	et.nom  nom_etu,
	et.prenom  prenom_etu,
	m.code  code_mat,
	m.libelle  libelle_mat,
	m.coeff coeff_mat,
	AVG(ev.note) AS moy_notes

FROM 
 	etudiant et
 	INNER JOIN evaluation ev
 		ON et.n_etudiant = ev.n_etudiant
 	
 	INNER JOIN matiere m
 	 ON ev.code_mat = m.code
 	 
 	GROUP BY
 		et.n_etudiant,
		et.nom,
		et.prenom,
		m.code ,
		m.libelle ,
		m.coeff 
	ORDER BY
		et.n_etudiant ASC,matiere-- du plus petit au plus grand//DESC du plut petit au plus grand
		m.code  DESC*/
		
		/*SELECT 
			code_mat,
			libelle_mat,
			coeff_mat,
			AVG(moy_notes) moy_notes
			
		FROM
		   moy_etu_mat
		GROUP BY
			code_mat,
			libelle_mat,
			coeff_mat
		ORDER BY
		
		code_mat ASC
			;*/
			
	/*e)Quelle est la moyenne générale de chaque étudiant*/
			
	CREATE OR REPLACE VIEW moy_gen_etu AS 
	
	SELECT
	 n_etudiant,
	 nom_etu,
	 prenom_etu,
	 ROUND (SUM(moy_notes*coeff_mat)/SUM(coeff_mat),2) moy_notes
	
	FROM 
	   moy_etu_mat
	   
	GROUP BY
	 n_etudiant,
	 nom_etu,
	 prenom_etu
	 
	ORDER BY
	  n_etudiant ASC
	 ;*/
	 
	 /*f) Quelle est la moyenne générale de la promotion ? (cf. question e)*/
	 
	 SELECT 
	 	ROUND(AVG(moy_notes),2)
	 	
	FROM 
	    moy_gen_etu*/
	    
	/*g) Quels sont les étudiants qui ont une moyenne générale supérieure ou égale à la moyenne générale de la promotion ? (cf. question e) 2sujets differents,incompatible,il faut faire 2 SELECTS;*/
	/*ON PEUT PAS MIXER 2 REQUETES SIMPLES;ATTENTION AUX DIMENSION    */
	   SELECT
	      n_etudiant,
			nom_etu,
			prenom_etu,
			moy_notes

	 	FROM 
		    moy_gen_etu
		    
		GROUP BY
			 n_etudiant,
			 nom_etu,
			 prenom_etu,
			 moy_notes    
		 
		WHERE 
		 moy_notes => (
		 
		   SELECT 
	 			ROUND(AVG(moy_notes),2)
	 	    FROM 
	          moy_gen_etu      
	   )
	   ;

       EXO3

    /*   ARTICLES (NOART, LIBELLE, STOCK, PRIXINVENT)
FOURNISSEURS (NOFOUR, NOMFOUR, ADRFOUR, VILLEFOUR)
ACHETER (NOFOUR#, NOART#, PRIXACHAT, DELAI)*/

SELECT 
   
    art.NOART,
    art.LIBELLE,
    art.STOCK
FROM 
    articles art
    
WHERE

   art.STOCK < 10
/*Liste des articles dont le prix d'inventaire est compris entre 100 et 300 ?*/
SELECT 
   art.LIBELLE,
   art.PRIXINVENT   
FROM  
    articles art
    
WHERE
    art.PRIXINVENT > 100
AND
   art.PRIXINVENT < 300

/*Liste des fournisseurs dont on ne connaît pas l'adresse ?*/

 SELECT

 F.ADRFOUR

FROM 
	fournisseurs F
	
WHERE 

	F.ADRFOUR IS NULL 
/*d) Liste des fournisseurs dont le nom commence par "STE"*/
SELECT
  F.NOMFOUR
FROM 

fournisseurs F

WHERE 

F.NOMFOUR LIKE "STE%"
/*e) Noms et adresses des fournisseurs qui proposent des articles pour lesquels le délai d'approvisionnement est supérieur à 20 jours ?*/
SELECT 
  F.NOFOUR,
  F.NOMFOUR,
  F.ADRFOUR,
  F.VILLEFOUR
FROM 
  fournisseurs F
  
INNER JOIN 
 acheter A
 ON  
  F.NOFOUR = A.NOFOUR
WHERE 

A.DELAI>20

GROUP BY
 F.NOFOUR,
  F.NOMFOUR,
  F.ADRFOUR,
  F.VILLEFOUR
/*f) Nombre d'articles référencés ?*/
SELECT COUNT(NOART)

FROM 
    articles 