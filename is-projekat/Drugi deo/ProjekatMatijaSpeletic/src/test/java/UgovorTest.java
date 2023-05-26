import org.junit.*;

import static org.junit.Assert.*;

import services.*;
import models.Korisnik;
import models.Ugovor;
import models.Dogadjaj;
import models.Paket;

public class UgovorTest {

	private static UgovorService service;

	@BeforeClass
	public static void initTest() {
		service=new UgovorServiceImpl();
		System.out.println("BeforeClass: service uspesno inicijalizovan");
	}
	
	@Before
	public void testPrecondition() {
		Ugovor ugovor=service.vratiUgovor(999);
		Paket paket=service.vratiPaket(2);
		Korisnik korisnik=service.vratiKorisnika(2);
		assertNull(ugovor);
		assertNotNull(korisnik);
		assertNotNull(paket);
		System.out.println("Before: preduslov (ugovor sa ID=999 ne postoji) ispunjen");
	}
	
	@Test
	public void testAssertions() {
		service.sklopiUgovor(999, 2, 2, 0, 999);
		System.out.println("Test: Ugovor sa ID=999 sklopljen");
	}
	
	@After
	public void testPostcondition() {
		Ugovor ugovor=service.vratiUgovor(999);
		Dogadjaj dogadjaj=service.vratiDogadjaj(999);
		Paket paket=service.vratiPaket(2);
		Korisnik korisnik=service.vratiKorisnika(2);
		assertNotNull(ugovor);	
		assertNotNull(dogadjaj);
		assertEquals(paket.getInternet(), korisnik.getInternet());
		assertEquals(paket.getMinuti(), korisnik.getMinuti());
		assertEquals(paket.getPoruke(), korisnik.getPoruke());
		System.out.println("After: Ugovor je uspesno sklopljen, dogadjaj zabelezen i podaci korisnika izmenjeni");
	}
	
	@AfterClass
	public static void clearTest() {
		service.obrisiUgovor(999);
		service.obrisiDogadjaj(999);
		System.out.println("AfterClass: Test podaci obrisani");
	}
}
