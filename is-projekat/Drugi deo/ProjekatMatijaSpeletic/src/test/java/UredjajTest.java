import org.junit.*;

import static org.junit.Assert.*;

import services.*;
import models.Uredjaj;

public class UredjajTest {

	private static UredjajService service;

	@BeforeClass
	public static void initTest() {
		service=new UredjajServiceImpl();
		System.out.println("BeforeClass: service uspesno inicijalizovan");
	}
	
	@Before
	public void testPrecondition() {
		Uredjaj ugovor=service.vratiUredjaj(999);
		assertNull(ugovor);
		System.out.println("Before: preduslov (uredjaj sa ID=999 ne postoji) ispunjen");
	}
	
	@Test
	public void testAssertions() {
		service.dodajUredjaj(999, "test", "test", 0, "test", "test", "test", 0);
		service.promeniCenu(999, 1);
		service.promeniKolicinu(999, 1);
		System.out.println("Test: Uredjaj sa ID=999 dodat i cena i kolicia postavljeni");
	}
	
	@After
	public void testPostcondition() {
		Uredjaj uredjaj=service.vratiUredjaj(999);
		assertNotNull(uredjaj);	
		assertEquals(uredjaj.getCena(), 1);
		assertEquals(uredjaj.getKolicina(), 1);
		System.out.println("After: Uredjaj je uspesno dodat i cena i kolicina su uspesno izmenjene");
	}
	
	@AfterClass
	public static void clearTest() {
		service.obrisiUredjaj(999);
		System.out.println("AfterClass: Test podaci obrisani");
	}
}
