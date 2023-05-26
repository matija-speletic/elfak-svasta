package services;

import java.sql.Timestamp;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import models.*;

public class UgovorServiceImpl implements UgovorService {
	
	private EntityManager em;

	public UgovorServiceImpl() {
		EntityManagerFactory emf = Persistence.createEntityManagerFactory("ProjekatPU");
		em = emf.createEntityManager();
	}

	public void sklopiUgovor(int idUgovora, int idKorisnika, int idPaketa, int idUredjaja,int idDogadjaja) {
		try {
			em.getTransaction().begin();
			Ugovor ugovor=idUredjaja==-1? 
					new Ugovor(idUgovora, new Timestamp(System.currentTimeMillis()), idKorisnika, idPaketa,0):
					new Ugovor(idUgovora, new Timestamp(System.currentTimeMillis()), idKorisnika, idPaketa, idUredjaja);
			em.persist(ugovor);
			Korisnik korisnik=em.find(Korisnik.class, idKorisnika);
			Paket paket=em.find(Paket.class, idPaketa);
			Uredjaj uredjaj=em.find(Uredjaj.class, idUredjaja);
			korisnik.setZaduzenje(korisnik.getZaduzenje()+paket.getCena()+uredjaj.getCena());
			korisnik.setInternet(paket.getInternet());
			korisnik.setMinuti(paket.getMinuti());
			korisnik.setPoruke(paket.getPoruke());
			if(uredjaj.getKolicina()>0)
				uredjaj.setKolicina(uredjaj.getKolicina()-1);
			Dogadjaj dogadjaj=new Dogadjaj(idDogadjaja, idKorisnika, "Sklapanje ugovora", paket.getCena()+uredjaj.getCena());
			em.persist(dogadjaj);
			em.getTransaction().commit();

		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	public Ugovor vratiUgovor(int idUgovora) {
		return em.find(Ugovor.class, idUgovora);
	}

	public void obrisiUgovor(int idUgovora) {
		try {
			em.getTransaction().begin();
			Ugovor ugovor = em.find(Ugovor.class, idUgovora);
			em.remove(ugovor);
			em.getTransaction().commit();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	public Dogadjaj vratiDogadjaj(int idDogadjaja) {
		return em.find(Dogadjaj.class, idDogadjaja);
	}

	public void obrisiDogadjaj(int idDogadjaja) {
		try {
			em.getTransaction().begin();
			Dogadjaj dogadjaj = em.find(Dogadjaj.class, idDogadjaja);
			em.remove(dogadjaj);
			em.getTransaction().commit();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	public Korisnik vratiKorisnika(int idKorisnika) {
		return em.find(Korisnik.class, idKorisnika);
	}

	public Paket vratiPaket(int idPaketa) {
		return em.find(Paket.class, idPaketa);
	}

}
