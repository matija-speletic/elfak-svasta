using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Oracle.ManagedDataAccess.Client;


namespace AzuriranjePrvaAplikacijaV2
{
    class Program
    {
        static void Main(string[] args)
        {
            /*      OPIS FUNKCIONISANJA APLIKACIJE:
             *      Aplikacija sluzi za premestanje instruktora sa jednog kursa 
             *      na drugi. Korisnik unosi ime i prezime instruktora, naziv i 
             *      nivo kursa sa kog instruktor treba da se prebaci i naziv i 
             *      nivo kursa na koji instruktor treba da se prebaci. (Ovo se 
             *      vrsi azuriranjem tabele PREDAJE)
             *      
             */


            OracleConnection con = null;
            //konekcioni string
            string conString = "Data Source = 160.99.12.92/GISLAB_PD; User Id = S18043; Password = pepeletvor;";

            try
            {
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

                //otvaranje konekcije ka bazi podataka
                con = new OracleConnection(conString);
                con.Open();

                //pripremanje komande koja ce za zadate vrednosti da izmeni
                //odgovarajuci podatak u tabeli
                //s obzirom da je u pitanju duzi upit, pogodnije je koristiti klasu StringBuilder
                StringBuilder strSQL = new StringBuilder();

                //naredba za azuriranje podataka br.2 iz faze6
                //ovde je demonstrirana upotreba i parametara i konkatenacije
                strSQL.Append("UPDATE PREDAJE ");
                strSQL.Append(" SET ID_KURSA=(SELECT ID_BROJ FROM KURS ");
                strSQL.Append(" WHERE NAZIV = :nazivNovog AND NIVO = :nivoNovog ) ");
                strSQL.Append(" WHERE ID_KURSA=(SELECT ID_BROJ FROM KURS "); 
                strSQL.Append(" WHERE NAZIV= :nazivTrenutnog AND NIVO = :nivoTrenutnog ) ");
                strSQL.Append(" AND ID_INSTRUKTORA=(SELECT ID_BROJ FROM INSTRUKTOR ");
                strSQL.Append(" WHERE LIME = :ime AND PREZIME = :prez )");

                OracleCommand cmd = new OracleCommand(strSQL.ToString(), con);
                cmd.CommandType = System.Data.CommandType.Text;

                //kreiranje parametra 
                OracleParameter paramIme = new OracleParameter("ime", OracleDbType.Varchar2);
                paramIme.Value = ime;
                OracleParameter paramPrez = new OracleParameter("prez", OracleDbType.Varchar2);
                paramPrez.Value = prez;
                OracleParameter paramNazivN = new OracleParameter("nazivNovog", OracleDbType.Varchar2);
                paramNazivN.Value = nazivNovog;
                OracleParameter paramNivoN = new OracleParameter("nivoNovog", OracleDbType.Varchar2);
                paramNivoN.Value = nivoNovog;
                OracleParameter paramNazivT = new OracleParameter("nazivTrenutnog", OracleDbType.Varchar2);
                paramNazivT.Value = nazivTrenutnog;
                OracleParameter paramNivoT = new OracleParameter("nivoTrenutnog", OracleDbType.Varchar2);
                paramNivoT.Value = nivoTrenutnog;

                //dodavanje ovih parametara u listu
                cmd.Parameters.Add(paramNazivN);
                cmd.Parameters.Add(paramNivoN);
                cmd.Parameters.Add(paramNazivT);
                cmd.Parameters.Add(paramNivoT);
                cmd.Parameters.Add(paramIme);
                cmd.Parameters.Add(paramPrez);

                //izvrsavanje komande 
                cmd.ExecuteNonQuery();

                Console.WriteLine("Tabela je uspesno azurirana!");

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
