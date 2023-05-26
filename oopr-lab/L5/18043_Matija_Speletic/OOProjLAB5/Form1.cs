using OOProjLAB5.Properties;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Resources;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace OOProjLAB5
{
    public partial class Form1 : Form
    {
        Potez _aktivniPotez;
        int _brojPoena;
        int _selektovanaKartaIndex;
        Spil _spil;

        public Form1()
        {
            InitializeComponent();
            btnProvera.Enabled = false;
            btnZameni.Enabled = false;
            _spil = new Spil();
            _selektovanaKartaIndex = -1;
        }

        void PrikaziKarte()
        {
            ResourceManager resourceManager = Resources.ResourceManager;
            pbKarta1.Image = (Bitmap)resourceManager.GetObject(_aktivniPotez.KarteURuci[0].NazivSlikeKarte);
            pbKarta2.Image = (Bitmap)resourceManager.GetObject(_aktivniPotez.KarteURuci[1].NazivSlikeKarte);
            pbKarta3.Image = (Bitmap)resourceManager.GetObject(_aktivniPotez.KarteURuci[2].NazivSlikeKarte);
            pbKarta4.Image = (Bitmap)resourceManager.GetObject(_aktivniPotez.KarteURuci[3].NazivSlikeKarte);
            pbKarta5.Image = (Bitmap)resourceManager.GetObject(_aktivniPotez.KarteURuci[4].NazivSlikeKarte);
        }

        private void btnUzmiKarte_Click(object sender, EventArgs e)
        {
            if(numBrojPoena.Value==0||numUlog.Value==0||numUlog.Value>numBrojPoena.Value)
            {
                MessageBox.Show("Morate uneti validan broj poena i ulog!");
                return;
            }
            numBrojPoena.Enabled = false;
            _brojPoena = (int)numBrojPoena.Value;
            _aktivniPotez = new Potez(_brojPoena, (int)numUlog.Value, _spil);
            PrikaziKarte();
            btnUzmiKarte.Enabled = false;
            btnProvera.Enabled = true;
            btnZameni.Enabled = true;
            _selektovanaKartaIndex = -1;
        }

        private void pbKarta1_Click(object sender, EventArgs e)
        {
            _selektovanaKartaIndex = int.Parse(((PictureBox)sender).Tag.ToString()) - 1;
        }

        private void btnZameni_Click(object sender, EventArgs e)
        {
            if(_selektovanaKartaIndex==-1)
            {
                MessageBox.Show("Morate selektovati kartu!");
                return;
            }
            if(!_aktivniPotez.ZameniKartu(_selektovanaKartaIndex))
            {
                MessageBox.Show("Dostigli ste maksimalan broj zamena!");
                btnZameni.Enabled = false;
                return;
            }
            PrikaziKarte();
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }

        private void btnProvera_Click(object sender, EventArgs e)
        {
            if(_aktivniPotez==null)
            {
                MessageBox.Show("Doslo je do greske: Karte nisu ucitane");
                return;
            }
            int osvojeniPoeni;
            Evaluacija.Multiplikator osvojenaRuka;
            _aktivniPotez.Provera(out osvojenaRuka,out  _brojPoena, out osvojeniPoeni);
            numBrojPoena.Value = _brojPoena;
            MessageBox.Show("Imate ruku: " + osvojenaRuka.ToString() + " i osvojili ste " + osvojeniPoeni + " poena!");
            btnProvera.Enabled = false;
            btnUzmiKarte.Enabled = true;
            btnZameni.Enabled = false;
            if (_brojPoena <= 0)
            {
                MessageBox.Show("Izgubili ste sve poene!");
                this.Close();
            }
        }
    }
}
