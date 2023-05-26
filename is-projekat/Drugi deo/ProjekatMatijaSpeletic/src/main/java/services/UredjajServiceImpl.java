package services;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import models.Uredjaj;

public class UredjajServiceImpl implements UredjajService {
	
	private EntityManager em;

	public UredjajServiceImpl() {
		EntityManagerFactory emf = Persistence.createEntityManagerFactory("ProjekatPU");
		em = emf.createEntityManager();
	}

	public void dodajUredjaj(int id, String name, String model, int cena, String memorija, String cpu, String kamera,
			int kolicina) {
		em.getTransaction().begin();
		Uredjaj uredjaj=new Uredjaj(id, name, model, cena, memorija, cpu, kamera,kolicina);
		em.persist(uredjaj);
		em.getTransaction().commit();
	}

	public Uredjaj vratiUredjaj(int id) {
		return em.find(Uredjaj.class, id);
	}

	public void obrisiUredjaj(int id) {
		try {
			em.getTransaction().begin();
			Uredjaj uredjaj = em.find(Uredjaj.class, id);
			em.remove(uredjaj);
			em.getTransaction().commit();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public void promeniKolicinu(int id, int novaKolicina) {
		try {
			em.getTransaction().begin();
			Uredjaj uredjaj = em.find(Uredjaj.class, id);
			uredjaj.setKolicina(novaKolicina);
			em.getTransaction().commit();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public void promeniCenu(int id, int novaCena) {
		try {
			em.getTransaction().begin();
			Uredjaj uredjaj = em.find(Uredjaj.class, id);
			uredjaj.setCena(novaCena);
			em.getTransaction().commit();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
