using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OOPr.Podaci
{
    public class Kategorija
    {
        #region Attributes

        private string _naziv;
        private DateTime _datumOd;
        private DateTime _datumDo;

        #endregion

        #region Constructors

        public Kategorija()
        {
        }

        public Kategorija(string naziv, DateTime datumOd, DateTime datumDo)
        {
            _naziv = naziv;
            _datumOd = datumOd;
            _datumDo = datumDo;
        }

        #endregion        
        
        #region Properties

        [DisplayName("KategorijaValue")]
        public string Naziv
        {
            get { return _naziv; }
            set { _naziv = value; }
        }

        public DateTime DatumOd
        {
            get { return _datumOd; }
            set { _datumOd = value; }
        }

        public DateTime DatumDo
        {
            get { return _datumDo; }
            set { _datumDo = value; }
        }

        public string DatumOdValue
        {
            get { return _datumOd.ToString("dd.MM.yyyy."); }
        }

        public string DatumDoValue
        {
            get { return _datumDo.ToString("dd.MM.yyyy."); }
        }

        #endregion

        #region Methods

        /*//ucitavanje i upis u tekstualni (nepotrebno ako se koristi xml)
         * 
         * public void SacuvajKategoriju(StreamWriter sw)
        {
            sw.WriteLine(Naziv);
            sw.WriteLine(DatumOd);
            sw.WriteLine(DatumDo);
        }

        public void UcitajKategoriju(StreamReader sr)
        {
            Naziv = sr.ReadLine();
            DatumOd = DateTime.Parse(sr.ReadLine());
            DatumDo = DateTime.Parse(sr.ReadLine());
        }*/

        #endregion

    }
}
