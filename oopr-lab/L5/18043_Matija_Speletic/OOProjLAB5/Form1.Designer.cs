
namespace OOProjLAB5
{
    partial class Form1
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
            this.pbKarta1 = new System.Windows.Forms.PictureBox();
            this.pbKarta5 = new System.Windows.Forms.PictureBox();
            this.pbKarta4 = new System.Windows.Forms.PictureBox();
            this.pbKarta3 = new System.Windows.Forms.PictureBox();
            this.pbKarta2 = new System.Windows.Forms.PictureBox();
            this.numBrojPoena = new System.Windows.Forms.NumericUpDown();
            this.numUlog = new System.Windows.Forms.NumericUpDown();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.btnZameni = new System.Windows.Forms.Button();
            this.btnUzmiKarte = new System.Windows.Forms.Button();
            this.btnProvera = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.pbKarta1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pbKarta5)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pbKarta4)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pbKarta3)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pbKarta2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.numBrojPoena)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.numUlog)).BeginInit();
            this.SuspendLayout();
            // 
            // pbKarta1
            // 
            this.pbKarta1.Cursor = System.Windows.Forms.Cursors.Hand;
            this.pbKarta1.Location = new System.Drawing.Point(13, 12);
            this.pbKarta1.Name = "pbKarta1";
            this.pbKarta1.Size = new System.Drawing.Size(130, 198);
            this.pbKarta1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.pbKarta1.TabIndex = 0;
            this.pbKarta1.TabStop = false;
            this.pbKarta1.Tag = "1";
            this.pbKarta1.Click += new System.EventHandler(this.pbKarta1_Click);
            // 
            // pbKarta5
            // 
            this.pbKarta5.Cursor = System.Windows.Forms.Cursors.Hand;
            this.pbKarta5.Location = new System.Drawing.Point(557, 12);
            this.pbKarta5.Name = "pbKarta5";
            this.pbKarta5.Size = new System.Drawing.Size(130, 198);
            this.pbKarta5.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.pbKarta5.TabIndex = 1;
            this.pbKarta5.TabStop = false;
            this.pbKarta5.Tag = "5";
            this.pbKarta5.Click += new System.EventHandler(this.pbKarta1_Click);
            // 
            // pbKarta4
            // 
            this.pbKarta4.Cursor = System.Windows.Forms.Cursors.Hand;
            this.pbKarta4.Location = new System.Drawing.Point(421, 12);
            this.pbKarta4.Name = "pbKarta4";
            this.pbKarta4.Size = new System.Drawing.Size(130, 198);
            this.pbKarta4.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.pbKarta4.TabIndex = 2;
            this.pbKarta4.TabStop = false;
            this.pbKarta4.Tag = "4";
            this.pbKarta4.Click += new System.EventHandler(this.pbKarta1_Click);
            // 
            // pbKarta3
            // 
            this.pbKarta3.Cursor = System.Windows.Forms.Cursors.Hand;
            this.pbKarta3.Location = new System.Drawing.Point(285, 12);
            this.pbKarta3.Name = "pbKarta3";
            this.pbKarta3.Size = new System.Drawing.Size(130, 198);
            this.pbKarta3.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.pbKarta3.TabIndex = 3;
            this.pbKarta3.TabStop = false;
            this.pbKarta3.Tag = "3";
            this.pbKarta3.Click += new System.EventHandler(this.pbKarta1_Click);
            // 
            // pbKarta2
            // 
            this.pbKarta2.Cursor = System.Windows.Forms.Cursors.Hand;
            this.pbKarta2.Location = new System.Drawing.Point(149, 12);
            this.pbKarta2.Name = "pbKarta2";
            this.pbKarta2.Size = new System.Drawing.Size(130, 198);
            this.pbKarta2.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.pbKarta2.TabIndex = 4;
            this.pbKarta2.TabStop = false;
            this.pbKarta2.Tag = "2";
            this.pbKarta2.Click += new System.EventHandler(this.pbKarta1_Click);
            // 
            // numBrojPoena
            // 
            this.numBrojPoena.Font = new System.Drawing.Font("Microsoft Sans Serif", 15F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.numBrojPoena.Increment = new decimal(new int[] {
            5,
            0,
            0,
            0});
            this.numBrojPoena.Location = new System.Drawing.Point(210, 250);
            this.numBrojPoena.Maximum = new decimal(new int[] {
            100000,
            0,
            0,
            0});
            this.numBrojPoena.Name = "numBrojPoena";
            this.numBrojPoena.Size = new System.Drawing.Size(157, 30);
            this.numBrojPoena.TabIndex = 5;
            // 
            // numUlog
            // 
            this.numUlog.Font = new System.Drawing.Font("Microsoft Sans Serif", 15F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.numUlog.Increment = new decimal(new int[] {
            5,
            0,
            0,
            0});
            this.numUlog.Location = new System.Drawing.Point(210, 286);
            this.numUlog.Maximum = new decimal(new int[] {
            100000,
            0,
            0,
            0});
            this.numUlog.Name = "numUlog";
            this.numUlog.Size = new System.Drawing.Size(157, 30);
            this.numUlog.TabIndex = 6;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 15F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(92, 252);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(112, 25);
            this.label1.TabIndex = 7;
            this.label1.Text = "Broj poena:";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 15F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(146, 288);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(58, 25);
            this.label2.TabIndex = 8;
            this.label2.Text = "Ulog:";
            // 
            // btnZameni
            // 
            this.btnZameni.Font = new System.Drawing.Font("Microsoft Sans Serif", 15F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnZameni.Location = new System.Drawing.Point(409, 287);
            this.btnZameni.Name = "btnZameni";
            this.btnZameni.Size = new System.Drawing.Size(132, 34);
            this.btnZameni.TabIndex = 9;
            this.btnZameni.Text = "Zameni";
            this.btnZameni.UseVisualStyleBackColor = true;
            this.btnZameni.Click += new System.EventHandler(this.btnZameni_Click);
            // 
            // btnUzmiKarte
            // 
            this.btnUzmiKarte.Font = new System.Drawing.Font("Microsoft Sans Serif", 15F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnUzmiKarte.Location = new System.Drawing.Point(409, 247);
            this.btnUzmiKarte.Name = "btnUzmiKarte";
            this.btnUzmiKarte.Size = new System.Drawing.Size(132, 34);
            this.btnUzmiKarte.TabIndex = 10;
            this.btnUzmiKarte.Text = "Uzmi karte";
            this.btnUzmiKarte.UseVisualStyleBackColor = true;
            this.btnUzmiKarte.Click += new System.EventHandler(this.btnUzmiKarte_Click);
            // 
            // btnProvera
            // 
            this.btnProvera.Font = new System.Drawing.Font("Microsoft Sans Serif", 15F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnProvera.Location = new System.Drawing.Point(409, 327);
            this.btnProvera.Name = "btnProvera";
            this.btnProvera.Size = new System.Drawing.Size(132, 34);
            this.btnProvera.TabIndex = 11;
            this.btnProvera.Text = "Provera";
            this.btnProvera.UseVisualStyleBackColor = true;
            this.btnProvera.Click += new System.EventHandler(this.btnProvera_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(702, 402);
            this.Controls.Add(this.btnProvera);
            this.Controls.Add(this.btnUzmiKarte);
            this.Controls.Add(this.btnZameni);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.numUlog);
            this.Controls.Add(this.numBrojPoena);
            this.Controls.Add(this.pbKarta2);
            this.Controls.Add(this.pbKarta3);
            this.Controls.Add(this.pbKarta4);
            this.Controls.Add(this.pbKarta5);
            this.Controls.Add(this.pbKarta1);
            this.MaximumSize = new System.Drawing.Size(718, 441);
            this.MinimumSize = new System.Drawing.Size(718, 441);
            this.Name = "Form1";
            this.Text = "Form1";
            this.Load += new System.EventHandler(this.Form1_Load);
            ((System.ComponentModel.ISupportInitialize)(this.pbKarta1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pbKarta5)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pbKarta4)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pbKarta3)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pbKarta2)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.numBrojPoena)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.numUlog)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.PictureBox pbKarta1;
        private System.Windows.Forms.PictureBox pbKarta5;
        private System.Windows.Forms.PictureBox pbKarta4;
        private System.Windows.Forms.PictureBox pbKarta3;
        private System.Windows.Forms.PictureBox pbKarta2;
        private System.Windows.Forms.NumericUpDown numBrojPoena;
        private System.Windows.Forms.NumericUpDown numUlog;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Button btnZameni;
        private System.Windows.Forms.Button btnUzmiKarte;
        private System.Windows.Forms.Button btnProvera;
    }
}

