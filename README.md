# HAI725IBase_De_donnee
University of Montpellier

Create on X2go Linux, using Oracle database of University

In terminal :
1. Go to the folder where save the sql script
2. Enter following command, to connect Oracle server.  
    rlwrap sqlplus e20210011437/sunying@oracle.etu.umontpellier.fr:1523/pmaster
3. SQL>@fileName.sql for execute the script 



```
-- Oracle has no databases but schemas, you can list them with
-- E20210011437 is my schema
SELECT USERNAME FROM ALL_USERS ORDER BY USERNAME;

-- show all tables in my schema
SELECT TABLE_NAME FROM USER_TABLES;
```