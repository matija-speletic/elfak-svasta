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
using OOPr.Extensions;

namespace Aplikacija
{
    public partial class FormVozac : Form
    {
        #region Attributes
        Vozac _vozac;
        bool _trebaDodati;
        #endregion

        #region Properties

        Vozac Vozac
        {
            get { return _vozac; }
            set { _vozac = value; }
        }

        #endregion

        #region Constructors

        public FormVozac()
        {
            InitializeComponent();
            Vozac = new Vozac();
            _trebaDodati = true;
        }

        public FormVozac(Vozac v)
        {
            InitializeComponent();
            Vozac = v;
            _trebaDodati = false;
            UcitajUKontrole();
        }

        #endregion

        #region Methods

        private void UcitajUKontrole()
        {
            tbIme.Text = Vozac.Ime;
            tbPrezime.Text = Vozac.Prezime;
            dtpDatumRodjenja.Value = Vozac.DatumRodjenja;
            dtpVazenjeOd.Value = Vozac.VazanjeDozvoleOd;
            dtpVazenjeDo.Value = Vozac.VazenjeDozvoleDo;
            tbBrDozvole.Text = Vozac.BrojVozackeDozole;
            tbMestoIzdavanja.Text = Vozac.MestoIzdavanja;
            cbxPol.SelectedIndex = cbxPol.Items.IndexOf(Vozac.Pol);
            pbSlika.ImageLocation = Vozac.SlikaPath;
            pbSlika.Image = Image.FromFile(Vozac.SlikaPath);
            UcitajPodatkeKategorije();
            UcitajPodatkeZabrane();
        }

        private void UcitajPodatkeKategorije()
        {
            dgvKategorije.DataSource = Vozac.KategorijeVozaca.ToList();
            dgvKategorije.Columns["DatumOd"].Visible = false;
            dgvKategorije.Columns["DatumDo"].Visible = false;
        }

        private void UcitajPodatkeZabrane()
        {
            dgvZabrane.DataSource = Vozac.ZabraneVozaca.ToList();
            dgvZabrane.Columns["DatumOd"].Visible = false;
            dgvZabrane.Columns["DatumDo"].Visible = false;
        }

        private bool ProveraPodataka()
        {
            if (string.IsNullOrEmpty(tbIme.Text))
            {
                Upozori("Niste uneli ime.");
                return false;
            }
            if (string.IsNullOrEmpty(tbPrezime.Text))
            {
                Upozori("Niste uneli prezime.");
                return false;
            }
            if (dtpDatumRodjenja.Value.Date >= DateTime.Now.Date || dtpDatumRodjenja.Value.Year < 1800)
            {
                Upozori("Datum rodjenja nije validan.");
                return false;
            }
            if (dtpVazenjeOd.Value.Date > DateTime.Now.Date || dtpVazenjeOd.Value.Year < 1800)
            {
                Upozori("Datum od koga vazi dozvola nije validan.");
                return false;
            }
            if (dtpVazenjeDo.Value.Date < DateTime.Now.Date)
            {
                Upozori("Datum do koga vazi dozvola nije validan.");
                return false;
            }
            if (string.IsNullOrEmpty(tbBrDozvole.Text))
            {
                Upozori("Niste uneli broj dozvole.");
                return false;
            }
            if (string.IsNullOrEmpty(tbMestoIzdavanja.Text))
            {
                Upozori("Niste uneli mesto izdavanja");
                return false;
            }
            if (cbxPol.SelectedItem == null)
            {
                Upozori("Niste uneli pol.");
                return false;
            }
            if (pbSlika.Image == null)
            {
                Upozori("Niste izabrali sliku.");
                return false;
            }
            if (dgvKategorije.RowCount == 0)
            {
                Upozori("Vozac mora da ima bar jednu kategoriju.");
                return false;
            }
            return true;
        }

        private void Upozori(string poruka)
        {
            MessageBox.Show(poruka, "Upozorenje", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        }

        private bool Dodaj()
        {
            Vozac.Ime = tbIme.Text;
            Vozac.Prezime = tbPrezime.Text;
            Vozac.DatumRodjenja = dtpDatumRodjenja.Value;
            Vozac.VazanjeDozvoleOd = dtpVazenjeOd.Value;
            Vozac.VazenjeDozvoleDo = dtpVazenjeDo.Value;
            Vozac.BrojVozackeDozole = tbBrDozvole.Text;
            Vozac.MestoIzdavanja = tbMestoIzdavanja.Text;
            Vozac.Pol = (string)cbxPol.SelectedItem;
            Vozac.SlikaPath = pbSlika.ImageLocation;
            return ListaVozaca.Instance.DodajVozaca(Vozac);
        }

        private void Izmeni()
        {
            Vozac.Ime = tbIme.Text;
            Vozac.Prezime = tbPrezime.Text;
            Vozac.DatumRodjenja = dtpDatumRodjenja.Value;
            Vozac.VazanjeDozvoleOd = dtpVazenjeOd.Value;
            Vozac.VazenjeDozvoleDo = dtpVazenjeDo.Value;
            Vozac.BrojVozackeDozole = tbBrDozvole.Text;
            Vozac.MestoIzdavanja = tbMestoIzdavanja.Text;
            Vozac.Pol = (string)cbxPol.SelectedItem;
            Vozac.SlikaPath = pbSlika.ImageLocation;
        }

        #endregion

        #region EventHandlers
        private void btnZatvori_Click(object sender, EventArgs e)
        {
            this.DialogResult = DialogResult.Cancel;
            this.Close();
            
        }

        private void btnProsledi_Click(object sender, EventArgs e)
        {
            if (!ProveraPodataka())
                return;
            if (_trebaDodati)
            {
                if (!Dodaj())
                {
                    MessageBox.Show("Dodavanje vozaca nije uspelo!","Greska",MessageBoxButtons.OK,MessageBoxIcon.Error);
                    return;
                }
            }
            else
            {
                Izmeni();
            }
            DialogResult = DialogResult.OK;
            this.Close();
            
        }

        private void tbImePrezime_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!char.IsLetter(e.KeyChar) && !char.IsControl(e.KeyChar))
                e.Handled = true;
        }

        private void tbBrDozvole_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!char.IsDigit(e.KeyChar))
                e.Handled = true;
        }

        private void btnDodajSliku_Click(object sender, EventArgs e)
        {
            if (ofdDodajSliku.ShowDialog() == DialogResult.Cancel)
                return;
            pbSlika.ImageLocation = ofdDodajSliku.FileName;
            pbSlika.Image = Image.FromFile(ofdDodajSliku.FileName);
            MessageBox.Show("Slika je uspesno dodata", "Obavestenje", MessageBoxButtons.OK, MessageBoxIcon.Information);
        }

        private void btnObrisiKategoriju_Click(object sender, EventArgs e)
        {
            if (dgvKategorije.SelectedRows.Count == 0 || dgvKategorije.SelectedRows.Count > 1)
            {
                MessageBox.Show("Izaberite kategoriju za brisanje.", "Obavestenje", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            int selectedRow = dgvKategorije.SelectedRows[0].Index;
            string naziv = (string)dgvKategorije["Naziv", selectedRow].Value;
            if (Vozac.ObrisiKategoriju(naziv))
            {
                UcitajPodatkeKategorije();
                MessageBox.Show("Kategorija uspesno obrisana", "Obavestenje", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            else
                MessageBox.Show("Brisanje nije uspelo", "Upozorenje", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        }

        private void btnObrisiZabranu_Click(object sender, EventArgs e)
        {
            if (dgvZabrane.SelectedRows.Count == 0 || dgvZabrane.SelectedRows.Count > 1)
            {
                MessageBox.Show("Izaberite zabranu za brisanje.", "Obavestenje", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            int selectedRow = dgvZabrane.SelectedRows[0].Index;
            string naziv = (string)dgvZabrane["Naziv", selectedRow].Value;
            if (Vozac.ObrisiZabranu(naziv))
            {
                UcitajPodatkeZabrane();
                MessageBox.Show("Zabrana uspesno obrisana", "Obavestenje", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            else
                MessageBox.Show("Brisanje nije uspelo", "Upozorenje", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        }

        private void btnDodajKategoriju_Click(object sender, EventArgs e)
        {
            FormKategorija frm = new FormKategorija(TipDijaloga.Kategorija, Vozac);
            if (frm.ShowDialog() == DialogResult.OK)
            {
                UcitajPodatkeKategorije();
                MessageBox.Show("Kategorija uspesno dodata", "Obavestenje", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void btnDodajZabranu_Click(object sender, EventArgs e)
        {
            FormKategorija frm = new FormKategorija(TipDijaloga.Zabrana, Vozac);
            if (frm.ShowDialog() == DialogResult.OK)
            {
                UcitajPodatkeZabrane();
                MessageBox.Show("Zabrana uspesno dodata", "Obavestenje", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void FormVozac_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (MessageBox.Show("Da li ste sigurni da zelite da prekinete unos?", "Obavestenje", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.No)
                e.Cancel = true;
        }

        private void tbIme_Leave(object sender, EventArgs e)
        {
            tbIme.Text = tbIme.Text.PostaviPrvoVelikoSlovo();
        }

        private void tbPrezime_Leave(object sender, EventArgs e)
        {
            tbPrezime.Text = tbPrezime.Text.PostaviPrvoVelikoSlovo();
        }

        private void tbMestoIzdavanja_Leave(object sender, EventArgs e)
        {
            tbMestoIzdavanja.Text = tbMestoIzdavanja.Text.PostaviPrvoVelikoSlovo();
        }
        #endregion
    }
}
