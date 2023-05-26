package com.ejb.services;

import java.util.List;
import com.jpa.entities.Uredjaj;

public interface UredjajService {
	
	public List<Uredjaj> sviUredjaji();
	public void dodajUredjaj(String proizvodjac,String model,String cena,String memorija,String cpu,String kamera,String kolicina);
	public void obrisiUredjaj(String sid);
	public void promeniKolicinu(String sid,String novaKolicina);
	public void promeniCenu(String sid, String novaCena);

}
