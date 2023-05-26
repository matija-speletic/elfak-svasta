using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Oracle.ManagedDataAccess.Client;
using System.Data;

namespace BrisanjeDrugaAplikacija
{
    class Program
    {
        static void Main(string[] args)
        {
            /*      OPIS FUNKCIONISANJA APLIKACIJE:
             *      Aplikacija sluzi za ispisivanje polaznika sa kursa na osnovu datuma 
             *      upisa. Korisnik unosi ime i prezime polaznika, a zatim i datum kada
             *      je polaznik ovaj kurs upisao. Na osnovu procitanih parametara, brise 
             *      se stavka u tabeli POHADJA
             */


            OracleConnection con = null;
            //konekcioni string
            string conString = "Data Source = 160.99.12.92/GISLAB_PD; User Id = S18043; Password = pepeletvor;";

            try
            {
                //sledi ucitavanje svih gore navedenih podataka
                Console.Write("Uneti ime polaznika koji zeli da se ispise sa kursa: ");
                string ime = Console.ReadLine();

                Console.Write("Uneti prezime ovog polaznika: ");
                string prez = Console.ReadLine();

                Console.Write("Uneti datum upisa na kurs sa kog polaznik zeli da se ispise: ");
                string datumUpisa = Console.ReadLine();

                //otvaranje konekcije ka bazi podataka
                con = new OracleConnection(conString);
                con.Open();

                //sve tabele kojesu nam neophodne za rad se ucitavaju 
                DataSet ds = new DataSet();
                OracleDataAdapter daPolaznik = new OracleDataAdapter("SELECT * FROM POLAZNIK",con);
                daPolaznik.Fill(ds, "POLAZNICI");
                OracleDataAdapter daPohadja = new OracleDataAdapter("SELECT * FROM POHADJA", con);
                daPohadja.MissingSchemaAction = MissingSchemaAction.AddWithKey;
                daPohadja.Fill(ds, "POHADJANJA");

                //nakon ucitavanja podataka, možemo zatvoriti konekciju
                con.Close();

                //potrebno nam je zbog delete naredbe
                OracleCommandBuilder builder = new OracleCommandBuilder(daPohadja);

                //ucitava se red iz tabele POLAZNIK sa zadatim imenom i prezimenom
                //mi znamo da ce ovaj upit vratiti jedan red i zbog toga koristimo samo prvi element niza
                DataRow[] drTrazeniPolaznik = ds.Tables["POLAZNICI"].Select("IME = '" + ime + "' AND PREZIME = '" + prez + "' ");
                //ukoliko je korisnik uneo nepostojeceg polaznika, neophodno je prekinuti aplikaciju, jer njeno dalje
                //ne bi bilo ispravno
                if (drTrazeniPolaznik.Length == 0)
                    throw new Exception("Trazeni polaznik ne postoji!");//ovo se postize bacanjem izuzetka sa odgovarajucom porukom
                long jmbgTrazenogPolaznika = (long)drTrazeniPolaznik[0]["JMBG"];

                //na potpuno isti nacin selektujemo red iz tabel pohadja i ukoliko postoji, obrisemo ga
                DataRow[] drPohadjanja = ds.Tables["POHADJANJA"].Select("JMBG_POLAZNIKA = " + 
                    jmbgTrazenogPolaznika.ToString() + " AND  DAT_UPISA = '" + datumUpisa + "' ");
                if (drPohadjanja.Length != 0 && drPohadjanja[0] != null)
                {
                    DataRow r = drPohadjanja[0];
                    short idKursa = (short)r["ID_KURSA"];

                    r.Delete();//brisanje reda

                    daPohadja.Update(ds, "POHADJANJA");//prosledjivanje izmena u bazu

                    //ispis poruke
                    Console.WriteLine("Polaznik ciji je JMBG " + jmbgTrazenogPolaznika.ToString() 
                        + " je uspesno ispisan sa kursa ciji je ID_BROJ " + idKursa);
                }
                else
                    throw new Exception("Stavka ne postoji!");
            }
            catch (Exception ec) //ukoliko je doslo do neke greske prikazuje se odgovarajuca poruka
            {
                Console.WriteLine("Doslo je do greske prilikom pristupanja bazi podataka: " + ec.Message);
            }
            finally
            {
                //zatvaranje konekcije
                if (con != null && con.State == System.Data.ConnectionState.Open)
                    con.Close();

                con = null;
            }
            Console.ReadLine(); //dodato da se konzola ne bi odmah zatvorila

        }
    }
}
