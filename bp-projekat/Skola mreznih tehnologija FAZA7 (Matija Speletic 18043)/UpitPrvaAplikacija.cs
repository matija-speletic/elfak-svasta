using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Oracle.ManagedDataAccess.Client;

namespace UpitPrvaAplikacija
{
    class Program
    {
        /*      OPIS FUNKCIONISANJA APLIKACIJE:
         *      Korisnik unosi Ime i prezime instruktora. Aplikacija prikazuje spisak svih 
         *      instruktora koji predaju isti broj kurseva kao i instruktor cije je ime 
         *      korisnik uneo. (Dodao sam i mogućnost da korisnik odabere da li zeli da
         *      u generisani spisak ukljuci instruktora cije je ime korisnik uneo)
         */
        static void Main(string[] args)
        {
            OracleConnection con = null;
            //konekcioni string
            string conString = "Data Source = 160.99.12.92/GISLAB_PD; User Id = S18043; Password = pepeletvor;";

            try
            {
                //ucitavanje podataka o instruktoru
                Console.WriteLine("Uneti ime i prezime instruktora na osnovu koga zelite da formirate spisak"
                    +" instruktora koji predaju isti broj kurseva: ");
                Console.Write("Licno ime: ");
                string lime = Console.ReadLine();
                Console.Write("Prezime: ");
                //ucitavamo da li korisnik zeli da instrukot cije je ime uneo bude deo formiranog spiska
                //NAPOMENA: ovo naravno nije neophodno, stavio sam kako bi se uvela odredjena interaktivnost
                string prez = Console.ReadLine();
                Console.Write("Da li zelite da u spisak bude ukljucen i instruktor cije ste ime uneli? (da/ne): ");
                string izbor = Console.ReadLine();
                bool prikazatiSve = false; //flag prikazatiSve nam govori da li treba prikazati i unetog instruktora
                if (izbor == "da")
                    prikazatiSve = true;

                //otvaranje konekcije ka bazi podataka
                con = new OracleConnection(conString);
                con.Open();

                //pripremanje komande koja ce za zadato ime i prezime vratiti spisak svih instruktora koji drze
                //isti broj kurseva kao i uneti instruktor
                //s obzirom da je u pitanju duzi upit, pogodnije je koristiti klasu StringBuilder
                StringBuilder strSQL = new StringBuilder();

                //upit br.7 iz faze5, sa dodatim parametrima (ime i prezime)
                strSQL.Append("SELECT INSTRUKTOR.LIME,INSTRUKTOR.SSLOVO,INSTRUKTOR.PREZIME, COUNT(*) AS BROJ_KURSEVA ");
                strSQL.Append(" FROM INSTRUKTOR INNER JOIN PREDAJE ON INSTRUKTOR.ID_BROJ=PREDAJE.ID_INSTRUKTORA ");
                if(!prikazatiSve) //ovaj deo upita ukljucujemo samo ako je korisnik izabrao da ne zeli da instruktor cije je
                                  //ime i prezime uneo bude deo (ovaj deo upita iskljucuje odgovarajuceg instruktora sa spiska)
                    strSQL.Append(" WHERE INSTRUKTOR.LIME<>:lime AND INSTRUKTOR.PREZIME<>:prez ");
                strSQL.Append(" GROUP BY INSTRUKTOR.LIME,INSTRUKTOR.SSLOVO,INSTRUKTOR.PREZIME ");
                strSQL.Append(" HAVING COUNT(*)=(SELECT COUNT(*) FROM INSTRUKTOR JOIN PREDAJE ");
                strSQL.Append(" ON INSTRUKTOR.ID_BROJ=PREDAJE.ID_INSTRUKTORA ");
                strSQL.Append(" WHERE INSTRUKTOR.LIME=:lime AND INSTRUKTOR.PREZIME=:prez) ");

                OracleCommand cmd = new OracleCommand(strSQL.ToString(), con);
                cmd.CommandType = System.Data.CommandType.Text;


                //kreiranje parametra lime i prez (licno ime i prezime instruktora)
                OracleParameter paramLime = new OracleParameter("lime", OracleDbType.Varchar2);
                paramLime.Value = lime;
                OracleParameter paramPrez = new OracleParameter("prez", OracleDbType.Varchar2);
                paramPrez.Value = prez;

                //dodavanje ovih parametara u listu
                cmd.Parameters.Add(paramLime);
                cmd.Parameters.Add(paramPrez);


                //izvrsavanje komande i prihvatanje informacija o instruktorima u DataReader
                OracleDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        string limeInstruktora = dr.GetString(0);    //lime
                        string sslovoInstruktora = dr.GetString(1);  //srednje slovo
                        string prezimeInstruktora = dr.GetString(2); //prezime
                        int brojKurseva = dr.GetInt32(3);            //broj kurseva koji drzi
                        Console.WriteLine(limeInstruktora + " " + sslovoInstruktora + " " 
                            + prezimeInstruktora + " " + brojKurseva.ToString());
                    }
                }
                else //ukoliko rezultat nema redove, prikazuje se odgovarajuca poruka
                {
                    Console.WriteLine("Spisak je prazan!");
                }

                dr.Close();

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
