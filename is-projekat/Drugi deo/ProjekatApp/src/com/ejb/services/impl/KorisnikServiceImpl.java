package com.ejb.services.impl;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import com.jpa.entities.Dogadjaj;
import com.jpa.entities.Korisnik;
import com.jpa.entities.Ugovor;
import com.ejb.services.KorisnikService;

@Stateless
public class KorisnikServiceImpl implements KorisnikService {

	@PersistenceContext(name = "EmployeeApp")
	private EntityManager em;

	@Override
	public void dodajKorisnika(String ime, String prezime, String broj, String inernet, String minuti, String poruke) {
		try {

			int net = Integer.parseInt(inernet), min = Integer.parseInt(minuti), por = Integer.parseInt(poruke);
			Korisnik korisnik = new Korisnik(ime, prezime, broj, net, min, por);
			em.persist(korisnik);

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@Override
	public void obrisiKorisnika(String sid) {
		try {
			int id = Integer.parseInt(sid);
			Korisnik korisnik = em.find(Korisnik.class, id);
			em.remove(korisnik);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@Override
	public void promeniZaduzenje(String sid, String novoZaduzenje) {
		try {
			int id = Integer.parseInt(sid);
			Korisnik korisnik = em.find(Korisnik.class, id);
			if (korisnik.getZaduzenje() - Integer.parseInt(novoZaduzenje) > 0 && Integer.parseInt(novoZaduzenje) > 0) {
				korisnik.setZaduzenje(korisnik.getZaduzenje() - Integer.parseInt(novoZaduzenje));
				Dogadjaj dogadjaj=new Dogadjaj(id, "Uplata na racun (din)", Integer.parseInt(novoZaduzenje));
				em.persist(dogadjaj);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@Override
	public void promeniInternet(String sid, String noviInternet) {
		try {
			int id = Integer.parseInt(sid);
			List<Ugovor> ugovori=em.createQuery("SELECT u FROM Ugovor u WHERE u.idKorisnika = :id", Ugovor.class)
					.setParameter("id", id)
					.getResultList();
			if(ugovori==null||ugovori.isEmpty())
				return;
			Korisnik korisnik = em.find(Korisnik.class, id);
			if (/*korisnik.getInternet() + */Integer.parseInt(noviInternet) > 0 && korisnik.getZaduzenje() < 1000) {
				korisnik.setInternet(korisnik.getInternet() + Integer.parseInt(noviInternet));
				korisnik.setZaduzenje(korisnik.getZaduzenje()+cenaInterneta(noviInternet));
				Dogadjaj dogadjaj=new Dogadjaj(id, "Uplata interneta (GB)", Integer.parseInt(noviInternet));
				em.persist(dogadjaj);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@Override
	public void promeniMinute(String sid, String noviMinuti) {
		try {
			int id = Integer.parseInt(sid);
			List<Ugovor> ugovori=em.createQuery("SELECT u FROM Ugovor u WHERE u.idKorisnika = :id", Ugovor.class)
					.setParameter("id", id)
					.getResultList();
			if(ugovori==null||ugovori.isEmpty())
				return;
			Korisnik korisnik = em.find(Korisnik.class, id);
			if (/*korisnik.getMinuti() + */Integer.parseInt(noviMinuti) > 0 && korisnik.getZaduzenje() < 1000) {
				korisnik.setMinuti(korisnik.getMinuti() + Integer.parseInt(noviMinuti));
				korisnik.setZaduzenje(korisnik.getZaduzenje()+Integer.parseInt(noviMinuti));
				Dogadjaj dogadjaj=new Dogadjaj(id, "Uplata minuta (min)", Integer.parseInt(noviMinuti));
				em.persist(dogadjaj);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@Override
	public void promeniPoruke(String sid, String novePoruke) {
		try {
			int id = Integer.parseInt(sid);
			List<Ugovor> ugovori=em.createQuery("SELECT u FROM Ugovor u WHERE u.idKorisnika = :id", Ugovor.class)
					.setParameter("id", id)
					.getResultList();
			if(ugovori==null||ugovori.isEmpty())
				return;
			Korisnik korisnik = em.find(Korisnik.class, id);
			if (/*korisnik.getPoruke() + */Integer.parseInt(novePoruke) > 0 && korisnik.getZaduzenje() < 1000) {
				korisnik.setPoruke(korisnik.getPoruke() + Integer.parseInt(novePoruke));
				korisnik.setZaduzenje(korisnik.getZaduzenje()+Integer.parseInt(novePoruke));
				Dogadjaj dogadjaj=new Dogadjaj(id, "Uplata poruka (broj poruka)", Integer.parseInt(novePoruke));
				em.persist(dogadjaj);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@Override
	public List<Korisnik> spisakKorisnika() {
		List<Korisnik> sviKorisnici = em.createQuery("SELECT k FROM Korisnik k", Korisnik.class).getResultList();
		return sviKorisnici;

	}
	
	public int cenaInterneta(String kolicina) throws IOException {
		URL obj = new URL("http://192.168.99.100/?registrovan=true&kolicina="+kolicina);
		HttpURLConnection con = (HttpURLConnection) obj.openConnection();
		con.setRequestMethod("GET");
		con.setRequestProperty("User-Agent", "Mozilla/5.0");
		int responseCode = con.getResponseCode();
		System.out.println("GET Response Code :: " + responseCode);
		String outcome="";
		
		if (responseCode == HttpURLConnection.HTTP_OK) { // success
			BufferedReader in = new BufferedReader(new InputStreamReader(
					con.getInputStream()));
			String inputLine;
			StringBuffer response = new StringBuffer();

			while ((inputLine = in.readLine()) != null) {
				response.append(inputLine);
			}
			in.close();

			// print result
			outcome=response.toString();
			System.out.println(outcome);
			return Integer.parseInt(outcome.toString());
		} else {
			System.out.println("GET request failure");
			return -1;
		}

	}

}
