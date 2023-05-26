package models;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "korisnici")
public class Korisnik {
	//@TableGenerator(name = "korisnik_gen", table = "id_gen", pkColumnName = "gen_name", valueColumnName = "gen_val", allocationSize = 1, pkColumnValue = "korisnik_gen")
	@Id
	//@GeneratedValue(strategy = GenerationType.TABLE, generator = "korisnik_gen")
	@Column(name = "id")
	private int id;
	@Column(name = "ime")
	private String ime;
	@Column(name = "prezime")
	private String prezime;
	@Column(name = "broj")
	private String broj;
	@Column(name = "internet")
	private int internet;
	@Column(name = "minuti")
	private int minuti;
	@Column(name = "poruke")
	private int poruke;
	@Column(name = "zaduzenje")
	private int zaduzenje;

	public String getBroj() {
		return broj;
	}

	public void setBroj(String broj) {
		this.broj = broj;
	}

	public int getInternet() {
		return internet;
	}

	public void setInternet(int internet) {
		this.internet = internet;
	}

	public int getMinuti() {
		return minuti;
	}

	public void setMinuti(int minuti) {
		this.minuti = minuti;
	}

	public int getPoruke() {
		return poruke;
	}

	public void setPoruke(int poruke) {
		this.poruke = poruke;
	}

	public int getZaduzenje() {
		return zaduzenje;
	}

	public void setZaduzenje(int zaduzenje) {
		this.zaduzenje = zaduzenje;
	}

	public Korisnik() {
	}

	public Korisnik(String ime, String prezime, String broj,int internet,int minuti,int poruke) {
		this.setIme(ime);
		this.setPrezime(prezime);
		this.setBroj(broj);
		this.setInternet(internet);
		this.setPoruke(poruke);
		this.setZaduzenje(0);
		this.setMinuti(minuti);
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
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

}
