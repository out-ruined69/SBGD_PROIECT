CREATE TABLE AUTOR (
    id_autor NUMBER PRIMARY KEY,
    nume_autor varchar2(255) NOT NULL,
    data_nastere DATE NOT NULL, 
    data_deces DATE
);



CREATE TABLE EXPONAT (
	id_exponat NUMBER PRIMARY KEY,
	nume_exponat varchar2(255) NOT NULL, 
	data_publicare date,
	descriere varchar2(255)
);


CREATE TABLE COORDONATOR (
    id_coord NUMBER PRIMARY KEY,
	nume_coordonator varchar2(255) NOT NULL, 
    prenume_coordonator varchar2(255) NOT NULL, 
    numar_telefon varchar2(255) NOT NULL
);

CREATE TABLE ORAS(
    id_oras NUMBER PRIMARY KEY,
    nume_oras varchar2(255) NOT NULL,
    capitala NUMBER NOT NULL
    );
    
CREATE TABLE GALERIE(
     id_galerie NUMBER PRIMARY KEY,
     id_oras NUMBER,
     id_coord NUMBER,
     nume_galerie varchar2(255) NOT NULL,
     FOREIGN KEY (id_oras) REFERENCES ORAS(id_oras) ON DELETE SET NULL,
     FOREIGN KEY (id_coord) REFERENCES COORDONATOR(id_coord) ON DELETE SET NULL
    );
   
    
CREATE TABLE EVENIMENT (
    id_eveniment NUMBER PRIMARY KEY,
    id_galerie NUMBER,
    nume_eveniment VARCHAR2(255) NOT NULL,
    data_inceput date NOT NULL,
    data_final date NOT NULL,
    FOREIGN KEY (id_galerie) REFERENCES GALERIE(id_galerie) ON DELETE SET NULL 
);

CREATE TABLE SPONSOR(
    id_sponsor NUMBER PRIMARY KEY,
    nume_sponsor VARCHAR2(255) NOT NULL
);


CREATE TABLE STAFF(
    id_staff NUMBER PRIMARY KEY,
    nume_echipa VARCHAR2(255),
    rol_staff VARCHAR2(255)
);


CREATE TABLE ANGAJAT(
    id_angajat NUMBER PRIMARY KEY,
    nume_angajat VARCHAR2(255) NOT NULL,
    prenume_angajat VARCHAR2(255) NOT NULL,
    data_nastere DATE NOT NULL,
    salariu NUMBER NOT NULL,
    CNP VARCHAR2(255) NOT NULL,
    id_staff NUMBER,
    FOREIGN KEY (id_staff) REFERENCES STAFF(id_staff) ON DELETE SET NULL   
);

CREATE TABLE EVENIMENT_STAFF_MAPPING(
    id_staff NUMBER,
    id_eveniment NUMBER,
    PRIMARY KEY(id_staff,id_eveniment),
    FOREIGN KEY (id_staff) REFERENCES STAFF(id_staff) ON DELETE SET NULL,
    FOREIGN KEY (id_eveniment) REFERENCES EVENIMENT(id_eveniment) ON DELETE SET NULL
);

CREATE TABLE EXPONAT_AUTOR_MAPPING(
    id_autor NUMBER,
    id_exponat NUMBER,
    PRIMARY KEY(id_autor,id_exponat),
    FOREIGN KEY (id_autor) REFERENCES AUTOR(id_autor) ON DELETE SET NULL,
    FOREIGN KEY (id_exponat) REFERENCES EXPONAT(id_exponat) ON DELETE SET NULL
);

CREATE TABLE GALERIE_SPONSOR_MAPPING(
    id_galerie NUMBER,
    id_sponsor NUMBER,
    donatie NUMBER not null,
    PRIMARY KEY (id_galerie, id_sponsor),
    FOREIGN KEY (id_galerie) REFERENCES GALERIE(id_galerie) ON DELETE SET NULL,
    FOREIGN KEY (id_sponsor) REFERENCES SPONSOR(id_sponsor) ON DELETE SET NULL 
);

CREATE TABLE EXPONAT_EVENIMENT_MAPPING(
    id_eveniment NUMBER,
    id_exponat NUMBER,
    PRIMARY KEY(id_eveniment,id_exponat),
    FOREIGN KEY (id_eveniment) REFERENCES EVENIMENT(id_eveniment) ON DELETE SET NULL,
    FOREIGN KEY (id_exponat) REFERENCES EXPONAT(id_exponat) ON DELETE SET NULL
);

insert into SPONSOR (id_sponsor, nume_sponsor) values (1, 'Skimia');
insert into SPONSOR (id_sponsor, nume_sponsor) values (2, 'Plajo');
insert into SPONSOR (id_sponsor, nume_sponsor) values (3, 'Voolia');
insert into SPONSOR (id_sponsor, nume_sponsor) values (4, 'Topicblab');
insert into SPONSOR (id_sponsor, nume_sponsor) values (5, 'Riffwire');

select * from sponsor

insert into AUTOR (id_autor, nume_autor, data_nastere, data_deces) values (1, 'Van Gogh', '13-09-1951', '06-10-1984');
insert into AUTOR (id_autor, nume_autor, data_nastere, data_deces) values (2, 'Picasso', '28-11-1991', NULL);
insert into AUTOR (id_autor, nume_autor, data_nastere, data_deces) values (3, 'Castelli', '18-06-1985', '19-12-2009');
insert into AUTOR (id_autor, nume_autor, data_nastere, data_deces) values (4, 'Carolynn', '29-08-1989', NULL);
insert into AUTOR (id_autor, nume_autor, data_nastere, data_deces) values (5, 'Da Vinci', '05-03-1975', '13-10-2018');
insert into AUTOR (id_autor, nume_autor, data_nastere, data_deces) values (6, 'Chell', '17-07-1960', NULL);

SELECT * FROM AUTOR

insert into COORDONATOR (id_coord, nume_coordonator, prenume_coordonator, numar_telefon) values (1, 'des Remedios', 'Milty', '661 355 2788');
insert into COORDONATOR (id_coord, nume_coordonator, prenume_coordonator, numar_telefon) values (2, 'Howsden', 'Hannis', '851 662 1805');
insert into COORDONATOR (id_coord, nume_coordonator, prenume_coordonator, numar_telefon) values (3, 'Byforth', 'Hy', '302 853 4191');
insert into COORDONATOR (id_coord, nume_coordonator, prenume_coordonator, numar_telefon) values (4, 'Folley', 'Xerxes', '888 630 2960');
insert into COORDONATOR (id_coord, nume_coordonator, prenume_coordonator, numar_telefon) values (5, 'Broadis', 'Renado', '215 129 8433');

SELECT * FROM COORDONATOR

insert into STAFF (id_staff, nume_echipa, rol_staff) values (1, 'Fotografii', 'fotografie');
insert into STAFF (id_staff, nume_echipa, rol_staff) values (2, 'Bucatarii', 'catering');
insert into STAFF (id_staff, nume_echipa, rol_staff) values (3, 'Luminatii', 'lumini');
insert into STAFF (id_staff, nume_echipa, rol_staff) values (4, 'Masinele', 'transport');
insert into STAFF (id_staff, nume_echipa, rol_staff) values (5, 'Gardienii', 'body-guards');

SELECT * FROM STAFF

insert into ANGAJAT (id_angajat, nume_angajat, prenume_angajat, data_nastere, salariu, CNP, id_staff) values (1, 'Rudderham', 'Alli', '19-08-2001', 1567, '561017087225946895', 1);
insert into ANGAJAT (id_angajat, nume_angajat, prenume_angajat, data_nastere, salariu, CNP, id_staff) values (2, 'Jurges', 'Lynette', '21-12-1982', 2270, '3561813473931435', 1);
insert into ANGAJAT (id_angajat, nume_angajat, prenume_angajat, data_nastere, salariu, CNP, id_staff) values (3, 'McCulley', 'Hendrick', '21-11-1979', 2780, '4026616165983581', 1);
insert into ANGAJAT (id_angajat, nume_angajat, prenume_angajat, data_nastere, salariu, CNP, id_staff) values (4, 'Neumann', 'Aloysius', '05-09-1998', 4882, '3570830634142362', 2);
insert into ANGAJAT (id_angajat, nume_angajat, prenume_angajat, data_nastere, salariu, CNP, id_staff) values (5, 'Murfin', 'Constantin', '29-09-1980', 2748, '5303845895843085', 2);
insert into ANGAJAT (id_angajat, nume_angajat, prenume_angajat, data_nastere, salariu, CNP, id_staff) values (6, 'Colville', 'Solly', '07-01-1971', 2176, '63040369063298219', 2);
insert into ANGAJAT (id_angajat, nume_angajat, prenume_angajat, data_nastere, salariu, CNP, id_staff) values (7, 'McGettrick', 'Jeddy', '11-03-1976', 4400, '5602245404939466', 2);
insert into ANGAJAT (id_angajat, nume_angajat, prenume_angajat, data_nastere, salariu, CNP, id_staff) values (8, 'Christescu', 'Steven', '23-01-1967', 4565, '36532667146898', 2);
insert into ANGAJAT (id_angajat, nume_angajat, prenume_angajat, data_nastere, salariu, CNP, id_staff) values (9, 'Farrens', 'Vasili', '04-04-1967', 2156, '3539528611653019', 3);
insert into ANGAJAT (id_angajat, nume_angajat, prenume_angajat, data_nastere, salariu, CNP, id_staff) values (10, 'Christescu', 'Hobey', '09-06-1984', 3580, '560223844255436250', 3);
insert into ANGAJAT (id_angajat, nume_angajat, prenume_angajat, data_nastere, salariu, CNP, id_staff) values (11, 'Myall', 'Denni', '18-11-1970', 2161, '3564352220627936', 3);
insert into ANGAJAT (id_angajat, nume_angajat, prenume_angajat, data_nastere, salariu, CNP, id_staff) values (12, 'Greenlies', 'Eugen', '24-01-1999', 3629, '5610695640397392', 4);
insert into ANGAJAT (id_angajat, nume_angajat, prenume_angajat, data_nastere, salariu, CNP, id_staff) values (13, 'Neeson', 'Weider', '07-01-1988', 2207, '3576378139687378', 4);
insert into ANGAJAT (id_angajat, nume_angajat, prenume_angajat, data_nastere, salariu, CNP, id_staff) values (14, 'Comini', 'Deny', '16-03-1981', 4107, '5602233476673742', 4);
insert into ANGAJAT (id_angajat, nume_angajat, prenume_angajat, data_nastere, salariu, CNP, id_staff) values (15, 'Burrell', 'Felicle', '28-10-1985', 2193, '3549037879008427', 4);
insert into ANGAJAT (id_angajat, nume_angajat, prenume_angajat, data_nastere, salariu, CNP, id_staff) values (16, 'Badland', 'Lek', '11-01-1972', 3288, '3574996911389939', 5);
insert into ANGAJAT (id_angajat, nume_angajat, prenume_angajat, data_nastere, salariu, CNP, id_staff) values (17, 'Canete', 'Bebe', '04-11-1985', 2671, '633424762069417930', 5);
insert into ANGAJAT (id_angajat, nume_angajat, prenume_angajat, data_nastere, salariu, CNP, id_staff) values (18, 'Christofle', 'Tremayne', '05-01-2001', 3694, '4508859506024551', 3);
insert into ANGAJAT (id_angajat, nume_angajat, prenume_angajat, data_nastere, salariu, CNP, id_staff) values (19, 'Heeron', 'Mechelle', '11-07-1997', 2452, '4844780974268905', null);
insert into ANGAJAT (id_angajat, nume_angajat, prenume_angajat, data_nastere, salariu, CNP, id_staff) values (20, 'Spaight', 'Lilah', '27-05-1997', 4107, '3578494216089996', null);

SELECT * FROM ANGAJAT

SELECT * FROM AUTOR

insert into EXPONAT (id_EXPONAT, nume_exponat, data_publicare, descriere) values (1, 'OXYCODONE', '30/9/2013', 'Digitized explicit parallelism');
insert into EXPONAT (id_EXPONAT, nume_exponat, data_publicare, descriere) values (2, 'Starry Night', '6/7/2007', 'Synergistic heuristic adapter');
insert into EXPONAT (id_EXPONAT, nume_exponat, data_publicare, descriere) values (3, 'MORUS', '2/7/1999', 'Right-sized mobile service-desk');
insert into EXPONAT (id_EXPONAT, nume_exponat, data_publicare, descriere) values (4, 'Plus', '7/5/2002', 'User-centric zero tolerance parallelism');
insert into EXPONAT (id_EXPONAT, nume_exponat, data_publicare, descriere) values (5, 'anti', '5/12/2022', 'Front-line content-based success');
insert into EXPONAT (id_EXPONAT, nume_exponat, data_publicare, descriere) values (6, 'Metronidazole', null, 'Total empowering strategy');
insert into EXPONAT (id_EXPONAT, nume_exponat, data_publicare, descriere) values (7, 'PROMETHAZINE', '7/12/2001', 'Enhanced tertiary process improvement');
insert into EXPONAT (id_EXPONAT, nume_exponat, data_publicare, descriere) values (8, 'Anti Itch', null, 'Total fresh-thinking project');
insert into EXPONAT (id_EXPONAT, nume_exponat, data_publicare, descriere) values (9, 'Peisaj', '28/2/2002', 'Ergonomic global intranet');
insert into EXPONAT (id_EXPONAT, nume_exponat, data_publicare, descriere) values (10, 'PrePost', '10/10/2008', 'Switchable composite array');
insert into EXPONAT (id_EXPONAT, nume_exponat, data_publicare, descriere) values (11, 'Cedar Elm', '12/3/1998', 'Persevering fresh-thinking throughput');
insert into EXPONAT (id_EXPONAT, nume_exponat, data_publicare, descriere) values (12, 'Sleep Aid', '24/6/1995', null);
insert into EXPONAT (id_EXPONAT, nume_exponat, data_publicare, descriere) values (13, 'HONIBE', '11/11/2007', null);
insert into EXPONAT (id_EXPONAT, nume_exponat, data_publicare, descriere) values (14, 'METHYLIN', null, 'Expanded local neural-net');
insert into EXPONAT (id_EXPONAT, nume_exponat, data_publicare, descriere) values (15, 'Volcano', '26/8/2008', null);

select * from exponat

insert into ORAS (id_oras, nume_oras, capitala) values (1, 'Paris', 1);
insert into ORAS (id_oras, nume_oras, capitala) values (2, 'Porto Ferreira', 0);
insert into ORAS (id_oras, nume_oras, capitala) values (3, 'New York', 0);
insert into ORAS (id_oras, nume_oras, capitala) values (4, 'Tr Vinh', 0);
insert into ORAS (id_oras, nume_oras, capitala) values (5, 'Bucuresti', 1);

insert into galerie (id_galerie, id_oras, id_coord, nume_galerie) values (1, 1, 1, 'Primavera');
insert into galerie (id_galerie, id_oras, id_coord, nume_galerie) values (2, 2, 2, 'The Best');
insert into galerie (id_galerie, id_oras, id_coord, nume_galerie) values (3, 3, 3, 'Aperture');
insert into galerie (id_galerie, id_oras, id_coord, nume_galerie) values (4, 4, 4, 'Salt Mines');
insert into galerie (id_galerie, id_oras, id_coord, nume_galerie) values (5, 5, 5, 'Mechanical');
insert into galerie (id_galerie, id_oras, id_coord, nume_galerie) values (6, 1, 5, 'Quirkcy');
insert into galerie (id_galerie, id_oras, id_coord, nume_galerie) values (7, 5, 4, 'Blck Mesa');

SELECT * FROM GALERIE

SELECT NUME_GALERIE, NUME_COORDONATOR, NUME_ORAS
FROM GALERIE
INNER JOIN COORDONATOR ON COORDONATOR.ID_COORD = GALERIE.ID_COORD
INNER JOIN ORAS ON ORAS.ID_ORAS = GALERIE.ID_ORAS

insert into EVENIMENT (id_eveniment, id_galerie, nume_eveniment, data_inceput, data_final) values (1, 1, 'Latlux', '12/06/2014', '24/07/2014');
insert into EVENIMENT (id_eveniment, id_galerie, nume_eveniment, data_inceput, data_final) values (2, 1, 'Quo Lux', '24/03/2012', '11/04/2012');
insert into EVENIMENT (id_eveniment, id_galerie, nume_eveniment, data_inceput, data_final) values (3, 2, 'Prodder', '22/02/2012', '16/03/2012');
insert into EVENIMENT (id_eveniment, id_galerie, nume_eveniment, data_inceput, data_final) values (4, 2, 'Flowdesk', '02/08/2014', '24/08/2014');
insert into EVENIMENT (id_eveniment, id_galerie, nume_eveniment, data_inceput, data_final) values (5, 2, 'Greenlam', '02/02/2018', '12/02/2018');
insert into EVENIMENT (id_eveniment, id_galerie, nume_eveniment, data_inceput, data_final) values (6, 3, 'Latlux', '31/07/2013', '12/08/2013');
insert into EVENIMENT (id_eveniment, id_galerie, nume_eveniment, data_inceput, data_final) values (7, 3, 'Fix San', '07/07/2020', '29/10/2020');
insert into EVENIMENT (id_eveniment, id_galerie, nume_eveniment, data_inceput, data_final) values (8, 4, 'Ventosanzap', '06/01/2019', '11/01/2019');
insert into EVENIMENT (id_eveniment, id_galerie, nume_eveniment, data_inceput, data_final) values (9, 4, 'Job', '19/06/2021', '01/07/2021');
insert into EVENIMENT (id_eveniment, id_galerie, nume_eveniment, data_inceput, data_final) values (10, 4, 'Stim', '20/01/2016', '15/02/2016');
insert into EVENIMENT (id_eveniment, id_galerie, nume_eveniment, data_inceput, data_final) values (11, 4, 'Konklab', '29/06/2018', '09/07/2019');
insert into EVENIMENT (id_eveniment, id_galerie, nume_eveniment, data_inceput, data_final) values (12, 5, 'Domainer', '03/01/2015', '06/04/2015');
insert into EVENIMENT (id_eveniment, id_galerie, nume_eveniment, data_inceput, data_final) values (13, 5, 'Fix San', '4/08/2014', '13/08/2014');
insert into EVENIMENT (id_eveniment, id_galerie, nume_eveniment, data_inceput, data_final) values (14, 6, 'Namfix', '12/06/2015', '27/09/2015');
insert into EVENIMENT (id_eveniment, id_galerie, nume_eveniment, data_inceput, data_final) values (15, 7, 'Subin', '09/09/2015', '27/12/2015');
insert into EVENIMENT (id_eveniment, id_galerie, nume_eveniment, data_inceput, data_final) values (16, 7, 'Y-Solowarm', '09/04/2019', '29/07/2019');
insert into EVENIMENT (id_eveniment, id_galerie, nume_eveniment, data_inceput, data_final) values (17, 7, 'Pannier', '30/07/2021', '31/08/2021');

SELECT * FROM galerie

SELECT * FROM SPONSOR

INSERT INTO GALERIE_SPONSOR_MAPPING (id_galerie, id_sponsor, donatie) values (1, 1, 10000);
INSERT INTO GALERIE_SPONSOR_MAPPING (id_galerie, id_sponsor, donatie) values (1, 2, 7000);
INSERT INTO GALERIE_SPONSOR_MAPPING (id_galerie, id_sponsor, donatie) values (2, 1, 14000);
INSERT INTO GALERIE_SPONSOR_MAPPING (id_galerie, id_sponsor, donatie) values (2, 3, 20000);
INSERT INTO GALERIE_SPONSOR_MAPPING (id_galerie, id_sponsor, donatie) values (2, 4, 5000);
INSERT INTO GALERIE_SPONSOR_MAPPING (id_galerie, id_sponsor, donatie) values (3, 5, 2000);
INSERT INTO GALERIE_SPONSOR_MAPPING (id_galerie, id_sponsor, donatie) values (3, 1, 5700);
INSERT INTO GALERIE_SPONSOR_MAPPING (id_galerie, id_sponsor, donatie) values (4, 1, 8000);
INSERT INTO GALERIE_SPONSOR_MAPPING (id_galerie, id_sponsor, donatie) values (5, 2, 9000);
INSERT INTO GALERIE_SPONSOR_MAPPING (id_galerie, id_sponsor, donatie) values (5, 1, 400);
INSERT INTO GALERIE_SPONSOR_MAPPING (id_galerie, id_sponsor, donatie) values (6, 3, 6000);
INSERT INTO GALERIE_SPONSOR_MAPPING (id_galerie, id_sponsor, donatie) values (6, 4, 900);
INSERT INTO GALERIE_SPONSOR_MAPPING (id_galerie, id_sponsor, donatie) values (6, 5, 6000);
INSERT INTO GALERIE_SPONSOR_MAPPING (id_galerie, id_sponsor, donatie) values (6, 3, 4000);
INSERT INTO GALERIE_SPONSOR_MAPPING (id_galerie, id_sponsor, donatie) values (1, 3, 1000);

DELETE FROM GALERIE_SPONSOR_MAPPING WHERE id_galerie = 7

select * from GALERIE_SPONSOR_MAPPING

SELECT NUME_GALERIE, NUME_SPONSOR, DONATIE FROM GALERIE_SPONSOR_MAPPING
INNER JOIN GALERIE ON GALERIE.id_galerie = GALERIE_SPONSOR_MAPPING.id_galerie
INNER JOIN SPONSOR ON SPONSOR.id_sponsor = GALERIE_SPONSOR_MAPPING.id_sponsor

SELECT * FROM EVENIMENT



SELECT * FROM EXPONAT

insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (7, 4);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (1, 11);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (5, 1);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (5, 6);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (6, 6);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (7, 4);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (13, 11);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (6, 5);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (2, 13);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (14, 4);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (13, 2);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (5, 2);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (17, 3);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (7, 5);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (13, 7);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (7, 4);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (3, 8);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (8, 7);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (12, 9);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (5, 13);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (4, 3);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (4, 10);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (2, 6);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (11, 6);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (4, 12);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (14, 1);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (1, 8);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (15, 13);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (2, 1);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (15, 6);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (14, 11);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (12, 14);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (2, 4);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (12, 3);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (8, 1);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (10, 4);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (14, 5);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (4, 6);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (6, 11);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (3, 2);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (2, 10);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (7, 1);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (13, 8);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (14, 9);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (13, 9);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (14, 5);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (9, 8);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (6, 11);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (17, 2);
insert into EXPONAT_EVENIMENT_MAPPING (id_eveniment, id_EXPONAT) values (16, 13);


SELECT NUME_EXPONAT, NUME_EVENIMENT FROM EXPONAT_EVENIMENT_MAPPING
INNER JOIN EXPONAT ON EXPONAT.ID_EXPONAT = EXPONAT_EVENIMENT_MAPPING.ID_EXPONAT
INNER JOIN EVENIMENT ON EVENIMENT.ID_EVENIMENT = EXPONAT_EVENIMENT_MAPPING.ID_EVENIMENT

select * from exponat

insert into EXPONAT_AUTOR_MAPPING(id_autor, id_exponat) values (1,1);
insert into EXPONAT_AUTOR_MAPPING(id_autor, id_exponat) values (2,5);
insert into EXPONAT_AUTOR_MAPPING(id_autor, id_exponat) values (3,6);
insert into EXPONAT_AUTOR_MAPPING(id_autor, id_exponat) values (4,6);
insert into EXPONAT_AUTOR_MAPPING(id_autor, id_exponat) values (5,2);
insert into EXPONAT_AUTOR_MAPPING(id_autor, id_exponat) values (6,3);
insert into EXPONAT_AUTOR_MAPPING(id_autor, id_exponat) values (7,1);
insert into EXPONAT_AUTOR_MAPPING(id_autor, id_exponat) values (8,4);
insert into EXPONAT_AUTOR_MAPPING(id_autor, id_exponat) values (9,4);
insert into EXPONAT_AUTOR_MAPPING(id_autor, id_exponat) values (10,2);

insert into EXPONAT_AUTOR_MAPPING(id_autor, id_exponat) values (2,11);
insert into EXPONAT_AUTOR_MAPPING(id_autor, id_exponat) values (2,12);
insert into EXPONAT_AUTOR_MAPPING(id_autor, id_exponat) values (3,12);
insert into EXPONAT_AUTOR_MAPPING(id_autor, id_exponat) values (4,12);
insert into EXPONAT_AUTOR_MAPPING(id_autor, id_exponat) values (4,13);
insert into EXPONAT_AUTOR_MAPPING(id_autor, id_exponat) values (6,13);
insert into EXPONAT_AUTOR_MAPPING(id_autor, id_exponat) values (5,14);
insert into EXPONAT_AUTOR_MAPPING(id_autor, id_exponat) values (2,14);
insert into EXPONAT_AUTOR_MAPPING(id_autor, id_exponat) values (5,15);
insert into EXPONAT_AUTOR_MAPPING(id_autor, id_exponat) values (3,15);

SELECT * FROM EXPONAT


select * from AUTOR
SELECT * FROM EXPONAT

select eam.id_autor from EXPONAT_AUTOR_MAPPING eam


select * from eveniment
select * from staff

insert into EVENIMENT_STAFF_MAPPING (id_eveniment, id_staff) values (1, 2);
insert into EVENIMENT_STAFF_MAPPING (id_eveniment, id_staff) values (1, 4);
insert into EVENIMENT_STAFF_MAPPING (id_eveniment, id_staff) values (10, 3);
insert into EVENIMENT_STAFF_MAPPING (id_eveniment, id_staff) values (11, 1);
insert into EVENIMENT_STAFF_MAPPING (id_eveniment, id_staff) values (11, 2);
insert into EVENIMENT_STAFF_MAPPING (id_eveniment, id_staff) values (12, 1);
insert into EVENIMENT_STAFF_MAPPING (id_eveniment, id_staff) values (12, 1);
insert into EVENIMENT_STAFF_MAPPING (id_eveniment, id_staff) values (13, 2);
insert into EVENIMENT_STAFF_MAPPING (id_eveniment, id_staff) values (13, 3);
insert into EVENIMENT_STAFF_MAPPING (id_eveniment, id_staff) values (14, 1);
insert into EVENIMENT_STAFF_MAPPING (id_eveniment, id_staff) values (14, 2);
insert into EVENIMENT_STAFF_MAPPING (id_eveniment, id_staff) values (14, 3);
insert into EVENIMENT_STAFF_MAPPING (id_eveniment, id_staff) values (14, 4);
insert into EVENIMENT_STAFF_MAPPING (id_eveniment, id_staff) values (15, 2);
insert into EVENIMENT_STAFF_MAPPING (id_eveniment, id_staff) values (15, 3);
insert into EVENIMENT_STAFF_MAPPING (id_eveniment, id_staff) values (15, 4);
insert into EVENIMENT_STAFF_MAPPING (id_eveniment, id_staff) values (17, 1);
insert into EVENIMENT_STAFF_MAPPING (id_eveniment, id_staff) values (17, 4);
insert into EVENIMENT_STAFF_MAPPING (id_eveniment, id_staff) values (17, 5);
insert into EVENIMENT_STAFF_MAPPING (id_eveniment, id_staff) values (2, 3);
insert into EVENIMENT_STAFF_MAPPING (id_eveniment, id_staff) values (3, 2);
insert into EVENIMENT_STAFF_MAPPING (id_eveniment, id_staff) values (4, 1);
insert into EVENIMENT_STAFF_MAPPING (id_eveniment, id_staff) values (4, 2);
insert into EVENIMENT_STAFF_MAPPING (id_eveniment, id_staff) values (4, 4);
insert into EVENIMENT_STAFF_MAPPING (id_eveniment, id_staff) values (4, 5);
insert into EVENIMENT_STAFF_MAPPING (id_eveniment, id_staff) values (5, 1);
insert into EVENIMENT_STAFF_MAPPING (id_eveniment, id_staff) values (5, 2);
insert into EVENIMENT_STAFF_MAPPING (id_eveniment, id_staff) values (5, 4);
insert into EVENIMENT_STAFF_MAPPING (id_eveniment, id_staff) values (6, 3);
insert into EVENIMENT_STAFF_MAPPING (id_eveniment, id_staff) values (6, 5);
insert into EVENIMENT_STAFF_MAPPING (id_eveniment, id_staff) values (7, 1);
insert into EVENIMENT_STAFF_MAPPING (id_eveniment, id_staff) values (8, 1);
insert into EVENIMENT_STAFF_MAPPING (id_eveniment, id_staff) values (8, 4);
insert into EVENIMENT_STAFF_MAPPING (id_eveniment, id_staff) values (9, 1);
insert into EVENIMENT_STAFF_MAPPING (id_eveniment, id_staff) values (9, 3);
insert into EVENIMENT_STAFF_MAPPING (id_eveniment, id_staff) values (9, 4);
insert into EVENIMENT_STAFF_MAPPING (id_eveniment, id_staff) values (9, 5);

select e.nume_eveniment, s.nume_echipa from EVENIMENT_STAFF_MAPPING esm 
inner join staff s on s.id_staff = esm.id_staff
inner join eveniment e on e.id_eveniment = esm.id_eveniment







