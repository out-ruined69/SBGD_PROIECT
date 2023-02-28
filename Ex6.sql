--Pentru o galerie sa se afiseze echipele staff care paticipa la un eveniment
CREATE OR REPLACE PROCEDURE CERINTA6 (numegale GALERIE.nume_galerie%type)
AS
 TYPE tab_indx IS TABLE OF EVENIMENT%ROWTYPE INDEX BY PLS_INTEGER;
 evenimente tab_indx;

 TYPE lista_nested IS TABLE OF STAFF%rowtype;
 aux_staff lista_nested := lista_nested();

 nr NUMBER;
 nr_staffs NUMBER;

BEGIN

 SELECT e.id_eveniment,e.id_galerie, e.nume_eveniment, e.data_inceput, e.data_final
 BULK COLLECT INTO evenimente
 FROM EVENIMENT e, GALERIE g
 WHERE e.id_galerie = g.id_galerie AND UPPER(g.nume_galerie) LIKE UPPER(numegale) ;

 SELECT COUNT(*)
 INTO nr
 FROM EVENIMENT e, GALERIE g
 WHERE e.id_galerie = g.id_galerie AND UPPER(g.nume_galerie) LIKE UPPER(numegale)
 GROUP BY g.id_galerie;

 DBMS_OUTPUT.PUT_LINE('Nr evenimente la galeria '|| numegale || ' ' || nr);

 FOR i in evenimente.first..evenimente.last LOOP
 SELECT s.id_staff, s.nume_echipa, s.rol_staff
 BULK COLLECT INTO aux_staff
 FROM EVENIMENT_STAFF_MAPPING esm, EVENIMENT e, STAFF s
 WHERE s.id_staff = esm.id_staff AND esm.id_eveniment = e.id_eveniment AND e.id_eveniment =
evenimente(i).id_eveniment;
 --DBMS_OUTPUT.PUT_LINE(aux_staff.count);
 nr_staffs := aux_staff.count;

 IF nr_staffs = 0 THEN
 DBMS_OUTPUT.PUT_LINE('Evenimentul nu are staffs!');
 END IF;

 IF nr_staffs >0 THEN
 DBMS_OUTPUT.PUT_LINE('Evenimentul ' || evenimente(i).nume_eveniment || ' a angajat ' || nr_staffs || ' echipe');
 FOR j in aux_staff .first..aux_staff.last LOOP
 DBMS_OUTPUT.PUT_LINE(aux_staff(j).nume_echipa);
 END LOOP;

 END IF;

 END LOOP;
END;
/
BEGIN
 CERINTA6('Primavera');
END;
/