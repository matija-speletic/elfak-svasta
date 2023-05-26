import org.junit.*;

import static org.junit.Assert.*;

import services.*;
import models.Korisnik;

public class KorisnikTest {

	private static IKorisnikService service;

	@BeforeClass
	public static void initTest() {
		service=new KorisnikService();
		System.out.println("BeforeClass: service uspesno inicijalizovan");
	}
	
	@Before
	public void testPrecondition() {
		Korisnik korisnik=service.vratiKorisnika("777");
		assertNull(korisnik);
		System.out.println("Before: preduslov (korisnik sa ID=777 ne postoji) ispunjen");
	}
	
	@Test
	public void testAssertions() {
		service.dodajKorisnika("777","Matija", "Speletic", "062269074", "10000", "10000", "10000");
		service.promeniInternet("777", "10001");
		service.promeniMinute("777", "10001");
		service.promeniPoruke("777", "10001");
		service.promeniZaduzenje("777", "10001");
		System.out.println("Test: Korisnik sa ID=777 dodat");
	}
	
	@After
	public void testPostcondition() {
		Korisnik korisnik=service.vratiKorisnika("777");
		assertNotNull(korisnik);	
		assertEquals(korisnik.getInternet(), 10001);
		assertEquals(korisnik.getMinuti(), 10001);
		assertEquals(korisnik.getPoruke(), 10001);
		assertEquals(korisnik.getZaduzenje(), 10001);
		System.out.println("After: Korisnik sa ID=777 postoji u bazi sa ispravno podesenim internetom, minutim, porukama i zaduzenjem");
	}
	
	@AfterClass
	public static void clearTest() {
		service.obrisiKorisnika("777");
		System.out.println("AfterClass: Test podaci obrisani");
	}
}
