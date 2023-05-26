--(1) spisak imena i prezimena svih polaznika iz opstine Palilula, sortirani po imenu i prezimenu
SELECT IME, PREZIME
FROM POLAZNIK
WHERE OPSTINA='Palilula'
ORDER BY IME ASC, 
		 PREZIME ASC;



--(2) spisak svih malih ucionica ciji je kapacitet manji od 20 i broj racunara manji od 15 sortiran po kapacitetu
SELECT BROJ, NAZIV, KAPACITET, BR_RACUNARA
FROM UCIONICA
WHERE KAPACITET<20 
	  AND BR_RACUNARA<15
ORDER BY KAPACITET; --kada se ne stavi ASC ili DESC podrazumeva se



--(3) spisak svih instruktora koji su zavrsili magistarske ili doktorske studije sortirani po imenu i prezimenu
SELECT LIME, SSLOVO, PREZIME, ST_SPREMA
FROM INSTRUKTOR
WHERE ST_SPREMA IN('doktorat', 'magistar')
ORDER BY LIME ASC, 
		 SSLOVO ASC, 
		 PREZIME ASC;



--(4) spisak svih instruktora iz Palilule koji su rodjeni septembra sortiran po datumu rodjenja
SELECT LIME, PREZIME, OPSTINA, DAT_RODJ
FROM INSTRUKTOR
WHERE OPSTINA='Palilula'
	  AND DAT_RODJ LIKE '%SEP%';



--(5) spisak svih instruktora cija je plata izmedju 70 i 100 hiljada dinara prikazan u opadajucem redosledu (po plati)
SELECT LIME, SSLOVO, PREZIME, PLATA
FROM INSTRUKTOR
WHERE PLATA BETWEEN 70000 AND 100000
ORDER BY PLATA DESC;
	--alternativno
SELECT LIME, SSLOVO, PREZIME, PLATA
FROM INSTRUKTOR
WHERE PLATA>=70000 AND PLATA<=100000
ORDER BY PLATA DESC;



--(6) spisak svih cisco Catalyst switcheva (bez ponavljanja)
SELECT DISTINCT PROIZVODJAC, TIP, MODEL
FROM DODATNA_OPREMA
WHERE PROIZVODJAC='Cisco' 
	  AND MODEL LIKE 'Catalyst%';



--(7) spisak cisco kurseva u ponudi skole (oni koji sadrze rec cisco u svom nazivu i oznaku ccna u nivou) soritani po nivou
SELECT *  --prikazuje sve kolone
FROM KURS
WHERE LOWER(NAZIV) LIKE '%cisco%'
	  AND LOWER(NIVO) LIKE '%ccna%'
ORDER BY NIVO; 



--(8) broj upisa("pohadjanja") kod kojih je ostvaren popust
SELECT COUNT(*) AS BROJ_IZDATIH_POPUSTA
FROM POHADJA
WHERE POPUST IS NOT NULL 
	  AND POPUST>0;
	  


--(9) potrebno je kontaktirati polaznike koji nisu ostavili  informaciju o adresi prilikom upisa
--formirati spisak svih polaznika i njihovog kontakta kojima nedostaje neka informacija o adresi, sortiran po imenu i prezimenu
SELECT  IME, PREZIME, BROJ_TELEFONA, E_MAIL
FROM POLAZNIK
WHERE OPSTINA IS NULL
	  OR ULICA IS NULL
	  OR BROJ IS NULL
ORDER BY IME, PREZIME;



--(10) minimalna, prosecna i maksimana cena kursa
SELECT MIN(CENA), AVG(CENA), MAX(CENA)
FROM KURS;