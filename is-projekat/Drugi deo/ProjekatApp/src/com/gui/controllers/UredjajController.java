package com.gui.controllers;

import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import java.util.List;

import com.ejb.services.UredjajService;
import com.jpa.entities.Uredjaj;

@ManagedBean
public class UredjajController {
	
	private String sid;
	private String novaCena;
	private String novaKolicina;
	private String proizvodjac;
	private String model;
	private String memorija;
	private String cpu;
	private String kamera;
	private String kolicina;
	private String cena;
	private String sid2;
	private String sid3;
	
	public String getSid2() {
		return sid2;
	}

	public void setSid2(String sid2) {
		this.sid2 = sid2;
	}

	public String getSid3() {
		return sid3;
	}

	public void setSid3(String sid3) {
		this.sid3 = sid3;
	}
	@EJB
	private UredjajService service;
	
	public List<Uredjaj> sviUredjaji(){
		return service.sviUredjaji();
	}
	
	public void dodajUredjaj(String proizvodjac, String model, String cena, String memorija, String cpu, String kamera,String kolicina) {
		service.dodajUredjaj(proizvodjac, model, cena, memorija, cpu, kamera, kolicina);
	}
	
	public void promeniCenu(String sid,String novaCena) {
		service.promeniCenu(sid, novaCena);
	}
	
	public void promeniKolicinu(String sid,String novaKolicina) {
		service.promeniKolicinu(sid, novaKolicina);
	}
	
	public void obrisiUredjaj(String sid) {
		service.obrisiUredjaj(sid);
	}
	
	public String getSid() {
		return sid;
	}
	public void setSid(String sid) {
		this.sid = sid;
	}
	public String getNovaCena() {
		return novaCena;
	}
	public void setNovaCena(String novaCena) {
		this.novaCena = novaCena;
	}
	public String getNovaKolicina() {
		return novaKolicina;
	}
	public void setNovaKolicina(String novaKolicina) {
		this.novaKolicina = novaKolicina;
	}
	public String getProizvodjac() {
		return proizvodjac;
	}
	public void setProizvodjac(String proizvodjac) {
		this.proizvodjac = proizvodjac;
	}
	public String getModel() {
		return model;
	}
	public void setModel(String model) {
		this.model = model;
	}
	public String getMemorija() {
		return memorija;
	}
	public void setMemorija(String memorija) {
		this.memorija = memorija;
	}
	public String getCpu() {
		return cpu;
	}
	public void setCpu(String cpu) {
		this.cpu = cpu;
	}
	public String getKamera() {
		return kamera;
	}
	public void setKamera(String kamera) {
		this.kamera = kamera;
	}
	public String getKolicina() {
		return kolicina;
	}
	public void setKolicina(String kolicina) {
		this.kolicina = kolicina;
	}
	public String getCena() {
		return cena;
	}
	public void setCena(String cena) {
		this.cena = cena;
	}

}
