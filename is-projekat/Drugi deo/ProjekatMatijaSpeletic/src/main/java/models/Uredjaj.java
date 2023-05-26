package models;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "uredjaj")
public class Uredjaj {
	//@TableGenerator(name = "uredjaj_gen", table = "id_gen", pkColumnName = "gen_name", valueColumnName = "gen_val", allocationSize = 1, pkColumnValue = "uredjaj_gen")
	@Id
	//@GeneratedValue(strategy = GenerationType.TABLE, generator = "uredjaj_gen")
	@Column(name = "id")
	private int id;
	@Column(name = "proizvodjac")
	private String proizvodjac;
	@Column(name = "model")
	private String model;
	@Column(name = "cena")
	private int cena;
	@Column(name = "memorija")
	private String memorija;
	@Column(name = "cpu")
	private String cpu;
	@Column(name = "kamera")
	private String kamera;
	@Column(name = "kolicina")
	private int kolicina;


	public int getKolicina() {
		return kolicina;
	}

	public void setKolicina(int kolicina) {
		this.kolicina = kolicina;
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

	public int getCena() {
		return cena;
	}

	public void setCena(int cena) {
		this.cena = cena;
	}

	public Uredjaj() {
	}


	public Uredjaj(Integer id, String proizvodjac, String model, int cena, String memorija, String cpu, String kamera, int kolicina) {
		this.proizvodjac = proizvodjac;
		this.model = model;
		this.cena = cena;
		this.memorija = memorija;
		this.cpu = cpu;
		this.kamera = kamera;
		this.id=id;
		this.kolicina=kolicina;
		
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

}
