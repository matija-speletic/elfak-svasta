
namespace Aplikacija
{
    partial class FormKategorija
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
            this.label5 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.dtpVazenjeDo = new System.Windows.Forms.DateTimePicker();
            this.dtpVazenjeOd = new System.Windows.Forms.DateTimePicker();
            this.label8 = new System.Windows.Forms.Label();
            this.cbKategorija = new System.Windows.Forms.ComboBox();
            this.btnZatvori = new System.Windows.Forms.Button();
            this.btnProsledi = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(50, 81);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(56, 13);
            this.label5.TabIndex = 4;
            this.label5.Text = "Datum do:";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(50, 55);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(56, 13);
            this.label4.TabIndex = 2;
            this.label4.Text = "Datum od:";
            // 
            // dtpVazenjeDo
            // 
            this.dtpVazenjeDo.CustomFormat = "dd.MM.yyyy.";
            this.dtpVazenjeDo.Format = System.Windows.Forms.DateTimePickerFormat.Custom;
            this.dtpVazenjeDo.Location = new System.Drawing.Point(112, 75);
            this.dtpVazenjeDo.Name = "dtpVazenjeDo";
            this.dtpVazenjeDo.Size = new System.Drawing.Size(117, 20);
            this.dtpVazenjeDo.TabIndex = 5;
            // 
            // dtpVazenjeOd
            // 
            this.dtpVazenjeOd.CustomFormat = "dd.MM.yyyy.";
            this.dtpVazenjeOd.Format = System.Windows.Forms.DateTimePickerFormat.Custom;
            this.dtpVazenjeOd.Location = new System.Drawing.Point(112, 49);
            this.dtpVazenjeOd.Name = "dtpVazenjeOd";
            this.dtpVazenjeOd.Size = new System.Drawing.Size(117, 20);
            this.dtpVazenjeOd.TabIndex = 3;
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Location = new System.Drawing.Point(49, 25);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(57, 13);
            this.label8.TabIndex = 0;
            this.label8.Text = "Kategorija:";
            // 
            // cbKategorija
            // 
            this.cbKategorija.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbKategorija.FormattingEnabled = true;
            this.cbKategorija.Items.AddRange(new object[] {
            "AM",
            "A1",
            "A2",
            "A",
            "B1",
            "B",
            "BE",
            "C1",
            "C1E",
            "C",
            "CE",
            "D1",
            "D1E",
            "D",
            "DE",
            "F",
            "M"});
            this.cbKategorija.Location = new System.Drawing.Point(112, 22);
            this.cbKategorija.Name = "cbKategorija";
            this.cbKategorija.Size = new System.Drawing.Size(141, 21);
            this.cbKategorija.TabIndex = 1;
            // 
            // btnZatvori
            // 
            this.btnZatvori.Location = new System.Drawing.Point(169, 110);
            this.btnZatvori.Name = "btnZatvori";
            this.btnZatvori.Size = new System.Drawing.Size(75, 23);
            this.btnZatvori.TabIndex = 7;
            this.btnZatvori.Text = "Zatvori";
            this.btnZatvori.UseVisualStyleBackColor = true;
            this.btnZatvori.Click += new System.EventHandler(this.btnZatvori_Click);
            // 
            // btnProsledi
            // 
            this.btnProsledi.Location = new System.Drawing.Point(50, 110);
            this.btnProsledi.Name = "btnProsledi";
            this.btnProsledi.Size = new System.Drawing.Size(75, 23);
            this.btnProsledi.TabIndex = 6;
            this.btnProsledi.Text = "Prosledi";
            this.btnProsledi.UseVisualStyleBackColor = true;
            this.btnProsledi.Click += new System.EventHandler(this.btnProsledi_Click);
            // 
            // FormKategorija
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(313, 165);
            this.Controls.Add(this.btnZatvori);
            this.Controls.Add(this.btnProsledi);
            this.Controls.Add(this.label8);
            this.Controls.Add(this.cbKategorija);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.dtpVazenjeDo);
            this.Controls.Add(this.dtpVazenjeOd);
            this.MaximizeBox = false;
            this.MaximumSize = new System.Drawing.Size(329, 204);
            this.MinimizeBox = false;
            this.MinimumSize = new System.Drawing.Size(329, 204);
            this.Name = "FormKategorija";
            this.ShowIcon = false;
            this.ShowInTaskbar = false;
            this.SizeGripStyle = System.Windows.Forms.SizeGripStyle.Show;
            this.Text = "FormKategorija";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.DateTimePicker dtpVazenjeDo;
        private System.Windows.Forms.DateTimePicker dtpVazenjeOd;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.ComboBox cbKategorija;
        private System.Windows.Forms.Button btnZatvori;
        private System.Windows.Forms.Button btnProsledi;
    }
}