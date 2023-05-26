package com.ejb.services;

import java.util.List;
import com.jpa.entities.Dogadjaj;

public interface DogadjajService {

	public List<Dogadjaj> vratiDogadjaje(Integer id);
	public String vratiImeKorisnika(Integer id);
	
}
