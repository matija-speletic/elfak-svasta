using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Oracle.ManagedDataAccess.Client;

namespace BrisanjePrvaAplikacija
{
    class Program
    {
        /*      OPIS FUNKCIONISANJA APLIKACIJE:
         *      Aplikacija sluzi za ispisivanje polaznika sa kursa na osnovu datuma 
         *      upisa. Korisnik unosi ime i prezime polaznika, a zatim i datum kada
         *      je polaznik ovaj kurs upisao. Na osnovu procitanih parametara, brise 
         *      se stavka u tabeli POHADJA
         */


        static void Main(string[] args)
        {
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

                //naredba za brisanje podataka broj 2 iz faze 6
                string strSQL = "DELETE FROM POHADJA WHERE JMBG_POLAZNIKA = (SELECT JMBG FROM POLAZNIK"
                        + " WHERE IME = :ime AND PREZIME = :prez ) AND DAT_UPISA LIKE '%" + datumUpisa + "%' ";

                OracleCommand cmd = new OracleCommand(strSQL, con);
                cmd.CommandType = System.Data.CommandType.Text;

                //kreiranje parametra ime i prez (ime i prezime polaznika)
                OracleParameter paramIme = new OracleParameter("ime", OracleDbType.Varchar2);
                paramIme.Value = ime;
                OracleParameter paramPrez = new OracleParameter("prez", OracleDbType.Varchar2);
                paramPrez.Value = prez;

                //dodavanje ovih parametara u listu
                cmd.Parameters.Add(paramIme);
                cmd.Parameters.Add(paramPrez);

                //izvrsavanje komande 
                cmd.ExecuteNonQuery();

                Console.WriteLine("Odgovarajuca stavka u tabeli je uspesno obrisana!");

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
