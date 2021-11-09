--SCRIPT de remplissage de tables

ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
ALTER SESSION SET NLS_TERRITORY = AMERICA;

DROP TABLE EMP;
DROP TABLE DEPT;

-- TABLES A CREER
CREATE TABLE EMP (nom varchar(10), num number(5), fonction varchar(15), 
        n_sup number(5), embauche date, salaire number(7,2), 
        comm number(7,2), n_dept number(3));
CREATE TABLE DEPT (n_dept number(3), nom varchar(14), lieu varchar(13));

INSERT INTO EMP VALUES
        ('MARTIN',16712,'directeur',25717,'23-MAY-90',20000,NULL,30);
INSERT INTO EMP VALUES
        ('DUPONT',17574,'administratif',16712,'03-MAY-05',2000,NULL,30);
INSERT INTO EMP VALUES
        ('DUPOND',26691,'commercial',27047,'04-APR-08',2500,2500,20);
INSERT INTO EMP VALUES
        ('LAMBERT',25012,'administratif',27047,'14-APR-91',2200,NULL,20);
INSERT INTO EMP VALUES
        ('JOUBERT',25717,'president',NULL,'10-OCT-92',30000,NULL,30);
INSERT INTO EMP VALUES
        ('LEBRETON',16034,'commercial',27047,'01-JUN-99',3000,0,20);
INSERT INTO EMP VALUES
        ('MARTIN',17147,'commercial',27047,'10-DEC-73',1500,500,20);
INSERT INTO EMP VALUES
        ('PAQUEL',27546,'commercial',27047,'03-SEP-93',2000,300,20);
INSERT INTO EMP VALUES
        ('LEFEBVRE',25935,'commercial',27047,'11-JAN-04',2300,100,20);
INSERT INTO EMP VALUES
        ('GARDARIN',15155,'ingenieur',24533,'22-MAR-85',2400,NULL,10);
INSERT INTO EMP VALUES
        ('SIMON',26834,'ingenieur',24533,'04-OCT-88',2000,NULL,10);
INSERT INTO EMP VALUES
        ('DELOBEL',16278,'ingenieur',24533,'16-NOV-94',2000,NULL,10);
INSERT INTO EMP VALUES
        ('ADIBA',25067,'ingenieur',24533,'05-OCT-97',3000,NULL,10);
INSERT INTO EMP VALUES
        ('CODD',24533,'directeur',25717,'12-SEP-75',5500,NULL,10);
INSERT INTO EMP VALUES
        ('LAMERE',27047,'directeur',25717,'07-SEP-99',4500,NULL,20);
INSERT INTO EMP VALUES
	('BALIN',17232,'administratif',24533,'03-OCT-97',1300,NULL,10);
INSERT INTO EMP VALUES
	('BARA',24831,'administratif', 16712,'10-SEP-08',1500,NULL,30);

--

INSERT INTO DEPT VALUES
        (10,'recherche','Rennes');
INSERT INTO DEPT VALUES (20,'vente','Metz');
INSERT INTO DEPT VALUES
        (30,'direction','Gif');
INSERT INTO DEPT VALUES
        (40,'fabrication','Toulon');

COMMIT;

-- SET WRAP OFF;
-- desc EMP
-- SELECT * FROM EMP;

-- 1 Donner les nom, fonction et date d’embauche de tous les employés,
-- projection

-- SELECT nom, fonction, embauche from EMP;


-- 2. Donner les numéros, nom et salaire des employés dont le salaire est <= 2000 euros,
-- selection, projection

-- SELECT num, nom, salaire from EMP 
-- WHERE salaire <= 2000;


-- 3. Donner la liste des employés ayant une commission, classée par commission décroissante,
-- selection, order by, projection

-- SELECT nom FROM EMP
-- WHERE comm IS NOT NULL
-- ORDER BY comm DESC;


-- retourner les departements qui ont plus de 5 employées
-- SELECT D.n_dept, D.nom, count(E.num)
-- FROM DEPT D, EMP E
-- WHERE D.n_dept = E.n_dept
-- GROUP BY D.n_dept, D.nom HAVING count(E.num) > 5;

-- retourner les departements qui ont les plus nombreux d'employées
-- SELECT n_dept, count(num)
-- FROM EMP
-- GROUP BY n_dept HAVING count(num)=
-- (SELECT max(count(num)) FROM EMP GROUP BY n_dept);

-- test EXISTS
-- SELECT num 
-- FROM EMP E
-- WHERE EXISTS (SELECT * FROM DEPT D WHERE E.num = D.n_dept);

-- test ORDER BY
-- SELECT *
-- FROM EMP
-- ORDER BY n_dept, num;

-- 4. Donner le nom des personnes embauchées depuis janvier 1991,
-- For year use YYYY to compare, more clear
-- condition, projection

-- SELECT nom 
-- FROM EMP 
-- WHERE embauche > TO_DATE('01-JAN-1991','DD-MON-YYYY');


-- 5. Donner pour chaque employé son nom et son lieu de travail,
-- jointure naturelle, projection

-- SELECT e.nom, d.lieu 
-- FROM EMP e, DEPT d 
-- WHERE e.n_dept = d.n_dept;


-- 6. Donner pour chaque employé le nom de son supérieur hiérarchique,
-- auto jointure, projection
-- SELECT e1.nom AS superieur, e2.nom 
-- FROM EMP e1, EMP e2 
-- WHERE e1.num = e2.n_sup;

-- 7. Quels sont les employés ayant la même fonction que ”CODD” ?
-- projection, selection imbrique
-- SELECT nom FROM EMP WHERE fonction = (SELECT fonction FROM EMP WHERE nom = 'CODD');
-- select e.nom, e.fonction from Emp e, Emp codd where e.fonction = codd.fonction and codd.nom = 'CODD' add e.nom <> 'CODD';
-- select nom, fonction from Emp where nom <> 'CODD' and fonction in (select fonction...)
-- select nom, fonction from Emp e where nom <> 'CODD' and exists (select *from Emp c where nom = 'CODD' and e.fonction = c.fonction);


-- 8. Quels sont les employés gagnant plus que tous les employés du département 30 ?
-- projection, selection imbrique, max()

-- SELECT nom FROM EMP WHERE salaire > (SELECT max(salaire) FROM EMP WHERE n_dept = 30);
-- ALL() for general use, max() only for oracle


-- 9. Quels sont les employés ne travaillant pas dans le même département que leur supérieur hiérarchique ?
-- projection, selection, jointure

-- SELECT e1.nom 
-- FROM EMP e1, EMP e2 
-- WHERE e1.n_sup = e2.num AND e1.n_dept != e2.n_dept;


-- 10. Quels sont les employés travaillant dans un département qui a procédé à des embauches depuis le début de l’année 98,
-- select distinct imbrique, projection, 

-- SELECT nom 
-- FROM EMP 
-- WHERE n_dept IN (SELECT DISTINCT n_dept FROM EMP WHERE embauche > TO_DATE('01-JAN-1998', 'DD-MON-YYYY'));


-- 11. Donner le nom, la fonction et le salaire de l’employé (ou des employés) ayant le salaire le plus élevé,
-- projection, selection imbrique, max()

-- SELECT nom, fonction, salaire
-- FROM EMP
-- WHERE salaire = (SELECT max(salaire) FROM EMP);


-- 12. Donner le total des salaires, le nombre de salariés, ainsi que le salaire minimal, moyen et maximal pour l’ensemble des salariés de chaque département,
-- projection, GROUP BY,  unction

-- SELECT n_dept, sum(salaire), count(num), min(salaire), avg(salaire), max(salaire) 
-- FROM EMP 
-- GROUP BY n_dept;


-- 13. Donner le ou les départements ayant le plus d’employés,
-- create vie

-- CREATE OR REPLACE VIEW ChaqueDept AS
-- SELECT n_dept, count(num) AS nombre 
-- FROM EMP 
-- GROUP BY n_dept;

-- SELECT n_dept
-- FROM ChaqueDept
-- WHERE nombre = (SELECT max(nombre) FROM ChaqueDept);


-- 14. Donner les départements qui ne possèdent pas d’employés exerçant la fonction d’ingénieur,
-- MINUS

-- SELECT n_dept
-- FROM DEPT
-- MINUS
-- SELECT n_dept
-- FROM EMP 
-- WHERE fonction = 'ingenieur';


-- 15. Donner les départements possédant des employés exerçant l’ensemble des fonctions référencées au sein de la société.
-- division, par deux difference
-- CREATE OR REPLACE VIEW NonToutFonc AS
-- SELECT DISTINCT e1.n_dept, e2.fonction 
-- FROM EMP e1, EMP e2
-- MINUS 
-- SELECT DISTINCT n_dept, fonction
-- FROM EMP;

-- SELECT DISTINCT n_dept
-- FROM EMP 
-- MINUS 
-- SELECT n_dept
-- FROM NonToutFonc;

-- CHECK
-- SELECT n_dept, fonction
-- FROM EMP 
-- ORDER BY n_dept;

-- TP2
-- 2.1 definition des contraintes
ALTER TABLE DEPT ADD CONSTRAINT dept_pk PRIMARY KEY(n_dept);

ALTER TABLE EMP ADD CONSTRAINT emp_pk PRIMARY KEY(num);

-- find doublon
-- SELECT COUNT(*) AS doublon, nom 
-- FROM EMP 
-- GROUP BY nom
-- HAVING COUNT(*) > 1;

-- SELECT nom, num 
-- FROM EMP 
-- WHERE nom = 'MARTIN';
--change doublon
UPDATE EMP SET nom = 'MARTIN2' 
WHERE num = 17147;

ALTER TABLE EMP ADD CONSTRAINT nom_u UNIQUE(nom);

ALTER TABLE EMP ADD CONSTRAINT responsable FOREIGN KEY(n_sup) REFERENCES EMP(num); 

ALTER TABLE EMP ADD CONSTRAINT dept FOREIGN KEY(n_dept) REFERENCES DEPT(n_dept) ON DELETE CASCADE;

-- SELECT * FROM EMP 
-- WHERE (comm IS NOT NULL AND fonction <> 'commercial') 
-- OR (comm is NULL AND fonction = 'commercial');

ALTER TABLE EMP ADD CONSTRAINT commission 
CHECK((comm IS NOT NULL AND fonction = 'commercial') OR 
(comm IS NULL AND fonction <> 'commercial'));

-- SELECT * FROM user_constraints;
-- select constraint_name, constraint_type, table_name from user_constraints;
-- col constraint_name for a20
-- alphanumeric