package models;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "ugovor")
public class Ugovor {
	//@TableGenerator(name = "ugovor_gen", table = "id_gen", pkColumnName = "gen_name", valueColumnName = "gen_val", allocationSize = 1, pkColumnValue = "ugovor_gen")
	@Id
	//@GeneratedValue(strategy = GenerationType.TABLE, generator = "ugovor_gen")
	@Column(name = "id")
	private int id;
	@Column(name = "datum")
	private Timestamp datum;
	@Column(name = "idKorisnika")
	private int idKorisnika;
	@Column(name = "idPaketa")
	private int idPaketa;
	@Column(name = "idUredjaja")
	private int idUredjaja;



	
	public Ugovor() {
		
	}
	
	public Ugovor(int id, Timestamp datum, int idKorisnika, int idPaketa, int idUredjaja) {
		this.id=id;
		this.datum = datum;
		this.idKorisnika = idKorisnika;
		this.idPaketa = idPaketa;
		this.idUredjaja = idUredjaja;
	}

	public Timestamp getDatum() {
		return datum;
	}

	public void setDatum(Timestamp datum) {
		this.datum = datum;
	}

	public int getIdKorisnika() {
		return idKorisnika;
	}

	public void setIdKorisnika(int idKorisnika) {
		this.idKorisnika = idKorisnika;
	}

	public int getIdPaketa() {
		return idPaketa;
	}

	public void setIdPaketa(int idPaketa) {
		this.idPaketa = idPaketa;
	}

	public int getIdUredjaja() {
		return idUredjaja;
	}

	public void setIdUredjaja(int idUredjaja) {
		this.idUredjaja = idUredjaja;
	}


	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

}
