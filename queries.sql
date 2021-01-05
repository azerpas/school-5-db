#1. Liste de tous les numéros, noms et prénoms des chercheurs, classée par ordre alphabétique sur le nom.
SELECT NC, ASC(NOM), PRENOM FROM CHERCHEUR;
#2. Liste de tous les budgets triés par ordre décroissant et sans doublons.
SELECT DISTINCT BUDJET FROM PROJET ORDER BY BUDJET DESC;
#3. Liste de tous les projets dont le budget est entre 400000 et 900000 euros.
#4. Liste des chercheurs en précisant pour chacun le nom de l’équipe à laquelle il appartient.
#5. Lister tous les noms des projets, leurs budgets ainsi que les noms des chercheurs qui leur sont affectés.
#6. Lister les noms et prénoms des chercheurs qui n’ont participé à aucun projet
#7. Lister les noms de toutes les équipes et le nombre de projets qui lui appartiennent (indiquer 0 si l’équipe ne gère aucun projet)
#8. Lister tous les noms des projets, leurs budgets ainsi que le nombre de chercheurs qui leurs sont affectés#. Les projets auxquels n’est affecté aucun chercheur seront affichés avec 0 chercheurs.
#9. Lister les noms des projets auxquels sont affectés au moins 2 chercheurs.
#10. Lister les noms et prénoms des chercheurs qui ont participé à plus de 4 projets.
#11. Lister les noms et prénoms des chercheurs qui ont participé à plus de 2 projets durant une année et dont le budget du projet est supérieur à 30k euros
#12. Lister les chercheurs qui ont participé à un projet dont « M. VIEIRA » a participé en 2018.
#13. Lister les chercheurs qui ont participé à tous les projets de leur équipe.
#14. Lister les noms et prénoms des chercheurs qui ont participé au plus grand nombre de projets.
#15. Lister les projets dont le budget est supérieur à tous les budgets des projets de l’année 2018.
#16. Lister les projets dont le budget est supérieur à un budget quelconque de l’année 2018.
#17. Lister les équipes qui ont au moins un projet auquel a participé plus de 2 chercheurs.
#18. Lister les équipes dont tous les projets ont plus de 2 participants.
#19. Donner les noms et le nombre de chercheurs y participant des projets qui ont le plus grand budget.
#20. Lister par année le nombre de chercheurs affectés à des projets entre les années 2011 et 2021.
#21. Lister les noms et prénoms des chercheurs qui ont participés dans les projets de 2 équipes différentes.
#22. Lister les noms et prénoms des chercheurs qui ne participent que dans le projet « Pacific-Clouds avec CAPES – Bresil ».
#23. Lister les projets auxquels sont affectés les chercheurs « BOUGUEROUA » et « WOLSKA »
#24. Lister les projets auxquels ne sont affectés ni « BOUGUEROUA », ni « WOLSKA »
#25. Lister les noms des équipes triées selon le nombre de chercheurs lui appartenant, par ordre croissant, et par la moyenne de leurs budgets par ordre décroissant.
#26. Lister les noms de duo de chercheurs qui participent le plus sur des projets communs ensemble.
#27. Lister les noms de projets dont le budget est de plus de 30K et auxquels sont affectés au moins un chercheur par équipe.
#28. Lister tous les chercheurs ayant participé à des projets entre 2011 et 2018 ainsi les noms des projets et leurs budgets.
#29. Utiliser la requête précédente pour lister les noms et prénoms des chercheurs ayant participé à des projets entre 2011 et 2018 ainsi que le nombre de ces projets et le total de leurs budgets.
#30. Donner les noms et prénoms des chercheurs qui ont participé à tous ls projets de l’année 2018.