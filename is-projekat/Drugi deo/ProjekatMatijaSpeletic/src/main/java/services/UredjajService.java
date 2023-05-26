package services;

import models.Uredjaj;

public interface UredjajService {

	public void dodajUredjaj(int id,String name,String model,int cena,String memorija,String cpu,String kamera,int kolicina);
	public Uredjaj vratiUredjaj(int id);
	public void obrisiUredjaj(int id);
	public void promeniKolicinu(int id,int novaKolicina);
	public void promeniCenu(int id,int novaCena);
}
