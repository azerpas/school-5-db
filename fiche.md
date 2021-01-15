# SQL

### Inner Join

Retourner la ligne quand la condition est vrai
dans les 2 tables. 

### Natural Join

Jointure naturelle entre 2 tables s’il y a au moins une colonne similaire.

### Left Join

Garde toutes les lignes de la table de gauche même si la condition n'est pas satisfaite (remplace par NULL).

### Cross Join

Produit cartésien.

## Types

BIGINT, INT, CHAR, VARCHAR, TEXT, REAL, FLOAT, DATE, TIMESTAMP, MONEY, BOOLEAN

## Prédicats (dans `where`)

- BETWEEN ... AND ..
- ... LIKE ...  
[see wildcards](##wildcards)
- ... IS NULL
- IN ...
- NOT ...
- ANY ...
- ALL ...
- EXISTS ...

## Fonctions statiques

- MAX MIN
- SUM
- COUNT
- AVG


## Clés primaires / étrangères

Une table:     
- Peut posséder une clé primaire composée d'un seul attribut
- Peut posséder une clé primaire composée de plusieurs attributs

## Valeurs

- `NULL` = `null`

## Wildcards

`_`: **1** seul et n'importe quel caractère     
`%`: **0 ou plusieurs** caractères

## Group by / Having
```sql
# Group by
SELECT SUM(Prix), Puissance FROM VOITURE GROUP BY Puissance;
# Having
SELECT MAX(Prix), Puissance FROM VOITURE GROUP BY Puissance HAVING COUNT(*) > 1 ;
```

# Modèle relationnel

### Opérations

Union, Intersection, Différence, Sélection, Projection, Produit Cartésien, Division, Jointure

## Vocabulaire

- Relation = Table
- Attribut = Colonne
- Tuple = Ligne
- Degré = Nombre de colonnes
- Cardinalité = Nombre de lignes

## QCM vrac

- Set bag n'admet pas de doublons