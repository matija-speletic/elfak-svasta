using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Oracle.ManagedDataAccess.Client;
using System.Data;

namespace AzuriranjeDrugaAplikacija
{
    class Program
    {
        static void Main(string[] args)
        {
            string strConnection = "Data Source=160.99.12.92/GISLAB_PD;User Id=S18043;Password=pepeletvor;";

            OracleConnection con = null;

            try
            {
                /*      OPIS FUNKCIONISANJA APLIKACIJE:
                 *      Aplikacija sluzi za premestanje instruktora sa jednog kursa 
                 *      na drugi. Korisnik unosi ime i prezime instruktora, naziv i 
                 *      nivo kursa sa kog instruktor treba da se prebaci i naziv i 
                 *      nivo kursa na koji instruktor treba da se prebaci. (Ovo se 
                 *      vrsi azuriranjem tabele PREDAJE)
                 *      
                 */

                //sledi ucitavanje svih gore navedenih podataka
                Console.Write("Uneti ime instruktora koga je neophodno prebaciti da predaje na nekom drugom kursu: ");
                string ime = Console.ReadLine();

                Console.Write("Uneti prezime ovog instruktora: ");
                string prez = Console.ReadLine();

                Console.Write("Uneti naziv kursa koji instruktor trenutno predaje: ");
                string nazivTrenutnog = Console.ReadLine();

                Console.Write("Uneti nivo ovog kursa: ");
                string nivoTrenutnog = Console.ReadLine();

                Console.Write("Uneti naziv kursa na koji se instruktor prebacuje: ");
                string nazivNovog = Console.ReadLine();

                Console.Write("Uneti nivo ovog kursa: ");
                string nivoNovog = Console.ReadLine();

                //kreira se novi connection objekat
                con = new OracleConnection(strConnection);

                //uspopstavlja se konekcija sa bazom podataka
                con.Open();

                //priprema se DataAdapter-a za ucitavanje informacija iz odgovarajucih tabela
                DataSet ds = new DataSet();
                OracleDataAdapter daInstruktori = new OracleDataAdapter("SELECT * FROM INSTRUKTOR", con);
                daInstruktori.Fill(ds, "INSTRUKTORI");
                OracleDataAdapter daKursevi = new OracleDataAdapter("SELECT * FROM KURS", con);
                daKursevi.Fill(ds, "KURSEVI");
                OracleDataAdapter daPredaje = new OracleDataAdapter("SELECT * FROM PREDAJE", con);
                daPredaje.Fill(ds, "PREDAJE");

                //podaci su ucitani u DataSet pa moze da se prekine konekcija sa bazom podataka
                con.Close();

                //potrebno nam je zbog update naredbe
                OracleCommandBuilder builder = new OracleCommandBuilder(daPredaje);

                //ucitavaju se podaci iz odgobarajucih tabela koje smo prethodno ucitali 
                //mi znamo da ce ovaj upit vratiti jedan red pa uzmamo samo prvi element niza koji je funkcija vratila
                DataRow[] drNoviKurs = ds.Tables["KURSEVI"].Select("NAZIV = '" + nazivNovog + "' AND NIVO = '" + nivoNovog + "' ");
                //ukolikoo je vracen prazan niz, znaci da je korisnik uneo nepostojeci kurs i potrebno je prekinuti izvrsenje
                //aplikacije jer njeno dalje izvrsenje ne bi bilo ispravno
                if (drNoviKurs.Length == 0)
                    throw new Exception("Naziv ili nivo kursa nisu ispravni!");
                short idNovogKursa = (short)(drNoviKurs[0])["ID_BROJ"];

                //na potpuno isti nacin se ucitavaju i ostali podaci
                DataRow[] drTrenutniKurs = ds.Tables["KURSEVI"].Select("NAZIV = '" + nazivTrenutnog + "' AND NIVO = '" + nivoTrenutnog + "' ");
                if (drTrenutniKurs.Length == 0)
                    throw new Exception("Naziv ili nivo kursa nisu ispravni!");
                short idTrenutnogKursa = (short)(drTrenutniKurs[0])["ID_BROJ"];

                DataRow[] drTrazeniInstruktor = ds.Tables["INSTRUKTORI"].Select("LIME = '" + ime + "' AND PREZIME = '" + prez + "' ");
                if (drTrazeniInstruktor.Length == 0)
                    throw new Exception("Ime ili prezime instruktoa nisu ispravni!");
                int idTrazenogInstruktora = (int)(drTrazeniInstruktor[0])["ID_BROJ"];

                //biramo odgovarajuce vrste iz tabele
                //NAPOMENA: ovde u sustini nije neophodna foreach petlja, jer znamo da ce ovaj upit vratiti samo jednu vrstu
                //pa je takodje bilo moguce da se kod u foreach petlji izvrsi samo za prvi tj nulti element ovog niza
                DataRow[] drPredaje = ds.Tables["PREDAJE"].Select("ID_KURSA = " + idTrenutnogKursa.ToString() + " AND ID_INSTRUKTORA = " + idTrazenogInstruktora.ToString());
                foreach(DataRow r in drPredaje)
                {
                    if (r.IsNull("ID_KURSA"))
                        continue;
                    //stampamo informacije tokom izvrsenja kako bismo proverili ispravnost aplikacije (nije bilo eophodno)
                    Console.WriteLine("Menjanje sadrzaja tabele predaje...");
                    Console.WriteLine("Stari sadrzaj je: " + r["ID_INSTRUKTORA"].ToString() + " " + r["ID_KURSA"].ToString());
                    r["ID_KURSA"] = idNovogKursa;
                    Console.WriteLine("Novi sadrzaj je: " + r["ID_INSTRUKTORA"].ToString() + " " + r["ID_KURSA"].ToString()); 
                }

                //tabela se azurira u bazi podataka i stampa se poruka o tome
                daPredaje.Update(ds, "PREDAJE");
                Console.WriteLine("Instruktor " + ime + " " + prez + ", ciji je ID_BROJ " + idTrazenogInstruktora + " je uspesno prebacen sa kursa "
                    + nazivTrenutnog + ", ciji je ID_BROJ " + idTrenutnogKursa + " na kurs " + nazivNovog + " ciji je ID_BROJ " + idNovogKursa+".");

                

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
