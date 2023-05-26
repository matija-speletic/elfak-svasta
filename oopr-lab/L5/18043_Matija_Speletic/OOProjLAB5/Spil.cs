using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OOProjLAB5
{
    class Spil
    {
        private List<Karta> _spil;

        public Spil()
        {
            _spil = new List<Karta>(52);
            for (int i = 0; i < 4; i++)
            {
                for (int j = 1; j < 14; j++)
                {
                    _spil.Add(new Karta(i, j));
                }
            }
        }

        public void PromesajKarte()
        {
            Random rnd = new Random();
            _spil=_spil.OrderBy(karta => rnd.Next()).ToList();
        }

        public List<Karta> UzmiNKarata(int n)
        {
            PromesajKarte();
            List<Karta> ret = _spil.Take(n).ToList();
            return ret;
        }

        public Karta UzmiKartu()
        {
            return UzmiNKarata(1)[0];
        }
    }
}
