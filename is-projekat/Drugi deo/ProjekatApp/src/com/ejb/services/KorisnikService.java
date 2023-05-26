package com.ejb.services;

import java.util.List;
import com.jpa.entities.Korisnik;

public interface KorisnikService {

	public void dodajKorisnika(String ime,String prezime,String broj,String inernet,String minuti,String poruke);
	public void obrisiKorisnika(String sid);
	public void promeniZaduzenje(String sid,String novoZaduzenje);
	public void promeniInternet(String sid,String noviInternet);
	public void promeniMinute(String sid,String noviMinuti);
	public void promeniPoruke(String sid, String novePoruke);
	public List<Korisnik> spisakKorisnika();
}
