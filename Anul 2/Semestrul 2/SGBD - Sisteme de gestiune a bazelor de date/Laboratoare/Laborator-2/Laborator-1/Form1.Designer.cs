using System.Windows.Forms;

namespace Laborator_1
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
            this.components = new System.ComponentModel.Container();
            this.bindingChild = new System.Windows.Forms.BindingSource(this.components);
            this.FabricaView = new System.Windows.Forms.DataGridView();
            this.fabricaMedicamenteBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.button1 = new System.Windows.Forms.Button();
            this.button2 = new System.Windows.Forms.Button();
            this.button3 = new System.Windows.Forms.Button();
            this.MedicamenteView = new System.Windows.Forms.DataGridView();
            this.medicamentBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.button4 = new System.Windows.Forms.Button();
            this.buttons = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.bindingChild)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.FabricaView)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.fabricaMedicamenteBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.MedicamenteView)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.medicamentBindingSource)).BeginInit();
            this.SuspendLayout();
            // 
            // bindingChild
            // 
            this.bindingChild.CurrentChanged += new System.EventHandler(this.bindingChild_CurrentChanged);
            // 
            // FabricaView
            // 
            this.FabricaView.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.FabricaView.Location = new System.Drawing.Point(36, 54);
            this.FabricaView.Name = "FabricaView";
            this.FabricaView.RowHeadersWidth = 51;
            this.FabricaView.RowTemplate.Height = 24;
            this.FabricaView.Size = new System.Drawing.Size(524, 236);
            this.FabricaView.TabIndex = 0;
            // 
            // fabricaMedicamenteBindingSource
            // 
            this.fabricaMedicamenteBindingSource.DataMember = "FabricaMedicamente";
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(748, 357);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(170, 23);
            this.button1.TabIndex = 1;
            this.button1.Text = "Delete";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // button2
            // 
            this.button2.Location = new System.Drawing.Point(748, 443);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(170, 23);
            this.button2.TabIndex = 2;
            this.button2.Text = "Add";
            this.button2.UseVisualStyleBackColor = true;
            this.button2.Click += new System.EventHandler(this.button2_Click);
            // 
            // button3
            // 
            this.button3.Location = new System.Drawing.Point(748, 318);
            this.button3.Name = "button3";
            this.button3.Size = new System.Drawing.Size(170, 23);
            this.button3.TabIndex = 3;
            this.button3.Text = "Update";
            this.button3.UseVisualStyleBackColor = true;
            this.button3.Click += new System.EventHandler(this.button3_Click);
            // 
            // MedicamenteView
            // 
            this.MedicamenteView.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.MedicamenteView.Location = new System.Drawing.Point(636, 54);
            this.MedicamenteView.Name = "MedicamenteView";
            this.MedicamenteView.RowHeadersWidth = 51;
            this.MedicamenteView.RowTemplate.Height = 24;
            this.MedicamenteView.Size = new System.Drawing.Size(482, 236);
            this.MedicamenteView.TabIndex = 7;
            // 
            // medicamentBindingSource
            // 
            this.medicamentBindingSource.DataMember = "Medicament";
            // 
            // button4
            // 
            this.button4.Location = new System.Drawing.Point(748, 403);
            this.button4.Name = "button4";
            this.button4.Size = new System.Drawing.Size(170, 23);
            this.button4.TabIndex = 11;
            this.button4.Text = "Refresh";
            this.button4.UseVisualStyleBackColor = true;
            this.button4.Click += new System.EventHandler(this.button4_Click);
            // 
            // panel1
            // 
            // this.panel1.Location = new System.Drawing.Point(36, 318);
            // this.panel1.Name = "panel1";
            // this.panel1.Size = new System.Drawing.Size(524, 184);
            // this.panel1.TabIndex = 15;
            // 
            // buttons
            // 
            this.buttons.Location = new System.Drawing.Point(748, 475);
            this.buttons.Name = "buttons";
            this.buttons.Size = new System.Drawing.Size(170, 28);
            this.buttons.TabIndex = 16;
            this.buttons.Text = "Generate Buttons";
            this.buttons.UseVisualStyleBackColor = true;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1173, 515);
            this.Controls.Add(this.buttons);
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.button4);
            this.Controls.Add(this.MedicamenteView);
            this.Controls.Add(this.button3);
            this.Controls.Add(this.button2);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.FabricaView);
            this.Name = "Form1";
            this.Text = "Form1";
            this.Load += new System.EventHandler(this.Form1_Load);
            ((System.ComponentModel.ISupportInitialize)(this.bindingChild)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.FabricaView)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.fabricaMedicamenteBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.MedicamenteView)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.medicamentBindingSource)).EndInit();
            this.ResumeLayout(false);
        }

        private System.Windows.Forms.Button buttons;

        private System.Windows.Forms.Panel panel1;

        #endregion

        private System.Windows.Forms.DataGridView FabricaView;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Button button2;
        private System.Windows.Forms.Button button3;
        private System.Windows.Forms.DataGridView MedicamenteView;
        private System.Windows.Forms.BindingSource medicamentBindingSource;
        private System.Windows.Forms.BindingSource fabricaMedicamenteBindingSource;
        private System.Windows.Forms.Button button4;
    }
}

