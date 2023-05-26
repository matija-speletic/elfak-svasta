using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OOProjLAB5
{
    class Potez
    {
        List<Karta> _karteURuci;
        Spil _spil;
        int _brojZamenjenih;
        int _ulog;
        int _brojPoena;

        public Potez(int brojPoena,int ulog, Spil spil)
        {
            _brojPoena = brojPoena - ulog;
            _ulog = ulog;
            _spil = spil;
            _karteURuci = _spil.UzmiNKarata(5);
            _brojZamenjenih = 0;
        }

        public List<Karta> KarteURuci
        {
            get { return _karteURuci; }
        }

        public int BrojPoena
        {
            get { return _brojPoena; }
        }

        public int Ulog
        {
            get { return _ulog; }
            set { _ulog = value; }
        }

        public void Provera(out Evaluacija.Multiplikator osvojenaRuka, out int brojPoena, out int osvojeniPoeni)
        {
            Evaluacija ev = new Evaluacija(KarteURuci);
            Evaluacija.Multiplikator multiplikator = ev.OdrediMultiplikator();
            int osvojeno = _ulog * (int)multiplikator;
            _brojPoena += osvojeno;
            osvojenaRuka = multiplikator;
            brojPoena = _brojPoena;
            osvojeniPoeni = osvojeno;
        }

        public bool ZameniKartu(int index)
        {
            if (_brojZamenjenih == 3 || index > 5 || index < 0)
                return false;
            _karteURuci[index] = _spil.UzmiKartu();
            _brojZamenjenih++;
            return true;
        }

    }
}
