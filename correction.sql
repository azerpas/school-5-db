#1. Liste de tous les numéros, noms et prénoms des chercheurs, classée par ordre alphabétique sur le nom. SELECT nc, nom, prenom from chercheur order by nom;
#2. Liste de tous les BUDGETs triés par ordre décroissant et sans doublons.
SELECT DISTINCT BUDJET FROM projet ORDER BY BUDJET DESC;
#3. Liste de tous les projets dont le BUDGET est entre 400000 et 900000 euros.
SELECT * FROM projet WHERE BUDJET BETWEEN 400000 AND 900000;
#4. Liste des chercheurs en précisant pour chacun le nom de l’équipe à laquelle il appartient.
SELECT c.*, e.NOM FROM chercheur c INNER JOIN equipe e ON c.NE = e.NE;
#5. Lister tous les noms des projets, leurs BUDGETs ainsi que les noms des chercheurs qui leur sont affectés. 
SELECT DISTINCT p.NOM, p.BUDJET, c.NOM FROM projet p JOIN aff a JOIN chercheur c ON p.NP = a.NP AND a.NC = c.NC;
#6. Lister les noms et prénoms des chercheurs qui n’ont participé à aucun projet 
SELECT c.NOM, c.PRENOM FROM chercheur c
   WHERE  NOT EXISTS (SELECT * FROM aff a WHERE a.NC = c.NC);
-- 6 bis
   SELECT NOM, PRENOM from chercheur
    where NC Not IN (Select DISTINCT NC from AFF);
-- 6 bis2
SELECT c.NOM, c.PRENOM FROM chercheur c left join AFF a on c.NC=a.NC WHERE a.NP IS NULL;
#7. Lister les noms de toutes les équipes et le nombre de projets qui lui appartiennent (indiquer 0 si l’équipe ne gère aucun projet)
SELECT e.NOM, COUNT(p.NP) FROM equipe e LEFT JOIN projet p ON e.NE = p.NE GROUP BY e.NE, e.NOM;
#8. Lister tous les noms des projets, leurs BUDGETs ainsi que le nombre de chercheurs qui leurs sont affectés. Les projets auxquels n’est affecté aucun chercheur seront affichés avec 0 chercheurs.
SELECT p.NOM, p.BUDGET, COUNT(DISTINCT a.NC) FROM projet p
LEFT JOIN aff a ON p.NP = a.NP GROUP BY p.NP, p.NOM, p.BUDGET;
#9. Lister les noms des projets auxquels sont affectés au moins 2 chercheurs.
SELECT p.NOM FROM projet p JOIN aff a ON p.NP = a.NP
    GROUP BY p.NP, p.NOM HAVING count(DISTINCT a.NC)>=2;
#10. Lister les noms et prénoms des chercheurs qui ont participé à plus de 4 projets.
SELECT NOM, PRENOM FROM chercheur NATURAL JOIN aff
    Group by NOM, PRENOM Having Count(DISTINCT NP)>4;
#11. Lister les noms et prénoms des chercheurs qui ont participé à plus de 2 projets durant une année et dont le BUDGET du projet est supérieur à 30k euros
SELECT DISTINCT c.NOM, c.PRENOM
FROM chercheur c JOIN aff a JOIN projet p ON c.NC = a.NC AND a.NP = p.NP Where p.BUDGET > 30000
Group by a.ANNEE , c.NOM, c.PRENOM Having Count(a.NP)>2 ;
#12. Lister les chercheurs qui ont participé à un projet dont « M. VIEIRA » a participé en #2018.
 SELECT  DISTINCT c.*
 FROM chercheur c JOIN aff a ON c.NC = a.NC
 WHERE c.NOM <> 'VIEIRA' and a.NP IN
(SELECT DISTINCT NP FROM aff NATURAL JOIN chercheur WHERE NOM = 'VIEIRA' and ANNEE = '2018');
#13. Lister les chercheurs qui ont participé à tous les projets de leur équipe.
 SELECT NC, Nom FROM chercheur c
 WHERE NOT EXISTS (SELECT NP FROM projet p
                    where p.ne=c.ne AND not exists (SELECT * from aff a
                       where a.NP=p.np and a.nc=c.nc));
#14. Lister les noms et prénoms des chercheurs qui ont participé au plus grand nombre de projets.
 SELECT c.NOM, c.PRENOM
 FROM chercheur c JOIN aff a ON c.NC = a.NC
 GROUP BY c.nc, c.NOM, c.PRENOM
 HAVING COUNT(DISTINCT a.NP) >= ALL(
         SELECT COUNT(DISTINCT NP)
         FROM aff GROUP BY NC);
#15. Lister les projets dont le BUDGET est supérieur à tous les BUDGETs des projets de l’année #2018.
 SELECT NOM FROM  projet
 WHERE BUDGET >ALL (
SELECT DISTINCT BUDGET FROM projet NATURAL JOIN aff WHERE annee=2018);
#16. Lister les projets dont le BUDGET est supérieur à un BUDGET quelconque de l’année #2018.
 SELECT NOM FROM  projet
 WHERE BUDGET >ANY (
SELECT DISTINCT BUDGET FROM projet NATURAL JOIN aff WHERE annee=2018);
#17. Lister les équipes qui ont au moins un projet auquel a participé plus de 2 chercheurs.
SELECT DISTINCT e.* FROM equipe e JOIN projet p ON e.NE = p.NE WHERE p.NP IN (
SELECT NP FROM AFF a GROUP BY NP HAVING count(DISTINCT NC) > 2);
#18. Lister les équipes dont tous les projets ont plus de 2 participants.
SELECT * From Equipe
    Where NE IN (SELECT DISTINCT NE FROM Projet p NATURAL JOIN AFF
    GROUP BY NP HAVING count(DISTINCT NC) > 2)
    AND NE NOT IN(SELECT DISTINCT NE FROM Projet p2 LEFT JOIN AFF a2
    ON p.NP=a.NP GROUP BY p.NP HAVING count(DISTINCT a.NC) <= 2);
#19. Donner les noms et le nombre de chercheurs y participant des projets qui ont le plus grand BUDGET.
SELECT NOM, COUNT(DISTINCT NC) AS nbChercheurs FROM PROJET P NATURAL JOIN aff
WHERE P.BUDJET = (SELECT MAX(p.BUDJET) FROM projet p) GROUP by NP, NOM ;
#20. Lister par année le nombre de chercheurs affectés à des projets entre les années 2011 et #2021.
SELECT annee, COUNT(DISTINCT NC) AS nbChercheurs FROM aff a
WHERE annee BETWEEN 2011 AND 2021 GROUP BY annee;

#21. Lister les noms et prénoms des chercheurs qui ont participés dans les projets de 2 équipes différentes.
SELECT DISTINCT c.nom, prenom
FROM chercheur c, projet p1, aff a1
WHERE c.NC=a.nc and p.np=a.np and exists (SELECT * FROM projet p2, aff a2
WHERE a.nc=c.nc and p.np=a.np and a.np<>a.np);
#22. Lister les noms et prénoms des chercheurs qui ne participent que dans le projet « Pacific-Clouds avec CAPES – Bresil ».
SELECT c.nom, prenom
FROM chercheur c
Where not exists (select * from aff, projet where aff.np=projet.np and aff.nc=c.nc and projet.nom <> 'Pacific-Clouds avec CAPES – Bresil') ;
#23. Lister les projets auxquels sont affectés les chercheurs « BOUGUEROUA » et « WOLSKA »
SELECT projet.NP, projet.nom
FROM projet, aff, chercheur
WHERE projet.NP=aff.NP and aff.NC=chercheur.NC and chercheur.nom in ('BOUGUEROUA' ,'WOLSKA');
#24. Lister les projets auxquels ne sont affectés ni « BOUGUEROUA », ni « WOLSKA »
SELECT projet.NP
FROM projet
WHERE not exists (SELECT *
FROM aff, chercheur
WHERE aff.NP=projet.np and aff.NC=chercheur.NC and chercheur.nom in ('BOUGUEROUA' ,'WOLSKA'));
#25. Lister les noms des équipes triées selon le nombre de chercheurs lui appartenant, par ordre croissant, et par la moyenne de leurs BUDGETs par ordre décroissant.
SELECT q#1.nom, q#1.TotalChercheurs, q#2.MoyenneBUDGET
FROM (SELECT e.ne, e.nom, count(DISTINCT c.NC) as TotalChercheurs
       FROM equipe e LEFT JOIN chercheur c ON e.NE=c.NE
GROUP By e.NE, e.nom) q1,
(SELECT Equipe.ne, AVG(BUDGET) as MoyenneBUDGET
FROM Equipe LEFT JOIN Projet ON Equipe.ne=Projet.ne
       GROUP BY Equipe.ne) q2
 Where q#1.ne=q#2.ne Order by 2 asc, 3 desc;
#26. Lister les noms de duo de chercheurs qui participent le plus sur des projets communs ensemble.
SELECT c#1.nom, c#2.nom
FROM chercheur c1, chercheur c2, aff a1, aff a2
Where a#1.NC=c#1.NC and a#2.NC=c#2.NC and c#1.nom !=c#2.nom and a#1.NP=a#2.NP Group by c#1.nom, c#2.nom
Having count(a#1.NP)= (SELECT max (count(a #3.NP))
FROM chercheur c3, chercheur c4, aff a3, aff a4
Where a#3.NC=c#3.NC and a#4.NC=c#4.NC and c#3.nom !=c#4.nom and a#3.NP=a#4.NP Group by c#3.nom, c#4.nom)
#27. Lister les noms de projets dont le BUDGET est de plus de 30K et auxquels sont affectés au moins un chercheur par équipe.
SELECT p.nom
FROM projet p, aff a, chercheur c
WHERE BUDGET>30000 AND p.np=a.np AND a.nc=c.nc
GROUP BY p.np HAVING COUNT(DISTINCT c.NE) = (select count(*) from equipe);

#28. Lister tous les chercheurs ayant participé à des projets entre 2011 et 2018 ainsi les noms des projets et leurs BUDGETs.
Select DISTINCT c.nc, c.nom, p.nom, BUDGET
FROM chercheur c, projet p, aff a
WHERE c.nc=a.nc and p.np=a.np and annee between 2011 and 2018 ;
#29. Utiliser la requête précédente pour lister les noms et prénoms des chercheurs ayant participé à des projets entre 2011 et 2018 ainsi que le nombre de ces projets et le total de leurs BUDGETs.
Select nom, prenom, count(np), sum(BUDGET)
FROM (Select DISTINCT c.nc, c.nom nom, c.prenom prenom, p.np np, BUDGET
       FROM chercheur c, projet p, aff a
WHERE c.nc=a.nc and p.np=a.np and annee between 2011 and 2018) q1 Group by nc, nom, prenom ;
#30. Donner les noms et prénoms des chercheurs qui ont participé à tous les projets de l’année #2018.
 SELECT c.nom, c.prenom
 FROM chercheur c
 Where not exists (select np from projet p
                    where not exists (select * from aff a
                      where annee = 2018 and c.nc = a.nc and p.np = a.np));