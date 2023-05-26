package services;

import models.*;

public interface UgovorService {

	public void sklopiUgovor(int idUgovora, int idKorisnika,int idPaketa, int idUredjaja,int idDogadjaja);
	public Ugovor vratiUgovor(int idUgovora);
	public void obrisiUgovor(int idUgovora);
	public Dogadjaj vratiDogadjaj(int idDogadjaja);
	public void obrisiDogadjaj(int idDogadjaja);
	public Korisnik vratiKorisnika(int idKorisnika);
	public Paket vratiPaket(int idPaketa);
}
