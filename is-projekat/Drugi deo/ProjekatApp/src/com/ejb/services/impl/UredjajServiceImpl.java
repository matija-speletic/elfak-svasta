package com.ejb.services.impl;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.ejb.services.UredjajService;
import com.jpa.entities.Uredjaj;

@Stateless
public class UredjajServiceImpl implements UredjajService {
	
	@PersistenceContext(name = "EmployeeApp")
	private EntityManager em;

	@Override
	public List<Uredjaj> sviUredjaji() {
		List<Uredjaj> sviUredjajiList = em.createQuery("SELECT u FROM Uredjaj u", Uredjaj.class).getResultList();
		return sviUredjajiList;
	}

	@Override
	public void dodajUredjaj(String proizvodjac, String model, String cena, String memorija, String cpu, String kamera,
			String kolicina) {
		try {

			Uredjaj uredjaj=new Uredjaj(proizvodjac,model,Integer.parseInt(cena),memorija,cpu,kamera,Integer.parseInt(kolicina));
			em.persist(uredjaj);

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@Override
	public void obrisiUredjaj(String sid) {
		try {
			int id = Integer.parseInt(sid);
			Uredjaj uredjaj = em.find(Uredjaj.class, id);
			em.remove(uredjaj);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@Override
	public void promeniKolicinu(String sid, String novaKolicina) {
		try {
			int id = Integer.parseInt(sid);
			Uredjaj uredjaj = em.find(Uredjaj.class, id);
			if(Integer.parseInt(novaKolicina)>0)
				uredjaj.setKolicina(Integer.parseInt(novaKolicina));
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@Override
	public void promeniCenu(String sid, String novaCena) {
		try {
			int id = Integer.parseInt(sid);
			Uredjaj uredjaj = em.find(Uredjaj.class, id);
			if(Integer.parseInt(novaCena)>0)
				uredjaj.setCena(Integer.parseInt(novaCena));
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
