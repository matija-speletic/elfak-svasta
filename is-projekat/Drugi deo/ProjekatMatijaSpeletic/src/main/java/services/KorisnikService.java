
package services;

import java.util.List;

import javax.ejb.Stateless;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import models.Korisnik;

@Stateless
public class KorisnikService implements IKorisnikService {

	//@PersistenceContext(name = "ProjekatPU")
	private EntityManager em;

	public KorisnikService() {
		EntityManagerFactory emf = Persistence.createEntityManagerFactory("ProjekatPU");
		em = emf.createEntityManager();
	}

	public void dodajKorisnika(String sid,String ime, String prezime, String broj, String inernet, String minuti, String poruke) {
		try {
			em.getTransaction().begin();
			int net = Integer.parseInt(inernet), min = Integer.parseInt(minuti), por = Integer.parseInt(poruke);
			Korisnik korisnik = new Korisnik(ime, prezime, broj, net, min, por);
			korisnik.setId(Integer.parseInt(sid));
			em.persist(korisnik);
			em.getTransaction().commit();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public void obrisiKorisnika(String sid) {
		try {
			em.getTransaction().begin();
			int id = Integer.parseInt(sid);
			Korisnik korisnik = em.find(Korisnik.class, id);
			em.remove(korisnik);
			em.getTransaction().commit();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public void promeniZaduzenje(String sid, String novoZaduzenje) {
		try {
			em.getTransaction().begin();
			int id = Integer.parseInt(sid);
			Korisnik korisnik = em.find(Korisnik.class, id);
			korisnik.setZaduzenje(Integer.parseInt(novoZaduzenje));
			em.getTransaction().commit();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public void promeniInternet(String sid, String noviInternet) {
		try {
			em.getTransaction().begin();
			int id = Integer.parseInt(sid);
			Korisnik korisnik = em.find(Korisnik.class, id);
			korisnik.setInternet(Integer.parseInt(noviInternet));
			em.getTransaction().commit();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public void promeniMinute(String sid, String noviMinuti) {
		try {
			em.getTransaction().begin();
			int id = Integer.parseInt(sid);
			Korisnik korisnik = em.find(Korisnik.class, id);
			korisnik.setMinuti(Integer.parseInt(noviMinuti));
			em.getTransaction().commit();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public void promeniPoruke(String sid, String novePoruke) {
		try {
			em.getTransaction().begin();
			int id = Integer.parseInt(sid);
			Korisnik korisnik = em.find(Korisnik.class, id);
			korisnik.setPoruke(Integer.parseInt(novePoruke));
			em.getTransaction().commit();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public List<Korisnik> spisakKorisnika() {
		List<Korisnik> sviKorisnici=em
				.createQuery("SELECT k FROM Korisnici k",Korisnik.class)
				.getResultList();
		return sviKorisnici;
	}

	public Korisnik vratiKorisnika(String sid) {
		return em.find(Korisnik.class, Integer.parseInt(sid));
	}

	



}
