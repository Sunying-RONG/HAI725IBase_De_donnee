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

-- desc EMP
-- SELECT * FROM EMP;

-- 1 Donner les nom, fonction et date d’embauche de tous les employés,
-- SELECT nom, fonction, embauche from EMP;

-- 2. Donner les numéros, nom et salaire des employés dont le salaire est <= 2000 euros,
-- SELECT num, nom, salaire from EMP 
-- WHERE salaire <= 2000;

-- 3. Donner la liste des employés ayant une commission, classée par commission décroissante,
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