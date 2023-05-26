package services;

import java.util.List;
import models.Korisnik;

public interface IKorisnikService {
	

	public Korisnik vratiKorisnika(String sid);
	public void dodajKorisnika(String sid,String ime,String prezime,String broj,String inernet,String minuti,String poruke);
	public void obrisiKorisnika(String sid);
	public void promeniZaduzenje(String sid,String novoZaduzenje);
	public void promeniInternet(String sid,String noviInternet);
	public void promeniMinute(String sid,String noviMinuti);
	public void promeniPoruke(String sid, String novePoruke);
	public List<Korisnik> spisakKorisnika();
	
	//public void sendGET(String sid) throws IOException;
}
