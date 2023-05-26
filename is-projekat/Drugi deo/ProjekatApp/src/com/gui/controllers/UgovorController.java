package com.gui.controllers;

import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import java.util.List;

import com.ejb.services.UgovorService;
import com.jpa.entities.*;

@ManagedBean
public class UgovorController {

	private Integer uredjajID=0;
	private Integer paketID=0;
	private String korisnikID="0";
	
	public Integer getUredjajID() {
		return uredjajID;
	}

	public void setUredjajID(Integer uredjajID) {
		this.uredjajID = uredjajID;
	}

	public Integer getPaketID() {
		return paketID;
	}

	public void setPaketID(Integer paketID) {
		this.paketID = paketID;
	}

	public String getKorisnikID() {
		return korisnikID;
	}

	public void setKorisnikID(String korisnikID) {
		this.korisnikID = korisnikID;
	}

	@EJB
	private UgovorService service;
	
	public List<Ugovor> vratiUgovore(){
		return service.vratiUgovore();
	}
	
	public List<Paket> vratiPakete(){
		return service.vratiPakete();
	}
	
	public List<Uredjaj> vratiUredjaje(){
		return service.vratiUredjaje();
	}
	
	public String punoIme(Integer idKorisnika) {
		return service.punoImeKorisnika(idKorisnika);
	}
	
	public String paketDisplay(Integer id) {
		return service.paketDisplay(id);
	}
	
	public String uredjajDispString(Integer id) {
		return service.uredjajDisplay(id);
	}
	
	public void sklopiUgovorSaUredjajem(String korisnikID,Integer uredjajID, Integer paketID) {
		service.sklopiUgovor(Integer.parseInt(korisnikID), paketID, uredjajID);
	}
	
	public void sklopiUgovorBezUredjaja(String korisnikID,Integer paketID) {
		service.sklopiUgovor(Integer.parseInt(korisnikID), paketID, -1);
	}
	
	
}
