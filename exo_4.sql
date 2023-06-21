/*a) Liste de tous les étudiants*/
SELECT *
FROM
	etudiant

/*b) Liste de tous les étudiants, classée par ordre alphabétique inverse*/
SELECT *
FROM 
	etudiant
ORDER BY nom DESC

CREATE OR REPLACE VIEW tot_coef AS
SELECT 
	m.libelle,
	m.coef,
	SUM(m.coef)  AS Somme
FROM 
    matiere m

GROUP BY 
	m.libelle,
	m.coef


/*d) Nom et prénom de chaque étudiant*/

SELECT 
	e.nom,
 	e.premon
FROM etudiant e;
    
/*e) Nom et prénom des étudiants domiciliés à Lyon*/
 SELECT 
    e.nom, 
    e.prenom, 
    e.ville
FROM 
    etudiant e
WHERE 
    e.ville = "Lyon";   

/*f) Liste des notes supérieures ou égales à 10*/

SELECT
	n.num_etu_id,
	n.numero_epreuve,
	n.note
FROM 
    notation n
WHERE 
    n.note > 10
/*g) Liste des épreuves dont la date se situe entre le 1er janvier et le 30 juin 2014*/

SELECT
  ep.numepreuve,
  ep.datepreuve,
  ep.codemat,
  ep.lieu

FROM 
  epreuve ep

WHERE 
   ep.datepreuve BETWEEN '2014-01-26' AND '2014-06-30'

-- h) Nom, prénom et ville des étudiants dont la ville contient la chaîne "ll"(LL)

SELECT 
	e.nom,
	e.prenom,
	e.rue,
	e.cp,
	e.ville
FROM etudiant e
WHERE e.ville LIKE '%ll%'

 SELECT 
	e.nom,
	e.prenom,
	e.ville
FROM etudiant e
WHERE e.ville LIKE '%ll%'


/*i) Prénoms des étudiants de nom Dupont, Durand ou Martin */
SELECT 
	e.nom,
	e.prenom,
	e.ville
FROM etudiant e

WHERE (e.nom LIKE '%Durand%') OR (e.nom LIKE '%Dupont%') OR (e.nom LIKE '%Martin%')
ORDER BY e.prenom ASC

/*k) Nombre total d'épreuves*/
SELECT
 COUNT(epreuve.numepreuve)
FROM 
  epreuve
/*l) Nombre de notes indéterminées (NULL)*/
SELECT
   n.num_etu_id,
   n.numero_epreuve,
	n.note
FROM 
 notation n
WHERE 
    n.note IS NULL 

/*m) Liste des épreuves (numéro, date et lieu) incluant le libellé de la matière*/
SELECT
 e.numepreuve,
 e.datepreuve,
 e.lieu,
 e.codemat,
 m.libelle
FROM 
epreuve e

INNER JOIN
   matiere m 
ON e.codemat= m.codemat

/*n) Liste des notes en précisant pour chacune le nom et le prénom de l'étudiant qui l'a obtenue*/
SELECT
	n.num_etu_id,
	e.nom,
	e.prenom,
	n.note,
	n.numero_epreuve
FROM
  notation n
  
INNER JOIN 
	etudiant e 
ON  n.num_etu_id = e.numetu

/*o) Liste des notes en précisant pour chacune le nom et le prénom de l'étudiant qui l'a obtenue et le libellé de la matière concernée*/
SELECT
	n.num_etu_id,
	e.nom,
	e.prenom,
	n.note,
	m.libelle
FROM
  notation n
  
INNER JOIN 
	etudiant e 
ON n.num_etu_id = e.numetu
INNER JOIN 
	epreuve ep
ON ep.numepreuve= n.numero_epreuve

INNER JOIN 
   matiere m

ON  ep.codemat = m.codemat

/*p) Nom et prénom des étudiants qui ont obtenu au moins une note égale à 20*/
SELECT
	e.nom,
	e.prenom,
	n.note
FROM
  notation n
  
INNER JOIN 
	etudiant e 
ON n.num_etu_id = e.numetu

WHERE n.note = 20

/*q) Moyennes des notes de chaque étudiant (indiquer le nom et le prénom)*/
SELECT
	e.nom,
	e.prenom,
	ROUND(AVG(n.note),2) AS moey_etu
FROM
  notation n
INNER JOIN
	etudiant e 
ON n.num_etu_id = e.numetu

GROUP BY
 	e.nom,
	e.prenom
/*s) Moyennes des notes pour les matières (indiquer le libellé) comportant plus d'une épreuve*/
SELECT
	e.nom,
	e.prenom,
	ROUND(AVG(n.note),2) AS moey_etu
FROM
  notation n
INNER JOIN
	etudiant e 
ON n.num_etu_id = e.numetu

GROUP BY
 	e.nom,
	e.prenom
	

ORDER BY

moey_etu DESC
