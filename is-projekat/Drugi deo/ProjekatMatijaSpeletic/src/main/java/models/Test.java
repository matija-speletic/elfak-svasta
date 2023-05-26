package models;

//import java.sql.DriverManager;
import services.*;
/*import java.sql.Timestamp;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;*/

//import javax.persistence.EntityManager;
/*import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;*/

public class Test {
	//private static EntityManager em;

	public static void main(String[] args) {

		//EntityManagerFactory emf = Persistence.createEntityManagerFactory("ProjekatPU");
		//em = emf.createEntityManager();

		/*
		 * createEmployee("Ime1", "Prezime1", "IT",1100); createEmployee("Ime2",
		 * "Prezime2", "HR",1500); createEmployee("Ime3", "Prezime3", "DevOps",1700);
		 */

		//createEmployee("Ime1", "Prezime1", "menadzer",1100); 
		// deleteEmployee(1);
		//updateEmployeeSalary(2, 20000);
		// createEmployee(1000, "Ime1000", "Prezime", "IT", 900);
		IKorisnikService service=new KorisnikService();
		//service.dodajKorisnika("222","proba1", "proba1", "1777411", "101", "1010", "10100");

		service.obrisiKorisnika("222");
		/*
		 * String conn="jdbc:mysql://localhost:3306/baza"; String username="root";
		 * String password="root";
		 */

		//em.getTransaction().begin();
		//Ugovor emp = new Ugovor(new Timestamp(System.currentTimeMillis()),2,2,2,1);
		//em.persist(emp);
		//em.getTransaction().commit();
		// prikazFilterPlata(conn,username,password, 10000);
		//listAllEmployees();
		//FindEmployee("Ime1", "Prezime1");
		// showWithSalaryGreaterThan(10000);
	}

	

}
