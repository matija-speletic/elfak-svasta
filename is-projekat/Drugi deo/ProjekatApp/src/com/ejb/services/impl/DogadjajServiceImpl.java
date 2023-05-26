package com.ejb.services.impl;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.ejb.services.DogadjajService;
import com.jpa.entities.Dogadjaj;
import com.jpa.entities.Korisnik;

@Stateless
public class DogadjajServiceImpl implements DogadjajService {
	
	@PersistenceContext(name = "EmployeeApp")
	private EntityManager em;

	@Override
	public List<Dogadjaj> vratiDogadjaje(Integer id) {
		if(id!=null) {
			return em.createQuery("SELECT d FROM Dogadjaj d WHERE d.idKorisnika = :id", Dogadjaj.class)
					.setParameter("id", id)
					.getResultList();
		}
		return em.createQuery("SELECT d FROM Dogadjaj d", Dogadjaj.class).getResultList();
	}

	@Override
	public String vratiImeKorisnika(Integer id) {
		Korisnik korisnik=em.find(Korisnik.class, id);
		if(korisnik!=null)
			return korisnik.getIme()+" "+korisnik.getPrezime();
		return "";
	}

}
