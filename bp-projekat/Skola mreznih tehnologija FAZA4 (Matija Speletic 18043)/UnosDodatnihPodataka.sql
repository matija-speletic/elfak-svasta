--Dodavanje nekoliko podataka kako bi pojedini upiti dali tabele koje nisu prazne

INSERT INTO POLAZNIK (JMBG, IME, PREZIME, E_MAIL, BROJ_TELEFONA, OPSTINA, ULICA, BROJ ) VALUES (1510000120056, 'Mihajlo', 'Stefanovic', 'mixasteva@gmail.com','064/222-7487',NULL, NULL, NULL);
INSERT INTO POLAZNIK (JMBG, IME, PREZIME, E_MAIL, BROJ_TELEFONA, OPSTINA, ULICA, BROJ ) VALUES (2511000789654, 'Stefana', 'Todorovic', 'stefi@gmail.com','061/3482-587','Palilula',NULL, NULL);
INSERT INTO POLAZNIK (JMBG, IME, PREZIME, E_MAIL, BROJ_TELEFONA, OPSTINA, ULICA, BROJ ) VALUES (0207009427657, 'Stevan', 'Zivkovic', 'steeeev@gmail.com','063/6727-954',NULL, NULL, NULL);
INSERT INTO POLAZNIK (JMBG, IME, PREZIME, E_MAIL, BROJ_TELEFONA, OPSTINA, ULICA, BROJ ) VALUES (0205001375497, 'Teodora', 'Dincic', 'teks@gmail.com','065/277-9754',NULL, NULL, NULL);

INSERT INTO POHADJA (ID_KURSA, JMBG_POLAZNIKA, DAT_UPISA, POPUST) VALUES (10, 1510000120056, '16-Sep-18', 0.0);
INSERT INTO POHADJA (ID_KURSA, JMBG_POLAZNIKA, DAT_UPISA, POPUST) VALUES (1, 2511000789654, '16-Sep-18', NULL);
INSERT INTO POHADJA (ID_KURSA, JMBG_POLAZNIKA, DAT_UPISA, POPUST) VALUES (2, 0205001375497, '16-Sep-18', 7.0);
INSERT INTO POHADJA (ID_KURSA, JMBG_POLAZNIKA, DAT_UPISA, POPUST) VALUES (9, 0207009427657, '16-Sep-18', NULL);
INSERT INTO POHADJA (ID_KURSA, JMBG_POLAZNIKA, DAT_UPISA, POPUST) VALUES (3, 2511000789654, '16-Sep-18', 3.0);
INSERT INTO POHADJA (ID_KURSA, JMBG_POLAZNIKA, DAT_UPISA, POPUST) VALUES (9, 1250136963327, '16-Sep-18', NULL);
INSERT INTO POHADJA (ID_KURSA, JMBG_POLAZNIKA, DAT_UPISA, POPUST) VALUES (7, 2974098070574, '16-Sep-18', 0.0);