/*1. Lister pour chaque formation ses sessions ouvertes. Afficher le Titre de la
formation, le nom de la session, la date de début et la date fin.
2. Lister Les étudiants inscrits dans chacune des formations. Ordonner la liste
par titre de formation.
3. Pour la formation web développement, calculer le nombre d’inscriptions
distancielles et présentielles.
4. Lister les formations dont le nombre d’inscriptions distancielles est supérieur
ou égale à 3. Ordonner la liste par le nombre d’inscription.
5. Lister pour chaque spécialité active, la liste des formations correspondantes :
leurs titres, durée et prix. Ordonner la liste par l’ordre alphabétique
descendant du nom de la spécialité.
6. Afficher l’union de la liste en N : 4 avec la liste des formations dont le nombre
d’inscriptions présentielles est supérieur ou égal à 4.
7. Calculer le total des prix payés par Année et mois de la date début des
sessions*/




SELECT f.titreFormation AS titreForm, s.nomSess, s.dateDebut, s.dateFin
FROM formation f
INNER JOIN session s ON f.codeFormation = s.codeSess;

SELECT f.titreFormation AS titreForm, e.nomEtudiant, e.prenomEtudiant
FROM formation f
INNER JOIN inscription i ON f.codeFormation = i.codeSess
INNER JOIN etudiant e ON i.numCNEtu = e.codeEtudiant
ORDER BY f.titreFormation;

SELECT 
    SUM(CASE WHEN i.typeCours = 'Distanciel' THEN 1 ELSE 0 END) AS inscriptions_distancielles,
    SUM(CASE WHEN i.typeCours = 'Présentiel' THEN 1 ELSE 0 END) AS inscriptions_presentielles
FROM inscription i
INNER JOIN session s ON i.codeSess = s.codeSess
INNER JOIN formation f ON s.codeSess = f.codeFormation
WHERE f.titreFormation = 'Web developpement';

SELECT f.titreFormation, COUNT(*) AS nombre_inscriptions_distancielles
FROM formation f
JOIN session s ON f.codeFormation = s.codeSess
JOIN inscription i ON s.codeSess = i.codeSess
WHERE i.typeCours = 'Distanciel'
GROUP BY f.titreFormation;

SELECT sp.nomSpecialite, f.titreFormation, f.dureeFormation, f.prixFormation
FROM formation f
INNER JOIN specialite sp ON f.codeFormation = sp.codeSpecialite
WHERE sp.active = 1
ORDER BY sp.nomSpecialite DESC;

SELECT YEAR(s.dateDebut) AS Annee, MONTH(s.dateDebut) AS Mois, SUM(f.prixFormation) AS TotalPrix
FROM session s
INNER JOIN formation f ON s.codeSess = f.codeFormation
GROUP BY Annee, Mois;




