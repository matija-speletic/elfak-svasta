--AZURIRANJE PODATAKA

--1. Ucenica Branka Brankovic, koja je trenutno na Cisco kursu CCNA1 je zavrsila ceo kurs i potrebno je prebaciti je na sledeci nivo - CCNA2 (prilikom upisa ovog novog kursa ostvarila je +5% popusta). Azurirati podatke u skladu sa ovim zahtevima.
UPDATE POHADJA
SET ID_KURSA = (SELECT ID_BROJ FROM KURS 
				WHERE LOWER(NAZIV) LIKE '%cisco%' AND NIVO='CCNA2'),
	DAT_UPISA=SYSDATE,
	POPUST=POPUST+5
WHERE ID_KURSA=(SELECT ID_BROJ FROM KURS 
				WHERE LOWER(NAZIV) LIKE '%cisco%' AND NIVO='CCNA1')
	  AND JMBG_POLAZNIKA=(SELECT JMBG FROM POLAZNIK
						  WHERE IME='Branka' AND PREZIME='Brankovic');



--2. U bazi podataka je greskom upisana informacija da Milan Milojkovic predaje na kursu Projektovanje WAN mreza WAN2, a on zapravo predaje na kursu Konfiguracija mreznih uredjaja tehnologije. Ispraviti ovu gresku.
UPDATE PREDAJE
SET ID_KURSA=(SELECT ID_BROJ FROM KURS 
			  WHERE NAZIV='Konfiguracija mreznih uredjaja')
WHERE ID_KURSA=(SELECT ID_BROJ FROM KURS 
				WHERE NAZIV='Projektovanje WAN mreza'
					  AND NIVO='WAN2')
	  AND ID_INSTRUKTORA=(SELECT ID_BROJ FROM INSTRUKTOR 
						  WHERE IME='Milan'
								AND PREZIME='Milojkovic');





--BRISANJE PODATAKA

--1. Brisanje svih ucionica u kojima se ne odrzava nijedan kurs
DELETE FROM UCIONICA
WHERE BROJ NOT IN (SELECT BROJ_UCIONICE 
				   FROM KURS);
--alternativa
DELETE FROM UCIONICA WHERE NOT EXISTS (SELECT 0 
									   FROM KURS
									   WHERE KURS.BROJ_UCIONICE=UCIONICA.BROJ);



--2. Polaznik Vladimir Stojanovic je odlucio da zeli da se ispise sa kursa koji je upisao maja 2020. godine. Potrebno je azurirati podatke u skladu sa ovim.
DELETE FROM POHADJA
WHERE JMBG_POLAZNIKA = (SELECT JMBG 
						FROM POLAZNIK
						WHERE IME='Vladimir' AND PREZIME='Stojanovic')
	  AND DAT_UPISA LIKE '%MAY-20';
