using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;

namespace OOPr.Podaci
{
    public class ListaVozaca
    {
        public delegate void SortDelagate(List<Vozac> lista);
        [XmlIgnore]
        public SortDelagate SortListDelegate { get; set; }

        #region Attributes

        private List<Vozac> _listaVozaca;

        #endregion

        #region Properties

        public List<Vozac> ListaVozacaValues
        {
            get { return _listaVozaca; }
        }

        #endregion

        #region Constructors

        private ListaVozaca()
        {
            _listaVozaca = new List<Vozac>();
            
        }

        #endregion

        #region Methodes

        public bool PostojiVozacUListi(Vozac v)
        {
            foreach (var a in _listaVozaca)
                if (v.BrojVozackeDozole == a.BrojVozackeDozole)
                    return true;
            return false;
        }

        public bool DodajVozaca(Vozac v)
        {
            if (PostojiVozacUListi(v))
                return false;
            _listaVozaca.Add(v);
            return true;
        }

        public bool ObrisiVozaca(Vozac v)
        {
            if (!PostojiVozacUListi(v))
                return false;
            _listaVozaca.Remove(v);
            return true;
        }

        public Vozac GetVozac(string brojVozackeDozvole)
        {
            foreach (var a in _listaVozaca)
                if (a.BrojVozackeDozole == brojVozackeDozvole)
                    return a;
            return null;
        }

        public void SortListValue()
        {
            if (SortListDelegate != null)
                SortListDelegate(_listaVozaca);
        }

        //Ucitavanje i upis u tekstualni (nepotrebno ako se koristi xml)
        //public void SacuvajListuVozaca(StreamWriter sw)
        //{
        //    sw.WriteLine(ListaVozacaValues.Count);
        //    foreach (Vozac v in ListaVozacaValues)
        //        v.SacuvajVozaca(sw);
        //}

        //public void UcitajListuVozaca(StreamReader sr)
        //{
        //    int brojVozaca = int.Parse(sr.ReadLine());
        //    _listaVozaca = new List<Vozac>(brojVozaca);
        //    for (int i=0;i<brojVozaca;i++)
        //    {
        //        Vozac v = new Vozac();
        //        v.UcitajVozaca(sr);
        //        _listaVozaca.Add(v);
        //    }
        //}

        public void SacuvajListuVozacaXML(string filepath)
        {
            XmlSerializer writer = new XmlSerializer(typeof(ListaVozaca));
            FileStream file = File.Create(filepath);
            writer.Serialize(file, this);
            file.Close();
        }

        public void UcitajListuVozacaXML(string filepath)
        {
            XmlSerializer reader = new XmlSerializer(typeof(ListaVozaca));
            StreamReader sr = new StreamReader(filepath);
            _listaVozaca = ((ListaVozaca)reader.Deserialize(sr)).ListaVozacaValues;
            sr.Close();
        }

        #endregion

        private static ListaVozaca _instance = null;
        public static ListaVozaca Instance
        {
            get
            {
                if (_instance == null)
                    _instance = new ListaVozaca();
                return _instance;
            }
        }
    }
}
