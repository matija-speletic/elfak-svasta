using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OOPr.Podaci
{
    public class Vozac
    {
        #region Attributes

        private string _ime;
        private string _prezime;
        private DateTime _datumRodjenja;
        private DateTime _vazanjeDozvoleOd;
        private DateTime _vazenjeDozvoleDo;
        private string _brojVozackeDozole;
        private string _mestoIzdavanja;
        private string _pol;
        private string _slikaPath;
        private List<Kategorija> _kategorijeVozaca;
        private List<Kategorija> _zabraneVozaca;

        #endregion

        #region Constructors

        public Vozac()
        {
            _kategorijeVozaca = new List<Kategorija>();
            _zabraneVozaca = new List<Kategorija>();
        }

        public Vozac(string _ime, string _prezime, DateTime _datumRodjenja, DateTime _vazanjeDozvoleOd, DateTime _vazenjeDozvoleDo, string _brojVozackeDozole, string _mestoIzdavanja, string _pol, string _putanjaDoSlike, List<Kategorija> _kategorijeVozaca, List<Kategorija> _zabraneVozaca)
        {
            this._ime = _ime;
            this._prezime = _prezime;
            this._datumRodjenja = _datumRodjenja;
            this._vazanjeDozvoleOd = _vazanjeDozvoleOd;
            this._vazenjeDozvoleDo = _vazenjeDozvoleDo;
            this._brojVozackeDozole = _brojVozackeDozole;
            this._mestoIzdavanja = _mestoIzdavanja;
            this._pol = _pol;
            this._slikaPath = _putanjaDoSlike;
            this._kategorijeVozaca = _kategorijeVozaca;
            this._zabraneVozaca = _zabraneVozaca;
        }

        #endregion

        #region Properties

        public string Ime
        {
            get { return _ime; }
            set { _ime = value; }
        }

        public string Prezime
        {
            get { return _prezime; }
            set { _prezime = value; }
        }

        public DateTime DatumRodjenja
        {
            get { return _datumRodjenja; }
            set { _datumRodjenja = value; }
        }

        public DateTime VazanjeDozvoleOd
        {
            get { return _vazanjeDozvoleOd; }
            set { _vazanjeDozvoleOd = value; }
        }

        public DateTime VazenjeDozvoleDo
        {
            get { return _vazenjeDozvoleDo; }
            set { _vazenjeDozvoleDo = value; }
        }

        [DisplayName("Br. vozacke dozvole")]
        public string BrojVozackeDozole
        {
            get { return _brojVozackeDozole; }
            set { _brojVozackeDozole = value; }
        }

        public string MestoIzdavanja
        {
            get { return _mestoIzdavanja; }
            set { _mestoIzdavanja = value; }
        }

        public string Pol
        {
            get { return _pol; }
            set { _pol = value; }
        }

        public string SlikaPath
        {
            get { return _slikaPath; }
            set { _slikaPath = value; }
        }

        public List<Kategorija> KategorijeVozaca
        {
            get { return _kategorijeVozaca; }
            set { _kategorijeVozaca = value; }
        }

        public List<Kategorija> ZabraneVozaca
        {
            get { return _zabraneVozaca; }
            set { _zabraneVozaca = value; }
        }

        #endregion

        #region Methods

        public bool ObrisiKategoriju(string naziv)
        {
            Kategorija zaBrisanje = null;
            foreach (var kat in KategorijeVozaca)
            {
                if (kat.Naziv == naziv)
                {
                    zaBrisanje = kat;
                    break;
                }
            }
            if (zaBrisanje == null)
                return false;
            else
            {
                KategorijeVozaca.Remove(zaBrisanje);
                return true;
            }
        }

        public bool ObrisiZabranu(string naziv)
        {
            Kategorija zaBrisanje = null;
            foreach (var kat in ZabraneVozaca)
            {
                if (kat.Naziv == naziv)
                {
                    zaBrisanje = kat;
                    break;
                }
            }
            if (zaBrisanje == null)
                return false;
            else
            {
                ZabraneVozaca.Remove(zaBrisanje);
                return true;
            }
        }

        /*//Ucitavanj i upis u tekstualni (nepotrebno ako se koristi xml)
        public void SacuvajVozaca(StreamWriter sw)
        {
            sw.WriteLine(Ime);
            sw.WriteLine(Prezime);
            sw.WriteLine(DatumRodjenja);
            sw.WriteLine(VazanjeDozvoleOd);
            sw.WriteLine(VazenjeDozvoleDo);
            sw.WriteLine(BrojVozackeDozole);
            sw.WriteLine(MestoIzdavanja);
            sw.WriteLine(Pol);
            sw.WriteLine(SlikaPath);
            sw.WriteLine(KategorijeVozaca.Count);
            foreach (Kategorija kat in KategorijeVozaca)
            {
                kat.SacuvajKategoriju(sw);
            }
            sw.WriteLine(ZabraneVozaca.Count);
            foreach (Kategorija kat in ZabraneVozaca)
            {
                kat.SacuvajKategoriju(sw);
            }
        }

        public void UcitajVozaca(StreamReader sr)
        {
            Ime = sr.ReadLine();
            Prezime = sr.ReadLine();
            DatumRodjenja = DateTime.Parse(sr.ReadLine());
            VazanjeDozvoleOd = DateTime.Parse(sr.ReadLine());
            VazenjeDozvoleDo = DateTime.Parse(sr.ReadLine());
            BrojVozackeDozole = sr.ReadLine();
            MestoIzdavanja = sr.ReadLine();
            Pol = sr.ReadLine();
            SlikaPath = sr.ReadLine();
            int brojKategorija = int.Parse(sr.ReadLine());
            KategorijeVozaca = new List<Kategorija>(brojKategorija);
            for (int i = 0; i < brojKategorija; i++)
            {
                Kategorija kategorija = new Kategorija();
                kategorija.UcitajKategoriju(sr);
                KategorijeVozaca.Add(kategorija);
            }
            int brojZabrana = int.Parse(sr.ReadLine());
            ZabraneVozaca = new List<Kategorija>(brojZabrana);
            for (int i = 0; i < brojZabrana; i++)
            {
                Kategorija zabrana = new Kategorija();
                zabrana.UcitajKategoriju(sr);
                ZabraneVozaca.Add(zabrana);
            }
        }*/
        #endregion
    }
}
