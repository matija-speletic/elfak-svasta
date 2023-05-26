using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using OOPr.Podaci;

namespace Aplikacija
{
    public enum TipDijaloga { Kategorija, Zabrana }

    public partial class FormKategorija : Form
    {
        #region Constructors
        public FormKategorija(TipDijaloga tip, Vozac vozac)
        {
            InitializeComponent();
            _tip = tip;
            _vozac = vozac;
            if (_tip == TipDijaloga.Zabrana)
            {
                cbKategorija.Items.Clear();
                foreach (var kat in Vozac.KategorijeVozaca)
                    cbKategorija.Items.Add(kat.Naziv);
                Text = "Zabrana";
            }
            else
                Text = "Kategorija";
        }
        #endregion

        #region Attributes
        TipDijaloga _tip;
        Vozac _vozac;
        #endregion

        #region Properties
        public Vozac Vozac
        {
            get => _vozac;
            set => _vozac = value;
        }

        public TipDijaloga Tip
        {
            get => _tip;
            set => _tip = value;
        }
        #endregion

        #region Methods
        bool Validacija()
        {
            if (dtpVazenjeOd.Value.Date > DateTime.Now.Date || dtpVazenjeOd.Value.Year < 1800)
            {
                MessageBox.Show("Datum od koga vazi dozvola nije validan.","Upozorenje",MessageBoxButtons.OK,MessageBoxIcon.Warning);
                return false;
            }
            if (dtpVazenjeDo.Value.Date < DateTime.Now.Date)
            {
                MessageBox.Show("Datum do koga vazi dozvola nije validan.", "Upozorenje", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return false;
            }
            if(string.IsNullOrWhiteSpace(cbKategorija.Text))
            {
                MessageBox.Show("Niste izabrali kategoriju.", "Upozorenje", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return false;
            }
            return true;
        }
        void IzKontrolaUObjekat()
        {
            Kategorija k = new Kategorija(cbKategorija.Text, dtpVazenjeOd.Value, dtpVazenjeDo.Value);
            if(Tip==TipDijaloga.Kategorija)
                Vozac.KategorijeVozaca.Add(k);
            else
                Vozac.ZabraneVozaca.Add(k);
        }
        #endregion

        #region EventHandlers
        private void btnProsledi_Click(object sender, EventArgs e)
        {
            if (Validacija())
            {
                IzKontrolaUObjekat();
                DialogResult = DialogResult.OK;
                Close();
            }
        }

        private void btnZatvori_Click(object sender, EventArgs e)
        {
            DialogResult = DialogResult.Cancel;
            Close();
        }
        #endregion
    }
}
