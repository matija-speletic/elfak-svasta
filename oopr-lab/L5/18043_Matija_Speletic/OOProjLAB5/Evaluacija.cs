using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OOProjLAB5
{
    class Evaluacija
    {
        public enum Multiplikator
        {

            StraightFlush = 100,
            FourOfAKind = 60,
            BigBobtail = 40,
            FullHouse = 24,
            Flush = 16,
            Straight = 12,
            Blaze = 9,
            ThreeOfAKind = 6,
            TwoPair = 4,
            OnePair = 2
        }

        List<Karta> _karteURuci;

        public Evaluacija(List<Karta> listaKarata)
        {
            _karteURuci = listaKarata.OrderBy(x => x.Broj).ToList();
        }

        public bool FourOfAKind()
        {

            if (_karteURuci[0].Broj == _karteURuci[1].Broj && _karteURuci[0].Broj == _karteURuci[2].Broj && _karteURuci[0].Broj == _karteURuci[3].Broj)
            {
                return true;
            }
            if (_karteURuci[1].Broj == _karteURuci[2].Broj && _karteURuci[1].Broj == _karteURuci[3].Broj && _karteURuci[1].Broj == _karteURuci[4].Broj)
            {
                return true;
            }
            return false;
        }

        public bool FullHouse()
        {
            if ((_karteURuci[0].Broj == _karteURuci[1].Broj && _karteURuci[0].Broj == _karteURuci[2].Broj && _karteURuci[3].Broj == _karteURuci[4].Broj) ||
                (_karteURuci[0].Broj == _karteURuci[1].Broj && _karteURuci[2].Broj == _karteURuci[3].Broj && _karteURuci[2].Broj == _karteURuci[4].Broj))
            {
                return true;
            }
            return false;
        }

        public bool Flush()
        {

            for (int i = 0; i < 4; i++)
            {
                if (_karteURuci[i].Boja != _karteURuci[i + 1].Boja)
                {
                    return false;
                }
            }
            return true;
        }

        public bool Straight()
        {

            for (int i = 0; i < 4; i++)
            {
                if (!(_karteURuci[i].Broj == _karteURuci[i + 1].Broj + 1))
                {
                    return false;
                }
            }
            return true;
        }

        public bool StraightFlush()
        {

            for (int i = 0; i < 4; i++)
            {
                if (!(_karteURuci[i].Broj == _karteURuci[i + 1].Broj + 1) || _karteURuci[i].Boja != _karteURuci[i + 1].Boja)
                {
                    return false;
                }
            }
            return true;
        }

        public bool ThreeOfAKind()
        {

            if ((_karteURuci[0].Broj == _karteURuci[1].Broj && _karteURuci[0].Broj == _karteURuci[2].Broj) ||
                (_karteURuci[1].Broj == _karteURuci[2].Broj && _karteURuci[1].Broj == _karteURuci[3].Broj) ||
                (_karteURuci[2].Broj == _karteURuci[3].Broj && _karteURuci[2].Broj == _karteURuci[4].Broj))
            {
                return true;
            }
            return false;
        }

        public bool TwoPair()
        {


            if (_karteURuci[0].Broj == _karteURuci[1].Broj && _karteURuci[2].Broj == _karteURuci[3].Broj)
            {
                return true;
            }
            if (_karteURuci[0].Broj == _karteURuci[1].Broj && _karteURuci[3].Broj == _karteURuci[4].Broj)
            {
                return true;
            }
            if (_karteURuci[1].Broj == _karteURuci[2].Broj && _karteURuci[3].Broj == _karteURuci[4].Broj)
            {
                return true;
            }
            return false;
        }

        public bool OnePair()
        {
            for (int i = 0; i < 4; i++)
            {
                if (_karteURuci[i].Broj == _karteURuci[i + 1].Broj)
                {
                    return true;
                }
            }
            return false;
        }

        public bool BigBobTail()
        {

            int brojPogodaka = 0;
            for (int i = 0; i < 4; i++)
            {
                if (_karteURuci[i].Broj == _karteURuci[i + 1].Broj && _karteURuci[i].Boja == _karteURuci[i + 1].Boja)
                {
                    brojPogodaka++;
                }
            }
            if (brojPogodaka == 3)
                return true;
            else
                return false;
        }

        public bool Blaze()
        {

            for (int i = 0; i < 5; i++)
            {
                if (_karteURuci[i].Broj != Broj.Zandar || _karteURuci[i].Broj != Broj.Dama || _karteURuci[i].Broj != Broj.Kralj)
                {
                    return false;
                }
            }
            return true;
        }

        public Multiplikator OdrediMultiplikator()
        {
            if (StraightFlush())
                return Multiplikator.StraightFlush;
            if (Straight())
                return Multiplikator.Straight;
            if (Flush())
                return Multiplikator.Flush;
            if (FourOfAKind())
                return Multiplikator.FourOfAKind;
            if (BigBobTail())
                return Multiplikator.BigBobtail;
            if (FullHouse())
                return Multiplikator.FullHouse;
            if (Blaze())
                return Multiplikator.Blaze;
            if (ThreeOfAKind())
                return Multiplikator.ThreeOfAKind;
            if (TwoPair())
                return Multiplikator.TwoPair;
            if (OnePair())
                return Multiplikator.OnePair;
            return 0;
        }
    }
}
