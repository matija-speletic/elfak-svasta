package models;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "dogadjaji")
public class Dogadjaj {

	//@TableGenerator(name = "dogadjaj_gen", table = "id_gen", pkColumnName = "gen_name", valueColumnName = "gen_val", allocationSize = 1, pkColumnValue = "dogadjaj_gen")
	@Id
	//@GeneratedValue(strategy = GenerationType.TABLE, generator = "dogadjaj_gen")
	@Column(name = "id")
	private int id;
	@Column(name="idKorisnika")
	private int idKorisnika;
	@Column(name="opis")
	private String opis;
	@Column(name="iznos")
	private int iznos;
	
	public Dogadjaj() {
		
	}
	
	public Dogadjaj(int id, int idKorisnika,String opis,int iznos) {
		this.id=id;
		this.idKorisnika=idKorisnika;
		this.opis=opis;
		this.iznos=iznos;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getIdKorisnika() {
		return idKorisnika;
	}
	public void setIdKorisnika(int idKorisnika) {
		this.idKorisnika = idKorisnika;
	}
	public String getOpis() {
		return opis;
	}
	public void setOpis(String opis) {
		this.opis = opis;
	}
	public int getIznos() {
		return iznos;
	}
	public void setIznos(int iznos) {
		this.iznos = iznos;
	}
}
