package com.gui.controllers;

import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import java.util.List;

import com.ejb.services.KorisnikService;
import com.jpa.entities.Korisnik;


@ManagedBean
public class KorisnikController {

	private String ime="";
	private String prezime="";
	private String id="";
	private String broj="";
	private String internet="";
	private String minuti="";
	private String poruke="";
	private String zaduzenje="";
	private String idp;
	private String idi;
	private String idr;
	private String ido;
	
	
	public String getIdp() {
		return idp;
	}

	public void setIdp(String idp) {
		this.idp = idp;
	}

	public String getIdi() {
		return idi;
	}

	public void setIdi(String idi) {
		this.idi = idi;
	}

	public String getIdr() {
		return idr;
	}

	public void setIdr(String idr) {
		this.idr = idr;
	}

	public String getIdo() {
		return ido;
	}

	public void setIdo(String ido) {
		this.ido = ido;
	}

	@EJB
	private KorisnikService service;
	
	public void registrujKorisnika(String ime,String prezime,String broj) {
		service.dodajKorisnika(ime, prezime, broj, "0", "0", "0");
	}
	
	public List<Korisnik> sviKorisnici() {
		List<Korisnik> korisnici=service.spisakKorisnika();
		return korisnici;
	}
	
	public void dodajMinute(String id, String minuti) {
		service.promeniMinute(id, minuti);
	}
	
	public void dodajPoruke(String id, String poruke) {
		service.promeniPoruke(id, poruke);
	}
	
	public void dodajInternet(String id, String internet) {
		service.promeniInternet(id, internet);
	}
	
	public void uplataNaRacun(String id, String iznos) {
		service.promeniZaduzenje(id, iznos);
	}
	
	public void obrisiKorisnika(String sid) {
		service.obrisiKorisnika(sid);
	}
	
	public String getIme() {
		return ime;
	}

	public void setIme(String ime) {
		this.ime = ime;
	}

	public String getPrezime() {
		return prezime;
	}

	public void setPrezime(String prezime) {
		this.prezime = prezime;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getBroj() {
		return broj;
	}

	public void setBroj(String broj) {
		this.broj = broj;
	}

	public String getInternet() {
		return internet;
	}

	public void setInternet(String internet) {
		this.internet = internet;
	}

	public String getMinuti() {
		return minuti;
	}

	public void setMinuti(String minuti) {
		this.minuti = minuti;
	}

	public String getPoruke() {
		return poruke;
	}

	public void setPoruke(String poruke) {
		this.poruke = poruke;
	}

	public String getZaduzenje() {
		return zaduzenje;
	}

	public void setZaduzenje(String zaduzenje) {
		this.zaduzenje = zaduzenje;
	}

	
}
