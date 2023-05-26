--1. Spisak svih kurseva koji se ne odrzavaju u ucionicama na prizemlju
SELECT KURS.NAZIV, KURS.NIVO, UCIONICA.BROJ, UCIONICA.NAZIV
FROM KURS RIGHT OUTER JOIN UCIONICA ON KURS.BROJ_UCIONICE=UCIONICA.BROJ
MINUS  --razlika
SELECT KURS.NAZIV, KURS.NIVO, UCIONICA.BROJ, UCIONICA.NAZIV
FROM KURS RIGHT OUTER JOIN UCIONICA ON KURS.BROJ_UCIONICE=UCIONICA.BROJ
WHERE UCIONICA.SPRAT=0;
--upit ilustruje koriscenje desnog spoljasnjeg spoja i minus klauzule


--2. Spisak instruktora koji su zavrsili doktorske ili magistarske studije i njihovog e-maila
SELECT INSTRUKTOR.LIME, INSTRUKTOR.SSLOVO, INSTRUKTOR.PREZIME, E_MAIL_INSTRUKTORA.E_MAIL
FROM INSTRUKTOR LEFT OUTER JOIN E_MAIL_INSTRUKTORA ON INSTRUKTOR.ID_BROJ=E_MAIL_INSTRUKTORA.ID_INSTRUKTORA
WHERE INSTRUKTOR.ST_SPREMA='doktorat'
UNION  --unija
SELECT INSTRUKTOR.LIME, INSTRUKTOR.SSLOVO, INSTRUKTOR.PREZIME, E_MAIL_INSTRUKTORA.E_MAIL
FROM INSTRUKTOR, E_MAIL_INSTRUKTORA
WHERE INSTRUKTOR.ID_BROJ=E_MAIL_INSTRUKTORA.ID_INSTRUKTORA(+) --alternativna sintaksa 
AND INSTRUKTOR.ST_SPREMA='magistar';
--upit ilustruje koriscenje levog spoljasnjeg spoja i union klauzule



--3. Spisak svih instruktora koji imaju zavrsene osnovne akademske studije i polaznika kojima oni predaju 
SELECT DISTINCT INSTRUKTOR.LIME, INSTRUKTOR.SSLOVO, INSTRUKTOR.PREZIME, POLAZNIK.IME, POLAZNIK.PREZIME
FROM (SELECT PREDAJE.ID_INSTRUKTORA, POHADJA.JMBG_POLAZNIKA --ugnjezdeni nekorelisani upit
      FROM POHADJA INNER JOIN PREDAJE
      ON POHADJA.ID_KURSA=PREDAJE.ID_KURSA) 
INNER JOIN INSTRUKTOR ON ID_INSTRUKTORA=INSTRUKTOR.ID_BROJ
INNER JOIN POLAZNIK ON JMBG_POLAZNIKA=POLAZNIK.JMBG
WHERE INSTRUKTOR.ST_SPREMA='osnovne akademske'
ORDER BY INSTRUKTOR.LIME,INSTRUKTOR.SSLOVO, INSTRUKTOR.PREZIME;

--alternativa (bez koriscenja ugnjezdenih upita)
SELECT DISTINCT INSTRUKTOR.LIME, INSTRUKTOR.SSLOVO, INSTRUKTOR.PREZIME, POLAZNIK.IME, POLAZNIK.PREZIME
FROM INSTRUKTOR, PREDAJE, POHADJA, POLAZNIK
WHERE INSTRUKTOR.ID_BROJ=PREDAJE.ID_INSTRUKTORA 
      AND POLAZNIK.JMBG=POHADJA.JMBG_POLAZNIKA 
      AND PREDAJE.ID_KURSA=POHADJA.ID_KURSA
      AND INSTRUKTOR.ST_SPREMA='osnovne akademske'
ORDER BY INSTRUKTOR.LIME,INSTRUKTOR.SSLOVO, INSTRUKTOR.PREZIME;



--4. Spisak instruktora koji predaju Cisco kurseve
SELECT DISTINCT INSTRUKTOR.LIME, INSTRUKTOR.SSLOVO, INSTRUKTOR.PREZIME
FROM INSTRUKTOR INNER JOIN PREDAJE ON INSTRUKTOR.ID_BROJ=PREDAJE.ID_INSTRUKTORA
WHERE PREDAJE.ID_KURSA IN (SELECT KURS.ID_BROJ --ugnjezdeni nekorelisani upit
                           FROM KURS,PREDAJE   --u kombinaciji sa IN
                           WHERE KURS.ID_BROJ=PREDAJE.ID_KURSA
                               AND LOWER(KURS.NAZIV) LIKE '%cisco%'
                               AND LOWER(KURS.NIVO) LIKE '%ccna%');
	  


--5. Spisak ucionica koje sadrze i servere i rutere
SELECT BROJ, NAZIV
FROM UCIONICA
WHERE EXISTS (SELECT 0 --ugnjezdeni korelisani upit
			  FROM DODATNA_OPREMA
			  WHERE BROJ=DODATNA_OPREMA.BROJ_UCIONICE
				    AND TIP='server')
INTERSECT --presek
SELECT BROJ, NAZIV
FROM UCIONICA
WHERE EXISTS (SELECT 0 --ugnjezdeni korelisani upit
			  FROM DODATNA_OPREMA
			  WHERE BROJ=DODATNA_OPREMA.BROJ_UCIONICE
				    AND TIP='router');
					
					

--6. Spisak svih polaznika i njihovog zaduzenja (zbir cena svih kurseva koje pohadjaju sa uracunatim popustom)
SELECT POLAZNIK.IME, POLAZNIK.PREZIME, SUM(CENA*(1-NVL(POPUST,0)/100)) AS ZADUZENJE 
FROM KURS,POHADJA,POLAZNIK
WHERE POLAZNIK.JMBG=POHADJA.JMBG_POLAZNIKA 
      AND POHADJA.ID_KURSA=KURS.ID_BROJ
GROUP BY POLAZNIK.IME, POLAZNIK.PREZIME
ORDER BY ZADUZENJE DESC; --uredjen po zaduzenju
--ovaj upit ilustruje koriscenje funkcija agregacije u kombinaciji sa aritmetickim operetorima
--uz koriscenje GROUP BY
--NAPOMENA: NVL(POPUST,0) sluzi da na mestima gde je popust null uzima da je popust 0



--7. Spisak svih instruktora koji drze isti broj kurseva kao i Ognjen Ivanovic
SELECT INSTRUKTOR.LIME,INSTRUKTOR.SSLOVO,INSTRUKTOR.PREZIME, COUNT(*) AS BROJ_KURSEVA
FROM INSTRUKTOR INNER JOIN PREDAJE ON INSTRUKTOR.ID_BROJ=PREDAJE.ID_INSTRUKTORA
WHERE INSTRUKTOR.LIME<>'Ognjen' AND INSTRUKTOR.PREZIME<>'Ivanovic'
GROUP BY INSTRUKTOR.LIME,INSTRUKTOR.SSLOVO,INSTRUKTOR.PREZIME
HAVING COUNT(*)=(SELECT COUNT(*) FROM INSTRUKTOR JOIN PREDAJE 
                 ON INSTRUKTOR.ID_BROJ=PREDAJE.ID_INSTRUKTORA
                 WHERE INSTRUKTOR.LIME='Ognjen' AND INSTRUKTOR.PREZIME='Ivanovic');
--ovaj upit ilustruje koriscenje kombinacije funkcija agregacije sa uz upotrebu
--GROUP BY i HAVING u kombinaciji sa nekorelisanim ugnjezdenim upitom



--8. Pronaci ucionicu sa najvise dodatne opreme
--prvi nacin - prikazuje se samo jednu ucionicu sa najvise dodatne opreme
SELECT * FROM(
    SELECT NAZIV, BROJ, COUNT(*) AS BR_DOD_OP
    FROM UCIONICA JOIN DODATNA_OPREMA ON DODATNA_OPREMA.BROJ_UCIONICE=UCIONICA.BROJ
    GROUP BY NAZIV, BROJ
    ORDER BY BR_DOD_OP DESC)
WHERE ROWNUM=1;--uzimanje prve vrste rezultata ugnjezdenog upita

--drugi nacin - prikazuju se sve ucionice koje imaju najvise dodatne opreme (ukoliko ih ima vise)
SELECT NAZIV, BROJ, COUNT(*) AS BR_DOD_OP
FROM UCIONICA JOIN DODATNA_OPREMA ON DODATNA_OPREMA.BROJ_UCIONICE=UCIONICA.BROJ
GROUP BY NAZIV, BROJ
HAVING COUNT(*)=(SELECT MAX(COUNT(*)) FROM DODATNA_OPREMA GROUP BY BROJ_UCIONICE);
--iskoriscen je ugnjezdeni nekorelisani upit i funkcije agregacije MAX i COUNT



--9. Pronaci kurseve sa relativno velikim brojem polaznika (broj polaznika koji je iznad proseka)
SELECT KURS.ID_BROJ, KURS.NAZIV, KURS.NIVO, COUNT(*) AS BROJ_POLAZNIKA
FROM KURS INNER JOIN POHADJA ON KURS.ID_BROJ=POHADJA.ID_KURSA
GROUP BY KURS.ID_BROJ, KURS.NAZIV, KURS.NIVO
HAVING COUNT(*)>(SELECT AVG(COUNT(*)) FROM POHADJA GROUP BY ID_KURSA);
--iskoriscen je ugnjezdeni nekorelisani upit i funkcije agregacije AVG i COUNT



--10. Spisak dodatne opreme koja se nalazi u ucionicama koje nisu laboratorije
SELECT TIP, PROIZVODJAC, MODEL, BROJ_UCIONICE
FROM DODATNA_OPREMA
WHERE NOT EXISTS (SELECT 0 FROM UCIONICA  --ugnjezdeni korelisani upit
                  WHERE BROJ_UCIONICE=UCIONICA.BROJ 
                      AND UCIONICA.NAZIV LIKE('%LAB%'));

--alternativa (uz koriscenje nekorelisanog upita)
SELECT TIP, PROIZVODJAC, MODEL, BROJ_UCIONICE
FROM DODATNA_OPREMA
WHERE BROJ_UCIONICE IN (SELECT BROJ FROM UCIONICA WHERE NAZIV NOT LIKE('%LAB%'));