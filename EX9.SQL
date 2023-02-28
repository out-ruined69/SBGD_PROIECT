--Sa se afiseze exponatele care se gasesc intr-un oras. Erorile care pot aparea sunt: nu exista orase cu acest
--nume, nu sunt exponate in oras si sunt mai multe orase cu acelasi nume
CREATE OR REPLACE PROCEDURE CERINT9(numeor oras.nume_oras%type)
AS
 TYPE tab_indx_exp IS TABLE OF EXPONAT%ROWTYPE INDEX BY PLS_INTEGER;
 exponate tab_indx_exp;

 TYPE tab_indx_orase IS TABLE OF ORAS%ROWTYPE INDEX BY PLS_INTEGER;
 orase tab_indx_orase;

 NO_DATA_FOUND_ORAS EXCEPTION;
 NO_DATA_FOUND_EXPONATE EXCEPTION;
 TOO_MANY_ROWS EXCEPTION;
BEGIN
 SELECT *
 BULK COLLECT INTO orase
 FROM oras
 WHERE UPPER(nume_oras) LIKE UPPER(numeor);


 IF SQL%NOTFOUND THEN
 RAISE NO_DATA_FOUND_ORAS;
 END IF;

 IF orase.count >=2 THEN
 RAISE TOO_MANY_ROWS;
 END IF;


 SELECT DISTINCT ex.id_exponat,ex.NUME_EXPONAT, ex.data_publicare, ex.descriere
 BULK COLLECT INTO exponate
 FROM ORAS o
 INNER JOIN GALERIE g on g.id_oras = o.id_oras
 inner join EVENIMENT ev on g.id_galerie = ev.id_galerie
 inner join EXPONAT_EVENIMENT_MAPPING eem on ev.id_eveniment = eem.id_eveniment
 inner join exponat ex on ex.id_exponat = eem.id_exponat
 inner join EXPONAT_AUTOR_MAPPING eam on eam.id_exponat=ex.id_exponat
 INNER join autor a on eam.id_autor = a.id_autor
 WHERE a.data_deces IS NULL AND nume_oras like numeor;
 --DBMS_OUTPUT.PUT_LINE(exponate.count);

 IF exponate.count = 0 THEN
 RAISE NO_DATA_FOUND_EXPONATE;
 END IF;

 DBMS_OUTPUT.PUT_LINE('In orasul '||numeor || ' sunt exponatele:');
 FOR i in exponate.first..exponate.last LOOP
 DBMS_OUTPUT.PUT_LINE(exponate(i).nume_exponat);
 END LOOP;
 EXCEPTION
 WHEN NO_DATA_FOUND_ORAS THEN
 DBMS_OUTPUT.PUT_LINE('Nu exista acest oras!');
 WHEN NO_DATA_FOUND_EXPONATE THEN
 DBMS_OUTPUT.PUT_LINE('Nu sunt astfel de exponate in oras!');
 WHEN TOO_MANY_ROWS THEN
 DBMS_OUTPUT.PUT_LINE('Exista mai multe orase cu acest nume!');
 WHEN OTHERS THEN
 DBMS_OUTPUT.PUT_LINE('Alta eroare!');

END;
/
BEGIN
 CERINT9('Paris');
 --CERINT9('Budapesta');
 --CERINT9('Constanta');
 --CERINT9('Husi');
END;