
namespace Aplikacija
{
    partial class FormVozac
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FormVozac));
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle1 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle2 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle3 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle4 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle5 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle6 = new System.Windows.Forms.DataGridViewCellStyle();
            this.gbOsnovniPodaci = new System.Windows.Forms.GroupBox();
            this.btnDodajSliku = new System.Windows.Forms.Button();
            this.pbSlika = new System.Windows.Forms.PictureBox();
            this.label8 = new System.Windows.Forms.Label();
            this.label7 = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.cbxPol = new System.Windows.Forms.ComboBox();
            this.tbMestoIzdavanja = new System.Windows.Forms.TextBox();
            this.tbBrDozvole = new System.Windows.Forms.TextBox();
            this.dtpVazenjeDo = new System.Windows.Forms.DateTimePicker();
            this.dtpVazenjeOd = new System.Windows.Forms.DateTimePicker();
            this.dtpDatumRodjenja = new System.Windows.Forms.DateTimePicker();
            this.tbPrezime = new System.Windows.Forms.TextBox();
            this.tbIme = new System.Windows.Forms.TextBox();
            this.gbKatergorija = new System.Windows.Forms.GroupBox();
            this.btnObrisiKategoriju = new System.Windows.Forms.Button();
            this.btnDodajKategoriju = new System.Windows.Forms.Button();
            this.dgvKategorije = new System.Windows.Forms.DataGridView();
            this.gbZabranaUpravljanja = new System.Windows.Forms.GroupBox();
            this.btnObrisiZabranu = new System.Windows.Forms.Button();
            this.dgvZabrane = new System.Windows.Forms.DataGridView();
            this.btnDodajZabranu = new System.Windows.Forms.Button();
            this.btnProsledi = new System.Windows.Forms.Button();
            this.btnZatvori = new System.Windows.Forms.Button();
            this.ofdDodajSliku = new System.Windows.Forms.OpenFileDialog();
            this.gbOsnovniPodaci.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pbSlika)).BeginInit();
            this.gbKatergorija.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvKategorije)).BeginInit();
            this.gbZabranaUpravljanja.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvZabrane)).BeginInit();
            this.SuspendLayout();
            // 
            // gbOsnovniPodaci
            // 
            this.gbOsnovniPodaci.Controls.Add(this.btnDodajSliku);
            this.gbOsnovniPodaci.Controls.Add(this.pbSlika);
            this.gbOsnovniPodaci.Controls.Add(this.label8);
            this.gbOsnovniPodaci.Controls.Add(this.label7);
            this.gbOsnovniPodaci.Controls.Add(this.label6);
            this.gbOsnovniPodaci.Controls.Add(this.label5);
            this.gbOsnovniPodaci.Controls.Add(this.label4);
            this.gbOsnovniPodaci.Controls.Add(this.label3);
            this.gbOsnovniPodaci.Controls.Add(this.label2);
            this.gbOsnovniPodaci.Controls.Add(this.label1);
            this.gbOsnovniPodaci.Controls.Add(this.cbxPol);
            this.gbOsnovniPodaci.Controls.Add(this.tbMestoIzdavanja);
            this.gbOsnovniPodaci.Controls.Add(this.tbBrDozvole);
            this.gbOsnovniPodaci.Controls.Add(this.dtpVazenjeDo);
            this.gbOsnovniPodaci.Controls.Add(this.dtpVazenjeOd);
            this.gbOsnovniPodaci.Controls.Add(this.dtpDatumRodjenja);
            this.gbOsnovniPodaci.Controls.Add(this.tbPrezime);
            this.gbOsnovniPodaci.Controls.Add(this.tbIme);
            this.gbOsnovniPodaci.Location = new System.Drawing.Point(12, 12);
            this.gbOsnovniPodaci.Name = "gbOsnovniPodaci";
            this.gbOsnovniPodaci.Size = new System.Drawing.Size(459, 244);
            this.gbOsnovniPodaci.TabIndex = 0;
            this.gbOsnovniPodaci.TabStop = false;
            this.gbOsnovniPodaci.Text = "Osnovni podaci";
            // 
            // btnDodajSliku
            // 
            this.btnDodajSliku.Location = new System.Drawing.Point(311, 155);
            this.btnDodajSliku.Name = "btnDodajSliku";
            this.btnDodajSliku.Size = new System.Drawing.Size(75, 23);
            this.btnDodajSliku.TabIndex = 16;
            this.btnDodajSliku.Text = "Dodaj sliku";
            this.btnDodajSliku.UseVisualStyleBackColor = true;
            this.btnDodajSliku.Click += new System.EventHandler(this.btnDodajSliku_Click);
            // 
            // pbSlika
            // 
            this.pbSlika.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Zoom;
            this.pbSlika.Location = new System.Drawing.Point(287, 19);
            this.pbSlika.Name = "pbSlika";
            this.pbSlika.Size = new System.Drawing.Size(130, 130);
            this.pbSlika.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.pbSlika.TabIndex = 16;
            this.pbSlika.TabStop = false;
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Location = new System.Drawing.Point(114, 204);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(25, 13);
            this.label8.TabIndex = 14;
            this.label8.Text = "Pol:";
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(54, 178);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(87, 13);
            this.label7.TabIndex = 12;
            this.label7.Text = "Mesto izdavanja:";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(34, 152);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(107, 13);
            this.label6.TabIndex = 10;
            this.label6.Text = "Br. vozacke dozvole:";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(122, 129);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(19, 13);
            this.label5.TabIndex = 8;
            this.label5.Text = "do";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(41, 103);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(100, 13);
            this.label4.TabIndex = 6;
            this.label4.Text = "Vazenje dozvole od";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(63, 71);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(78, 13);
            this.label3.TabIndex = 4;
            this.label3.Text = "Datum rodjenja";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(94, 48);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(47, 13);
            this.label2.TabIndex = 2;
            this.label2.Text = "Prezime:";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(114, 22);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(27, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Ime:";
            // 
            // cbxPol
            // 
            this.cbxPol.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbxPol.FormattingEnabled = true;
            this.cbxPol.Items.AddRange(new object[] {
            "M",
            "Z"});
            this.cbxPol.Location = new System.Drawing.Point(147, 201);
            this.cbxPol.Name = "cbxPol";
            this.cbxPol.Size = new System.Drawing.Size(117, 21);
            this.cbxPol.TabIndex = 15;
            // 
            // tbMestoIzdavanja
            // 
            this.tbMestoIzdavanja.Location = new System.Drawing.Point(147, 175);
            this.tbMestoIzdavanja.Name = "tbMestoIzdavanja";
            this.tbMestoIzdavanja.Size = new System.Drawing.Size(117, 20);
            this.tbMestoIzdavanja.TabIndex = 13;
            this.tbMestoIzdavanja.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.tbImePrezime_KeyPress);
            this.tbMestoIzdavanja.Leave += new System.EventHandler(this.tbMestoIzdavanja_Leave);
            // 
            // tbBrDozvole
            // 
            this.tbBrDozvole.Location = new System.Drawing.Point(147, 149);
            this.tbBrDozvole.Name = "tbBrDozvole";
            this.tbBrDozvole.Size = new System.Drawing.Size(117, 20);
            this.tbBrDozvole.TabIndex = 11;
            this.tbBrDozvole.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.tbBrDozvole_KeyPress);
            // 
            // dtpVazenjeDo
            // 
            this.dtpVazenjeDo.CustomFormat = "dd.MM.yyyy.";
            this.dtpVazenjeDo.Format = System.Windows.Forms.DateTimePickerFormat.Custom;
            this.dtpVazenjeDo.Location = new System.Drawing.Point(147, 123);
            this.dtpVazenjeDo.Name = "dtpVazenjeDo";
            this.dtpVazenjeDo.Size = new System.Drawing.Size(117, 20);
            this.dtpVazenjeDo.TabIndex = 9;
            // 
            // dtpVazenjeOd
            // 
            this.dtpVazenjeOd.CustomFormat = "dd.MM.yyyy.";
            this.dtpVazenjeOd.Format = System.Windows.Forms.DateTimePickerFormat.Custom;
            this.dtpVazenjeOd.Location = new System.Drawing.Point(147, 97);
            this.dtpVazenjeOd.Name = "dtpVazenjeOd";
            this.dtpVazenjeOd.Size = new System.Drawing.Size(117, 20);
            this.dtpVazenjeOd.TabIndex = 7;
            // 
            // dtpDatumRodjenja
            // 
            this.dtpDatumRodjenja.CustomFormat = "dd.MM.yyyy.";
            this.dtpDatumRodjenja.Format = System.Windows.Forms.DateTimePickerFormat.Custom;
            this.dtpDatumRodjenja.Location = new System.Drawing.Point(147, 71);
            this.dtpDatumRodjenja.Name = "dtpDatumRodjenja";
            this.dtpDatumRodjenja.Size = new System.Drawing.Size(117, 20);
            this.dtpDatumRodjenja.TabIndex = 5;
            // 
            // tbPrezime
            // 
            this.tbPrezime.Location = new System.Drawing.Point(147, 45);
            this.tbPrezime.Name = "tbPrezime";
            this.tbPrezime.Size = new System.Drawing.Size(117, 20);
            this.tbPrezime.TabIndex = 3;
            this.tbPrezime.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.tbImePrezime_KeyPress);
            this.tbPrezime.Leave += new System.EventHandler(this.tbPrezime_Leave);
            // 
            // tbIme
            // 
            this.tbIme.Location = new System.Drawing.Point(147, 19);
            this.tbIme.Name = "tbIme";
            this.tbIme.Size = new System.Drawing.Size(117, 20);
            this.tbIme.TabIndex = 1;
            this.tbIme.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.tbImePrezime_KeyPress);
            this.tbIme.Leave += new System.EventHandler(this.tbIme_Leave);
            // 
            // gbKatergorija
            // 
            this.gbKatergorija.Controls.Add(this.btnObrisiKategoriju);
            this.gbKatergorija.Controls.Add(this.btnDodajKategoriju);
            this.gbKatergorija.Controls.Add(this.dgvKategorije);
            this.gbKatergorija.Location = new System.Drawing.Point(12, 262);
            this.gbKatergorija.Name = "gbKatergorija";
            this.gbKatergorija.Size = new System.Drawing.Size(459, 200);
            this.gbKatergorija.TabIndex = 1;
            this.gbKatergorija.TabStop = false;
            this.gbKatergorija.Text = "Kategorija";
            // 
            // btnObrisiKategoriju
            // 
            this.btnObrisiKategoriju.Image = global::Aplikacija.Properties.Resources.broom2;
            this.btnObrisiKategoriju.Location = new System.Drawing.Point(332, 143);
            this.btnObrisiKategoriju.Name = "btnObrisiKategoriju";
            this.btnObrisiKategoriju.Size = new System.Drawing.Size(121, 51);
            this.btnObrisiKategoriju.TabIndex = 2;
            this.btnObrisiKategoriju.Text = "Obrisi kategoriju";
            this.btnObrisiKategoriju.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageBeforeText;
            this.btnObrisiKategoriju.UseVisualStyleBackColor = true;
            this.btnObrisiKategoriju.Click += new System.EventHandler(this.btnObrisiKategoriju_Click);
            // 
            // btnDodajKategoriju
            // 
            this.btnDodajKategoriju.Image = ((System.Drawing.Image)(resources.GetObject("btnDodajKategoriju.Image")));
            this.btnDodajKategoriju.Location = new System.Drawing.Point(6, 143);
            this.btnDodajKategoriju.Name = "btnDodajKategoriju";
            this.btnDodajKategoriju.Size = new System.Drawing.Size(133, 51);
            this.btnDodajKategoriju.TabIndex = 1;
            this.btnDodajKategoriju.Text = "Dodaj novu kategoriju";
            this.btnDodajKategoriju.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.btnDodajKategoriju.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageBeforeText;
            this.btnDodajKategoriju.UseVisualStyleBackColor = true;
            this.btnDodajKategoriju.Click += new System.EventHandler(this.btnDodajKategoriju_Click);
            // 
            // dgvKategorije
            // 
            this.dgvKategorije.BackgroundColor = System.Drawing.Color.White;
            dataGridViewCellStyle1.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle1.BackColor = System.Drawing.SystemColors.Control;
            dataGridViewCellStyle1.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle1.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle1.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle1.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle1.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.dgvKategorije.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle1;
            this.dgvKategorije.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            dataGridViewCellStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle2.BackColor = System.Drawing.SystemColors.Window;
            dataGridViewCellStyle2.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle2.ForeColor = System.Drawing.SystemColors.ControlText;
            dataGridViewCellStyle2.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle2.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle2.WrapMode = System.Windows.Forms.DataGridViewTriState.False;
            this.dgvKategorije.DefaultCellStyle = dataGridViewCellStyle2;
            this.dgvKategorije.Location = new System.Drawing.Point(6, 19);
            this.dgvKategorije.Name = "dgvKategorije";
            this.dgvKategorije.ReadOnly = true;
            dataGridViewCellStyle3.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle3.BackColor = System.Drawing.SystemColors.Control;
            dataGridViewCellStyle3.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle3.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle3.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle3.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle3.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.dgvKategorije.RowHeadersDefaultCellStyle = dataGridViewCellStyle3;
            this.dgvKategorije.RowHeadersVisible = false;
            this.dgvKategorije.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgvKategorije.Size = new System.Drawing.Size(447, 118);
            this.dgvKategorije.TabIndex = 0;
            // 
            // gbZabranaUpravljanja
            // 
            this.gbZabranaUpravljanja.Controls.Add(this.btnObrisiZabranu);
            this.gbZabranaUpravljanja.Controls.Add(this.dgvZabrane);
            this.gbZabranaUpravljanja.Controls.Add(this.btnDodajZabranu);
            this.gbZabranaUpravljanja.Location = new System.Drawing.Point(12, 468);
            this.gbZabranaUpravljanja.Name = "gbZabranaUpravljanja";
            this.gbZabranaUpravljanja.Size = new System.Drawing.Size(459, 202);
            this.gbZabranaUpravljanja.TabIndex = 2;
            this.gbZabranaUpravljanja.TabStop = false;
            this.gbZabranaUpravljanja.Text = "Zabrana upravljanja";
            // 
            // btnObrisiZabranu
            // 
            this.btnObrisiZabranu.Image = global::Aplikacija.Properties.Resources.broom2;
            this.btnObrisiZabranu.Location = new System.Drawing.Point(332, 143);
            this.btnObrisiZabranu.Name = "btnObrisiZabranu";
            this.btnObrisiZabranu.Size = new System.Drawing.Size(121, 51);
            this.btnObrisiZabranu.TabIndex = 2;
            this.btnObrisiZabranu.Text = "Obrisi zabranu";
            this.btnObrisiZabranu.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageBeforeText;
            this.btnObrisiZabranu.UseVisualStyleBackColor = true;
            this.btnObrisiZabranu.Click += new System.EventHandler(this.btnObrisiZabranu_Click);
            // 
            // dgvZabrane
            // 
            this.dgvZabrane.BackgroundColor = System.Drawing.Color.White;
            dataGridViewCellStyle4.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle4.BackColor = System.Drawing.SystemColors.Control;
            dataGridViewCellStyle4.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle4.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle4.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle4.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle4.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.dgvZabrane.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle4;
            this.dgvZabrane.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            dataGridViewCellStyle5.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle5.BackColor = System.Drawing.SystemColors.Window;
            dataGridViewCellStyle5.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle5.ForeColor = System.Drawing.SystemColors.ControlText;
            dataGridViewCellStyle5.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle5.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle5.WrapMode = System.Windows.Forms.DataGridViewTriState.False;
            this.dgvZabrane.DefaultCellStyle = dataGridViewCellStyle5;
            this.dgvZabrane.Location = new System.Drawing.Point(6, 19);
            this.dgvZabrane.Name = "dgvZabrane";
            this.dgvZabrane.ReadOnly = true;
            dataGridViewCellStyle6.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle6.BackColor = System.Drawing.SystemColors.Control;
            dataGridViewCellStyle6.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle6.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle6.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle6.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle6.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.dgvZabrane.RowHeadersDefaultCellStyle = dataGridViewCellStyle6;
            this.dgvZabrane.RowHeadersVisible = false;
            this.dgvZabrane.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgvZabrane.Size = new System.Drawing.Size(447, 118);
            this.dgvZabrane.TabIndex = 0;
            // 
            // btnDodajZabranu
            // 
            this.btnDodajZabranu.Image = ((System.Drawing.Image)(resources.GetObject("btnDodajZabranu.Image")));
            this.btnDodajZabranu.Location = new System.Drawing.Point(6, 143);
            this.btnDodajZabranu.Name = "btnDodajZabranu";
            this.btnDodajZabranu.Size = new System.Drawing.Size(149, 51);
            this.btnDodajZabranu.TabIndex = 1;
            this.btnDodajZabranu.Text = "Dodaj novu zabranu";
            this.btnDodajZabranu.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.btnDodajZabranu.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageBeforeText;
            this.btnDodajZabranu.UseVisualStyleBackColor = true;
            this.btnDodajZabranu.Click += new System.EventHandler(this.btnDodajZabranu_Click);
            // 
            // btnProsledi
            // 
            this.btnProsledi.Location = new System.Drawing.Point(159, 686);
            this.btnProsledi.Name = "btnProsledi";
            this.btnProsledi.Size = new System.Drawing.Size(75, 23);
            this.btnProsledi.TabIndex = 3;
            this.btnProsledi.Text = "Prosledi";
            this.btnProsledi.UseVisualStyleBackColor = true;
            this.btnProsledi.Click += new System.EventHandler(this.btnProsledi_Click);
            // 
            // btnZatvori
            // 
            this.btnZatvori.Location = new System.Drawing.Point(240, 686);
            this.btnZatvori.Name = "btnZatvori";
            this.btnZatvori.Size = new System.Drawing.Size(75, 23);
            this.btnZatvori.TabIndex = 4;
            this.btnZatvori.Text = "Zatvori";
            this.btnZatvori.UseVisualStyleBackColor = true;
            this.btnZatvori.Click += new System.EventHandler(this.btnZatvori_Click);
            // 
            // FormVozac
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(483, 721);
            this.Controls.Add(this.btnZatvori);
            this.Controls.Add(this.btnProsledi);
            this.Controls.Add(this.gbZabranaUpravljanja);
            this.Controls.Add(this.gbKatergorija);
            this.Controls.Add(this.gbOsnovniPodaci);
            this.MaximizeBox = false;
            this.MaximumSize = new System.Drawing.Size(499, 760);
            this.MinimizeBox = false;
            this.MinimumSize = new System.Drawing.Size(499, 760);
            this.Name = "FormVozac";
            this.ShowInTaskbar = false;
            this.SizeGripStyle = System.Windows.Forms.SizeGripStyle.Show;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Vozac";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.FormVozac_FormClosing);
            this.gbOsnovniPodaci.ResumeLayout(false);
            this.gbOsnovniPodaci.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pbSlika)).EndInit();
            this.gbKatergorija.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgvKategorije)).EndInit();
            this.gbZabranaUpravljanja.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgvZabrane)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox gbOsnovniPodaci;
        private System.Windows.Forms.GroupBox gbKatergorija;
        private System.Windows.Forms.GroupBox gbZabranaUpravljanja;
        private System.Windows.Forms.Button btnDodajSliku;
        private System.Windows.Forms.PictureBox pbSlika;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.ComboBox cbxPol;
        private System.Windows.Forms.TextBox tbMestoIzdavanja;
        private System.Windows.Forms.TextBox tbBrDozvole;
        private System.Windows.Forms.DateTimePicker dtpVazenjeDo;
        private System.Windows.Forms.DateTimePicker dtpVazenjeOd;
        private System.Windows.Forms.DateTimePicker dtpDatumRodjenja;
        private System.Windows.Forms.TextBox tbPrezime;
        private System.Windows.Forms.TextBox tbIme;
        private System.Windows.Forms.DataGridView dgvKategorije;
        private System.Windows.Forms.Button btnDodajKategoriju;
        private System.Windows.Forms.Button btnObrisiKategoriju;
        private System.Windows.Forms.Button btnObrisiZabranu;
        private System.Windows.Forms.DataGridView dgvZabrane;
        private System.Windows.Forms.Button btnDodajZabranu;
        private System.Windows.Forms.Button btnProsledi;
        private System.Windows.Forms.Button btnZatvori;
        private System.Windows.Forms.OpenFileDialog ofdDodajSliku;
    }
}