#1. Liste de tous les numéros, noms et prénoms des chercheurs, classée par ordre alphabétique sur le nom.
SELECT NC, NOM, PRENOM FROM CHERCHEUR ORDER BY NOM;

#2. Liste de tous les budgets triés par ordre décroissant et sans doublons.
SELECT DISTINCT BUDJET FROM PROJET ORDER BY BUDJET DESC;

#3. Liste de tous les projets dont le budget est entre 400000 et 900000 euros.
SELECT NOM , BUDJET FROM PROJET WHERE BUDJET BETWEEN 400000 AND 900000;

#4. Liste des chercheurs en précisant pour chacun le nom de l’équipe à laquelle il appartient.
SELECT c.NOM "NOM" , c.PRENOM , e.NOM "Nom de l'equipe" FROM CHERCHEUR c , EQUIPE e WHERE c.NE = e.NE;

#5. Lister tous les noms des projets, leurs budgets ainsi que les noms des chercheurs qui leur sont affectés.
SELECT p.NOM , p.BUDJET , c.Nom FROM PROJET p , AFF a ,CHERCHEUR c WHERE p.NP=a.NP AND a.NC=c.NC;

#6. Lister les noms et prénoms des chercheurs qui n’ont participé à aucun projet
SELECT NOM FROM CHERCHEUR  WHERE NC NOT IN (SELECT AFF.NC FROM AFF);

#7. Lister les noms de toutes les équipes et le nombre de projets qui lui appartiennent (indiquer 0 si l’équipe ne gère aucun projet)
SELECT  distinct e.NOM, COUNT(P.NOM) FROM EQUIPE e LEFT JOIN PROJET P on e.NE = P.NE GROUP BY e.NOM;

#8. Lister tous les noms des projets, leurs budgets ainsi que le nombre de chercheurs qui leurs sont affectés
#. Les projets auxquels n’est affecté aucun chercheur seront affichés avec 0 chercheurs.
SELECT distinct P.NOM, P.BUDJET , COUNT(C.NOM) "Nombre de chercheurs" FROM PROJET P
    LEFT JOIN AFF A on P.NP = A.NP
    LEFT JOIN CHERCHEUR C on A.NC = C.NC GROUP BY P.NOM, P.BUDJET;

#9. Lister les noms des projets auxquels sont affectés au moins 2 chercheurs.
SELECT distinct P.NOM FROM PROJET P
    JOIN AFF A on P.NP = A.NP
    JOIN CHERCHEUR C on A.NC = C.NC GROUP BY P.NOM, P.BUDJET HAVING count(C.NOM) > 2;

#10. Lister les noms et prénoms des chercheurs qui ont participé à plus de 4 projets.
SELECT c.NOM , PRENOM FROM CHERCHEUR c , PROJET P , AFF a WHERE c.NC = a.NC AND a.NP = p.NP GROUP BY c.NOM HAVING COUNT(P.NOM) > 4;

#11. Lister les noms et prénoms des chercheurs qui ont participé à plus de 2 projets durant une année et dont le budget du projet est supérieur à 30k euros
SELECT distinct c.NOM , PRENOM  FROM CHERCHEUR c , PROJET P , AFF a WHERE c.NC = a.NC AND a.NP = p.NP AND BUDJET > 30000 GROUP BY ANNEE HAVING COUNT(P.NOM) >= 2;

#12. Lister les chercheurs qui ont participé à un projet dont « M. VIEIRA » a participé en 2018.
SELECT distinct c.NOM , PRENOM  FROM CHERCHEUR c , AFF a WHERE c.NC = a.NC AND UPPER(NOM) NOT LIKE 'VIEIRA' AND a.NP IN (
    SELECT NP FROM AFF a , CHERCHEUR c  WHERE a.NC = c.NC AND UPPER(c.NOM) LIKE 'VIEIRA' AND a.ANNEE = 2018);

#13. Lister les chercheurs qui ont participé à tous les projets de leur équipe.
SELECT distinct C.NOM , PRENOM FROM CHERCHEUR C JOIN AFF A on C.NC = A.NC JOIN PROJET P on P.NP = A.NP WHERE C.NE = ALL (SELECT NE FROM CHERCHEUR C2 WHERE C2.NC = C.NC)

#14. Lister les noms et prénoms des chercheurs qui ont participé au plus grand nombre de projets.
SELECT NombrePrj.NOM , NombrePrj.PRENOM
FROM (  SELECT NOM , PRENOM,  COUNT(NP) mycount
        FROM AFF JOIN CHERCHEUR C on C.NC = AFF.NC
        GROUP BY NOM , PRENOM)
    as NombrePrj HAVING MAX(NombrePrj.mycount);

#15. Lister les projets dont le budget est supérieur à tous les budgets des projets de l’année 2018.
SELECT * FROM PROJET WHERE BUDJET > ALL (SELECT BUDJET FROM PROJET NATURAL JOIN AFF A WHERE A.ANNEE = 2018);
# Aucun résultat car le budget le + élevé de l'année 2018 est aussi le + élevé toutes années confondues (projet: p08)

#16. Lister les projets dont le budget est supérieur à un budget quelconque de l’année 2018.
SELECT NOM , BUDJET FROM PROJET WHERE BUDJET > ANY (SELECT distinct BUDJET FROM PROJET RIGHT JOIN AFF A on PROJET.NP = A.NP WHERE ANNEE = '2018' );

#17. Lister les équipes qui ont au moins un projet auquel a participé plus de 2 chercheurs.
SELECT NOM FROM EQUIPE WHERE NE IN ( SELECT e.NE FROM EQUIPE e JOIN PROJET P on e.NE = P.NE JOIN AFF A on p.NP = A.NP HAVING COUNT(a.NC) > 2);
SELECT distinct e.NOM FROM PROJET p  JOIN AFF A on p.NP = A.NP JOIN EQUIPE E on p.NE = E.NE  GROUP BY e.NOM, p.NOM HAVING COUNT(a.NC) > 2;

#18. Lister les équipes dont tous les projets ont plus de 2 participants.
SELECT distinct e.NOM  FROM EQUIPE e JOIN PROJET P on e.NE = P.NE JOIN AFF A on P.NP = A.NP GROUP BY e.NOM, p.NOM HAVING COUNT(NC) > 2;

#19. Donner les noms et le nombre de chercheurs y participant des projets qui ont le plus grand budget.
SELECT p.NOM  "Nom du projet", COUNT(a.NC) "Nombre de chercheur" FROM PROJET p JOIN AFF A on p.NP = A.NP HAVING MAX(BUDJET);
#20. Lister par année le nombre de chercheurs affectés à des projets entre les années 2011 et 2021.
SELECT COUNT(distinct C.NC), ANNEE FROM CHERCHEUR C NATURAL JOIN AFF A WHERE ANNEE > 2011 AND ANNEE < 2021 GROUP BY ANNEE;

#21. Lister les noms et prénoms des chercheurs qui ont participés dans les projets de 2 équipes différentes.
SELECT C.NOM , PRENOM FROM CHERCHEUR C JOIN AFF A on C.NC = A.NC JOIN PROJET P on P.NP = A.NP GROUP BY C.NOM , PRENOM HAVING COUNT(P.NE) > 2;

#22. Lister les noms et prénoms des chercheurs qui ne participent que dans le projet « Pacific-Clouds avec CAPES – Bresil ».
SELECT C.NOM, PRENOM FROM CHERCHEUR C, PROJET P, AFF A
    WHERE C.NC = A.NC AND P.NP = A.NP
      AND P.NOM = 'Pacific-Clouds avec CAPES - Bresil'
    GROUP BY C.NOM, PRENOM
    HAVING COUNT(P.NP) = 1;
#23. Lister les projets auxquels sont affectés les chercheurs « BOUGUEROUA » et « WOLSKA »
SELECT distinct p.NOM FROM PROJET p JOIN AFF A on p.NP = A.NP JOIN CHERCHEUR C on A.NC = C.NC WHERE UPPER(C.NOM) IN ('BOUGUEROUA','WOLSKA');

#24. Lister les projets auxquels ne sont affectés ni « BOUGUEROUA », ni « WOLSKA »
SELECT NOM FROM PROJET WHERE NP NOT IN (SELECT A.NP FROM  AFF A JOIN CHERCHEUR C on A.NC = C.NC WHERE UPPER(C.NOM) IN ('BOUGUEROUA','WOLSKA'));
#25. Lister les noms des équipes triées selon le nombre de chercheurs lui appartenant, par ordre croissant, et par la moyenne de leurs budgets par ordre décroissant.
#26. Lister les noms de duo de chercheurs qui participent le plus sur des projets communs ensemble.

#27. Lister les noms de projets dont le budget est de plus de 30K et auxquels sont affectés au moins un chercheur par équipe.
SELECT P.NOM FROM PROJET P JOIN EQUIPE E on E.NE = P.NE JOIN AFF A on P.NP = A.NP WHERE BUDJET > 30000 HAVING COUNT(A.NC) > 1;

#28. Lister tous les chercheurs ayant participé à des projets entre 2011 et 2018 ainsi les noms des projets et leurs budgets.
SELECT CHERCHEUR.NOM , P.BUDJET , P.NOM FROM CHERCHEUR JOIN AFF A on CHERCHEUR.NC = A.NC JOIN PROJET P on A.NP = P.NP WHERE ANNEE BETWEEN '2011' AND '2018';

#29. Utiliser la requête précédente pour lister les noms et prénoms des chercheurs ayant participé à des projets entre 2011 et 2018 ainsi que le nombre de ces projets et le total de leurs budgets.
SELECT CHERCHEUR.NOM , PRENOM, COUNT(P.NP), SUM(BUDJET) FROM CHERCHEUR JOIN AFF A on CHERCHEUR.NC = A.NC JOIN PROJET P on P.NP = A.NP WHERE ANNEE  BETWEEN  '2011' AND '2018' GROUP BY NOM, PRENOM;

#30. Donner les noms et prénoms des chercheurs qui ont participé à tous ls projets de l’année 2018.
SELECT NOM , PRENOM  FROM CHERCHEUR NATURAL JOIN AFF A WHERE NP = all (SELECT distinct NP FROM AFF A2 WHERE A2.ANNEE = '2018');
