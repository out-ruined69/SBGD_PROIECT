--pentru fiecare galerie sa sa calculeze profitul acesta fiind diferenta dintre donatiile primite si suma salariilor
--staffului
CREATE OR REPLACE FUNCTION CERINTA8(numegal galerie.nume_galerie%type) RETURN NUMBER
IS
 donatii NUMBER;
 datorii NUMBER;
 profit NUMBER;

 TYPE tabl_indx IS TABLE OF GALERIE%ROWTYPE INDEX BY PLS_INTEGER;
 aux tabl_indx;

 TYPE tabl_indx_sps IS TABLE OF GALERIE_SPONSOR_MAPPING%ROWTYPE INDEX BY PLS_INTEGER;
 aux_sps tabl_indx_sps;

 TYPE tabl_indx_ang IS TABLE OF ANGAJAT%ROWTYPE INDEX BY PLS_INTEGER;
 aux_ang tabl_indx_ang;

 NO_DATA_FOUND_GAL EXCEPTION;
 NO_DATA_FOUND_DATORIE EXCEPTION;
 TOO_MANY_ROWS EXCEPTION;
BEGIN

 donatii:=0;
 datorii:=0;

 SELECT *
 BULK COLLECT INTO aux
 from GALERIE
 WHERE numegal = galerie.nume_galerie;

 IF SQL%NOTFOUND THEN
 RAISE NO_DATA_FOUND_GAL;
 END IF;

 IF aux.count>1 THEN
 RAISE TOO_MANY_ROWS;
 END IF;

 --DONATIILE

 SELECT gsm.id_galerie, gsm.id_sponsor, gsm.donatie
 BULK COLLECT INTO aux_sps
 FROM GALERIE g
 INNER JOIN GALERIE_SPONSOR_MAPPING gsm ON g.id_galerie = gsm.id_galerie
 WHERE UPPER(g.nume_galerie) LIKE UPPER(numegal);
 IF SQL%NOTFOUND THEN
 RAISE NO_DATA_FOUND_DATORIE;
 END IF;

 SELECT sum(donatie)
 INTO DONATII
 FROM GALERIE g
 INNER JOIN GALERIE_SPONSOR_MAPPING gsm ON g.id_galerie = gsm.id_galerie
 WHERE UPPER(g.nume_galerie) LIKE UPPER(numegal)
 group by nume_galerie;


 --Salariile
 SELECT an.id_angajat,an.nume_angajat, an.prenume_angajat, an.data_nastere, an.salariu, an.cnp,
an.id_staff
 BULK COLLECT INTO aux_ang
 FROM GALERIE g
 INNER JOIN EVENIMENT ev ON g.id_galerie = ev.id_galerie
 INNER JOIN EVENIMENT_STAFF_MAPPING ESM ON esm.id_eveniment = ev.id_eveniment
 INNER join STAFF s on s.id_staff = esm.id_staff
 INNER join angajat an on an.id_STAFF = s.id_staff
 WHERE UPPER(g.nume_galerie) LIKE UPPER(numegal);

 IF SQL%NOTFOUND THEN
 datorii:=0;

 ELSE
 SELECT sum(salariu)
 INTO DATORII
 FROM GALERIE g
 INNER JOIN EVENIMENT ev ON g.id_galerie = ev.id_galerie
 INNER JOIN EVENIMENT_STAFF_MAPPING ESM ON esm.id_eveniment = ev.id_eveniment
 inner join STAFF s on s.id_staff = esm.id_staff
 inner join angajat an on an.id_angajat = s.id_staff
 WHERE UPPER(g.nume_galerie) LIKE UPPER(numegal)
 GROUP BY nume_galerie;
 END IF;

 profit:= donatii-datorii;
 IF PROFIT < 0 THEN
 RAISE NO_DATA_FOUND_DATORIE;
 END IF;
 DBMS_OUTPUT.PUT_LINE(profit);
 return profit;
 EXCEPTION
 WHEN NO_DATA_FOUND_GAL THEN
 DBMS_OUTPUT.PUT_LINE('Nu exista aceasta galerie!');
 RETURN -1000;
 WHEN NO_DATA_FOUND_DATORIE THEN
 DBMS_OUTPUT.PUT_LINE('Nu a realizat niciun profit!');
 RETURN -1000;
 WHEN TOO_MANY_ROWS THEN
 DBMS_OUTPUT.PUT_LINE('Exista mai multe galerii cu acest nume!');
 RETURN -1000;
 WHEN OTHERS THEN
 DBMS_OUTPUT.PUT_LINE('Alta eroare!');
 RETURN -1000;
END;
/
DECLARE
aux NUMBER;
BEGIN
--aux := CERINTA8('Primavera');

--aux := CERINTA8('Bjork');
--aux := CERINTA8('Datorie');
aux := CERINTA8('Quirkcy');
DBMS_OUTPUT.PUT_LINE(aux);
END;
/
insert into galerie (id_galerie, id_oras, id_coord, nume_galerie) values (9, 1, 1, 'Quirkcy');
insert into galerie (id_galerie, id_oras, id_coord, nume_galerie) values (8, 1, 1, 'Datorie');
insert into EVENIMENT (id_eveniment, id_galerie, nume_eveniment, data_inceput, data_final) values (18, 8,
'Nomooney', '12/06/2014', '24/07/2014');
insert into EVENIMENT_STAFF_MAPPING (id_eveniment, id_staff) values (18, 2);
SELECT * FROM GALERIE
SELECT nume_galerie, sum(salariu) as Datorie FROM GALERIE g
INNER JOIN EVENIMENT ev ON g.id_galerie = ev.id_galerie
INNER JOIN EVENIMENT_STAFF_MAPPING ESM ON esm.id_eveniment = ev.id_eveniment
inner join STAFF s on s.id_staff = esm.id_staff
inner join angajat an on an.id_angajat = s.id_staff
GROUP BY nume_galerie
SELECT nume_galerie, sum(donatie) FROM GALERIE g
INNER JOIN GALERIE_SPONSOR_MAPPING gsm ON g.id_galerie = gsm.id_galerie
group by nume_galerie