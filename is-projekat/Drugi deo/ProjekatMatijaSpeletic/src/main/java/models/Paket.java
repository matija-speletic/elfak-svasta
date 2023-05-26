package models;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.TableGenerator;

@Entity
@Table(name = "paket")
public class Paket {
	@TableGenerator(name = "paket_gen", table = "id_gen", pkColumnName = "gen_name", valueColumnName = "gen_val", allocationSize = 1, pkColumnValue = "paket_gen")
	@Id
	@GeneratedValue(strategy = GenerationType.TABLE, generator = "paket_gen")
	@Column(name = "id")
	private int id;
	@Column(name = "naziv")
	private String naziv;
	@Column(name = "tip")
	private String tip;
	@Column(name = "cena")
	private int cena;
	@Column(name = "internet")
	private int internet;
	@Column(name = "minuti")
	private int minuti;
	@Column(name = "poruke")
	private int poruke;


	public String getNaziv() {
		return naziv;
	}

	public void setNaziv(String naziv) {
		this.naziv = naziv;
	}

	public String getTip() {
		return tip;
	}

	public void setTip(String tip) {
		this.tip = tip;
	}

	public int getCena() {
		return cena;
	}

	public void setCena(int cena) {
		this.cena = cena;
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

	public Paket() {
	}

	public Paket(String naziv, String tip, int cena,int internet,int minuti,int poruke) {
		this.setNaziv(naziv);
		this.setTip(tip);
		this.setCena(cena);
		this.setInternet(internet);
		this.setPoruke(poruke);
		this.setMinuti(minuti);
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

}
