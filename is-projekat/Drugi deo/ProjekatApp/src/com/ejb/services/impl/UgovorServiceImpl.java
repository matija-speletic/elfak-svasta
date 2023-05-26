package com.ejb.services.impl;

import java.sql.Timestamp;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.ejb.services.UgovorService;
import com.jpa.entities.Dogadjaj;
import com.jpa.entities.Korisnik;
import com.jpa.entities.Paket;
import com.jpa.entities.Ugovor;
import com.jpa.entities.Uredjaj;

@Stateless
public class UgovorServiceImpl implements UgovorService {
	
	@PersistenceContext(name = "EmployeeApp")
	private EntityManager em;

	@Override
	public List<Ugovor> vratiUgovore() {
		return em.createQuery("SELECT u FROM Ugovor u", Ugovor.class).getResultList();
	}

	@Override
	public List<Paket> vratiPakete() {
		return em.createQuery("SELECT p FROM Paket p", Paket.class).getResultList();
	}

	@Override
	public List<Uredjaj> vratiUredjaje() {
		return em.createQuery("SELECT u FROM Uredjaj u", Uredjaj.class).getResultList();
	}

	@Override
	public void sklopiUgovor(Integer idKorisnika, Integer idPaketa, Integer idUredjaja) {
		try {

			Ugovor ugovor=idUredjaja==-1? 
					new Ugovor(new Timestamp(System.currentTimeMillis()), idKorisnika, idPaketa,0):
					new Ugovor(new Timestamp(System.currentTimeMillis()), idKorisnika, idPaketa, idUredjaja);
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
			Dogadjaj dogadjaj=new Dogadjaj(idKorisnika, "Sklapanje ugovora", paket.getCena()+uredjaj.getCena());
			em.persist(dogadjaj);

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@Override
	public String punoImeKorisnika(Integer id) {
		Korisnik korisnik=em.find(Korisnik.class, id);
		if(korisnik!=null)
			return korisnik.getIme()+" "+korisnik.getPrezime();
		return "";
	}

	@Override
	public String paketDisplay(Integer id) {
		Paket p=em.find(Paket.class, id);
		if(p!=null)
			return p.getNaziv()+"("+p.getTip()+") Cena: "+p.getCena()+"RSD";
		return "";
	}

	@Override
	public String uredjajDisplay(Integer id) {
		Uredjaj u =em.find(Uredjaj.class, id);
		if(u!=null)
			return u.getProizvodjac()+" "+u.getModel()+" (Cena: "+u.getCena()+")";
		return "";
	}

}
