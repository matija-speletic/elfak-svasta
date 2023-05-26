using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OOProjLAB5
{
    class Karta
    {
        public Boja Boja { get; set; }

        public Broj Broj { get; set; }

        public Karta(Boja boja, Broj broj)
        {
            Boja = boja;
            Broj = broj;
        }

        public Karta(int boja, int broj)
        {
            Boja = (Boja)boja;
            Broj = (Broj)broj;
        }

        public string NazivSlikeKarte
        {
            get
            {
                string boja="";
                string broj;
                switch (Boja)
                {
                    case Boja.Herc:
                        boja = "H";
                        break;
                    case Boja.Karo:
                        boja = "D";
                        break;
                    case Boja.Pik:
                        boja = "S";
                        break;
                    case Boja.Tref:
                        boja = "C";
                        break;
                }
                if (Broj == Broj.A)
                    broj = "A";
                else if (Broj == Broj.Zandar)
                    broj = "J";
                else if (Broj == Broj.Dama)
                    broj = "Q";
                else if (Broj == Broj.Kralj)
                    broj = "K";
                else
                    broj = ((int)Broj).ToString();
                if (Char.IsLetter(broj[0]))
                    return broj + boja;
                return "_" + broj + boja;
            }
        }
    }

    public enum Boja
    {
        Herc,
        Karo,
        Pik,
        Tref,
        Unknown
    }

    public enum Broj
    {
        Unknown = 0,
        A = 1,
        Dva = 2,
        Tri = 3,
        Cetri = 4,
        Pet = 5,
        Sest = 6,
        Sedam = 7,
        Osam = 8,
        Devet = 9,
        Deset = 10,
        Zandar = 11,
        Dama = 12,
        Kralj = 13
    }
}

