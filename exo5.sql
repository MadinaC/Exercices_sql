CREATE TABLE Usine(
   NumU INT,
   NomU VARCHAR(50),
   VilleF VARCHAR(50),
   PRIMARY KEY(NumU)
);

CREATE TABLE Produit(
   NumP INT,
   NomP VARCHAR(50),
   Couleur VARCHAR(50),
   Poids INT,
   PRIMARY KEY(NumP)
);

CREATE TABLE Fournisseurs(
   NumF INT,
   NomF VARCHAR(50),
   Status VARCHAR(50),
   VilleF VARCHAR(50),
   PRIMARY KEY(NumF)
);

CREATE TABLE livraison(
   NumU INT,
   NumP INT,
   NumF INT,
   qte  INT,
   PRIMARY KEY(NumU, NumP, NumF),
   FOREIGN KEY(NumU) REFERENCES NomU(NumU),
   FOREIGN KEY(NumP) REFERENCES Produit_(NumP),
   FOREIGN KEY(NumF) REFERENCES Fournisseurs(NumF)
);
/* Ajouter un nouveau fournisseur avec les attributs de votre choix */
INSERT INTO fournisseurs (NumF, NomF, statut, VilleF) VALUES
  (1,'Abedis','Sarl','Strasbourg'),
  (2,'Terre Azur','Sas','Colmar'),
  (3,'Sadexho,'Sarl','Horbourg-Wihr')

/*     Supprimer tous les produits de couleur noire et de numéros compris entre 100 et 1999    */
INSERT INTO  (NumP,NomP,Couleur,Poids) VALUES
  (1050,'ordinateur','noir',1.75)

DELETE FROM produit
WHERE (numP BETWEEN 100 AND 1999) AND (couleur = 'noir')
/*c) Changer la ville du fournisseur 3 par Mulhouse*/
UPDATE fournisseurs
SET VilleF = 'Mulhouse'
WHERE numF = '3';
  