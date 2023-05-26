package com.gui.controllers;

import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import java.util.List;

import com.ejb.services.DogadjajService;
import com.jpa.entities.Dogadjaj; 

@ManagedBean
public class DogadjajController {

	public String getKid() {
		return kid;
	}

	public void setKid(String kid) {
		this.kid = kid;
	}

	private String kid="0";
	
	@EJB
	private DogadjajService service;
	
	public List<Dogadjaj> vratiDogadjaje(String sid){
		return service.vratiDogadjaje(Integer.parseInt(sid));
	}
	
	public String vratiPunoIme(String sid) {
		return service.vratiImeKorisnika(Integer.parseInt(sid));
	}
}
