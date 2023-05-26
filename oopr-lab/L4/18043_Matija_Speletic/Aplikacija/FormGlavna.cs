using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using  OOPr.Podaci;

namespace Aplikacija
{
    public partial class FormaGlavna : Form
    {
        public FormaGlavna()
        {
            InitializeComponent();
            tmrTacnoVreme.Start();
        }

        #region Methodes

        DialogResult ZatvoriFormu()
        {
            return MessageBox.Show("Da li ste sigurni da zelite da izadjete?",
                                   "Obavestenje",
                                   MessageBoxButtons.YesNo,
                                   MessageBoxIcon.Question);
        }

        void UcitajPodatke()
        {

            dgvListaVozaca.DataSource = ListaVozaca.Instance.ListaVozacaValues.ToList();
            dgvListaVozaca.Columns["DatumRodjenja"].Visible = false;
            dgvListaVozaca.Columns["VazanjeDozvoleOd"].Visible = false;
            dgvListaVozaca.Columns["VazenjeDozvoleDo"].Visible = false;
            dgvListaVozaca.Columns["MestoIzdavanja"].Visible = false;
            dgvListaVozaca.Columns["Pol"].Visible = false;
            dgvListaVozaca.Columns["SlikaPath"].Visible = false;
            if (dgvListaVozaca.RowCount > 0)
            {
                btnObrisi.Visible = true;
                btnIzmeni.Visible = true;
            }
            else
            {
                btnObrisi.Visible = false;
                btnIzmeni.Visible = false;
            }
        }

        #endregion

        #region EventHandlers

        private void btnSortiraj_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(cmbParametarSortiranja.Text))
                MessageBox.Show("Morate izabrati paramtar sortiranja!", "Upozorenje", MessageBoxButtons.OK,MessageBoxIcon.Warning);
            else
            {
                ListaVozaca.Instance.SortListValue();
                UcitajPodatke();
                MessageBox.Show("Lista je sortirana!", "Obavestenje", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void cmbParametarSortiranja_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cmbParametarSortiranja.Text == "Broj vozacke dozvole")
                ListaVozaca.Instance.SortListDelegate = (lista) => lista.Sort((a, b) => int.Parse(a.BrojVozackeDozole).CompareTo(int.Parse(b.BrojVozackeDozole)));
            else if (cmbParametarSortiranja.Text == "Ime")
                ListaVozaca.Instance.SortListDelegate = (lista) => lista.Sort((a, b) => a.Ime.CompareTo(b.Ime));
            else if (cmbParametarSortiranja.Text == "Prezime")
                ListaVozaca.Instance.SortListDelegate = (lista) => lista.Sort((a, b) => a.Prezime.CompareTo(b.Prezime));
        }

        private void FormaGlavna_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (ZatvoriFormu() == DialogResult.No)
                e.Cancel = true;
        }

        private void FormaGlavna_Load(object sender, EventArgs e)
        {
            lblTacnoVreme.Text = String.Empty;
            tmrTacnoVreme.Start();
            UcitajPodatke();
        }

        private void tmrTacnoVreme_Tick(object sender, EventArgs e)
        {
            String str = DateTime.Now.ToString("HH:mm:ss dd.MM.yyyy.");
            lblTacnoVreme.Text = str;
        }

        private void btnDodaj_Click(object sender, EventArgs e)
        {
            FormVozac frm = new FormVozac();
            if (frm.ShowDialog() == DialogResult.OK)
                UcitajPodatke();
        }

        private void btnIzmeni_Click(object sender, EventArgs e)
        {
            if (dgvListaVozaca.SelectedRows.Count == 0)
                return;
            int selectedRow = dgvListaVozaca.SelectedRows[0].Index;
            string brojDozvole = (string)dgvListaVozaca["BrojVozackeDozole", selectedRow].Value;
            ListaVozaca.Instance.GetVozac(brojDozvole);
            FormVozac frm = new FormVozac(ListaVozaca.Instance.GetVozac(brojDozvole));
            DialogResult dr = frm.ShowDialog();
            if (dr == DialogResult.OK)
                UcitajPodatke();
        }

        private void btnObrisi_Click(object sender, EventArgs e)
        {
            if (dgvListaVozaca.SelectedRows.Count == 0)
                return;
            int selectedRow = dgvListaVozaca.SelectedRows[0].Index;
            string brojDozvole = (string)dgvListaVozaca["BrojVozackeDozole", selectedRow].Value;
            Vozac v=ListaVozaca.Instance.GetVozac(brojDozvole);
            if(v!=null)
            {
                ListaVozaca.Instance.ObrisiVozaca(v);
                UcitajPodatke();
                MessageBox.Show("Vozac je obrisan!", "Obavestenje", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            else
                MessageBox.Show("Brisanje nije uspelo", "Obavestenje", MessageBoxButtons.OK, MessageBoxIcon.Information);
        }

        private void openToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (ofdOtvori.ShowDialog() == DialogResult.OK)
            {
                ListaVozaca.Instance.UcitajListuVozacaXML(ofdOtvori.FileName);
                UcitajPodatke();
                MessageBox.Show("Podaci su uspesno ucitani!", "Obavestenje", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void saveToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if(sfdSacuvaj.ShowDialog()==DialogResult.OK)
            {
                ListaVozaca.Instance.SacuvajListuVozacaXML(sfdSacuvaj.FileName);
                MessageBox.Show("Podaci su uspesno sacuvani u fajl "+sfdSacuvaj.FileName, "Obavestenje", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        #endregion
    }
}
