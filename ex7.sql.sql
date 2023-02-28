--Sa se afiseze galeriile, evenimentele acelei galerii si exponatele ce apar la
--galerie a unui oras
CREATE OR REPLACE PROCEDURE CERINTA7(numeor ORAS.nume_oras%type)
AS

 CURSOR GALERII IS
 SELECT *
 FROM galerie
 WHERE id_oras = (
 SELECT id_oras
 FROM ORAS
 WHERE upper(nume_oras) LIKE upper(numeor)
 );

 CURSOR events(galerieid GALERIE.id_galerie%type) IS
 SELECT nume_eveniment, id_eveniment
 FROM EVENIMENT
 WHERE id_galerie = galerieid ;

 CURSOR arts(idev EVENIMENT.id_eveniment%type) IS
 SELECT nume_exponat || ' About: '|| descriere
 FROM EXPONAT_EVENIMENT_MAPPING eem
 INNER JOIN EXPONAT E
 ON E.id_exponat = eem.id_exponat
 WHERE eem.id_eveniment = idev;

 den eveniment.nume_eveniment%TYPE;
 evid eveniment.nume_eveniment%TYPE;
 text VARCHAR2(250);

BEGIN
 for i in galerii
 LOOP
 DBMS_OUTPUT.PUT_LINE('Galeria ' || i.nume_galerie);
 for j in events(i.id_galerie) LOOP
 DBMS_OUTPUT.PUT_LINE('Eveniment ' || j.nume_eveniment);
 OPEN arts(j.id_eveniment);
 LOOP
 FETCH arts INTO text;
 EXIT WHEN arts%NOTFOUND;
 DBMS_OUTPUT.PUT_LINE(' ' || text);
 END LOOP;
 CLOSE arts;
 END LOOP;
 DBMS_OUTPUT.PUT_LINE('____________________');
 END LOOP;
END;
/
BEGIN
 CERINTA7('Bucuresti');
END;
/