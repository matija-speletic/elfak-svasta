using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Oracle.ManagedDataAccess.Client;
using System.Data;

namespace UpitDrugaAplikacija
{
    class Program
    {
        static void Main(string[] args)
        {
            //definise se connection string za ORACLE
            string strConnection = "Data Source=160.99.12.92/GISLAB_PD;User Id=S18043;Password=pepeletvor;";

            OracleConnection con = null;

            try
            {
                /*      OPIS FUNKCIONISANJA APLIKACIJE:
                 *      Korisnik unosi Ime i prezime instruktora. Aplikacija prikazuje spisak svih 
                 *      instruktora koji predaju isti broj kurseva kao i instruktor cije je ime 
                 *      korisnik uneo. (Dodao sam i mogućnost da korisnik odabere da li zeli da
                 *      u generisani spisak ukljuci instruktora cije je ime korisnik uneo)
                 */

                //kreira se novi connection objekat
                con = new OracleConnection(strConnection);

                //uspopstavlja se konekcija sa bazom podataka
                con.Open();

                //upit koji uzima sve podatke o instruktorima i broju kursa koji drze
                //@ znaci da je u pitanju string koji moze imati vise redova
                string strSQL = @"SELECT INSTRUKTOR.ID_BROJ, INSTRUKTOR.LIME,INSTRUKTOR.SSLOVO,INSTRUKTOR.PREZIME, COUNT(*) AS BROJ_KURSEVA
                                FROM INSTRUKTOR INNER JOIN PREDAJE ON INSTRUKTOR.ID_BROJ = PREDAJE.ID_INSTRUKTORA
                                GROUP BY INSTRUKTOR.ID_BROJ,INSTRUKTOR.LIME,INSTRUKTOR.SSLOVO,INSTRUKTOR.PREZIME ";

                //priprema se DataAdapter za ucitavanje ovih podataka
                OracleDataAdapter da = new OracleDataAdapter(strSQL, con);

                //kreira se DataSet i popunjava se ovim podacima
                DataSet ds = new DataSet();
                da.Fill(ds, "INSTRUKTORI_BR_KURSEVA");

                //sada su se svi podaci ucitali i konekcija moze da se prekine
                con.Close();

                DataTable dtInstruktorBrKurs = ds.Tables["INSTRUKTORI_BR_KURSEVA"];


                //uzimamo sve informacije o imenu i prezimenu instruktora
                Console.WriteLine("Uneti ime i prezime instruktora na osnovu koga zelite da formirate spisak"
                    + " instruktora koji predaju isti broj kurseva: ");
                Console.Write("Licno ime: ");
                string lime = Console.ReadLine();
                Console.Write("Prezime: ");
                //ucitavamo da li korisnik zeli da instrukor cije je ime uneo bude deo formiranog spiska
                //NAPOMENA: ovo naravno nije neophodno, stavio sam kako bi se uvela odredjena interaktivnost
                string prez = Console.ReadLine();
                Console.Write("Da li zelite da u spisak bude ukljucen i instruktor cije ste ime uneli? (da/ne): ");
                string izbor = Console.ReadLine();
                bool prikazatiSve = false; //flag prikazatiSve nam govori da li treba prikazati i unetog instruktora
                if (izbor == "da")
                    prikazatiSve = true;

                //iz ucitane tabele selektujemo red koji sadrzi ovo ime i prezime instruktora kako bismo dobili njegov ID_BROJ
                //NAPOMENA: funkcija select vraca niz vrsta, medjutim, mi znamo da ce ovaj upit vratiti samo jednu vrstu
                //pa koristrimo podatke iz samo prvog elementa ovog niza
                DataRow[] drTrazeniInstruktor = dtInstruktorBrKurs.Select("LIME='" + lime + "' AND PREZIME='" + prez + "' ");
                if (drTrazeniInstruktor.Length == 0) //ukoliko se desi da trazeni instruktor ne postoji, neophodno je prekinuti izvrsenje
                                                     //baca se izuzetak sa odgovarajucom porukom (ovo je jedan nacin da se ovakva situacija resi)
                    throw new Exception("Uneli ste ime instruktora koji nije u bazi podataka!");

                int trazeni_id_broj = (int)(drTrazeniInstruktor[0])["ID_BROJ"]; //citamo ID_BROJ koji nam treba
                decimal trazeni_br_kurseva = (decimal)(drTrazeniInstruktor[0])["BROJ_KURSEVA"]; //citamo broj kurseva koji nam treba

                //vfiltriranje tabele - nalaze se svi instruktori koji drze odgovarajuci broj kurseva
                DataRow[] drSpisakInstruktora = dtInstruktorBrKurs.Select("BROJ_KURSEVA=" + trazeni_br_kurseva);

                //za svaku stavku se stampaju odgovarajuce informacije
                foreach(DataRow r in drSpisakInstruktora)
                {
                    int id = (int)r["ID_BROJ"];
                    string ime = (string)r["LIME"];
                    string sslovo = (string)r["SSLOVO"];
                    string prezime = (string)r["PREZIME"];
                    decimal br_kurseva = (decimal)r["BROJ_KURSEVA"];

                    //necemo stampati unetog instruktora ukoliko je korisnik tako izabrao (vec samo ostale)
                    if (id == trazeni_id_broj && !prikazatiSve) continue;

                    Console.WriteLine(ime + " " + sslovo + " " + prezime + " " + br_kurseva);
                }

                
            }
            catch (Exception ex)
            {
                Console.WriteLine("Doslo je do greske prilikom pristupanja bazi podataka: " + ex.Message);

            }
            finally
            {
                if (con != null && con.State == ConnectionState.Open)
                {
                    con.Close();
                }

                con = null;
            }
            Console.ReadLine();
        }
    }
}
