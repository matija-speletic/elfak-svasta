package com.ejb.services;

import java.util.List;

import com.jpa.entities.Paket;
import com.jpa.entities.Ugovor;
import com.jpa.entities.Uredjaj;

public interface UgovorService {

	public List<Ugovor> vratiUgovore();
	public List<Paket> vratiPakete();
	public List<Uredjaj> vratiUredjaje();
	public void sklopiUgovor(Integer idKorisnika,Integer idPaketa, Integer idUredjaja);
	public String punoImeKorisnika(Integer id);
	public String paketDisplay(Integer id);
	public String uredjajDisplay(Integer id);
}
