namespace ProjectHQT
{
    partial class FormThanhToan
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FormThanhToan));
            btnExit = new System.Windows.Forms.Button();
            btnThanhToan = new System.Windows.Forms.Button();
            btnHoaDon = new System.Windows.Forms.Button();
            btnDisplay = new System.Windows.Forms.Button();
            dataGridView1 = new System.Windows.Forms.DataGridView();
            pictureBox1 = new System.Windows.Forms.PictureBox();
            usernameLbl = new System.Windows.Forms.Label();
            txtUsername = new System.Windows.Forms.TextBox();
            ((System.ComponentModel.ISupportInitialize)dataGridView1).BeginInit();
            ((System.ComponentModel.ISupportInitialize)pictureBox1).BeginInit();
            SuspendLayout();
            // 
            // btnExit
            // 
            btnExit.Location = new System.Drawing.Point(276, 355);
            btnExit.Name = "btnExit";
            btnExit.Size = new System.Drawing.Size(126, 48);
            btnExit.TabIndex = 48;
            btnExit.Text = "Thoát";
            btnExit.UseVisualStyleBackColor = true;
            // 
            // btnThanhToan
            // 
            btnThanhToan.Location = new System.Drawing.Point(12, 355);
            btnThanhToan.Name = "btnThanhToan";
            btnThanhToan.Size = new System.Drawing.Size(126, 48);
            btnThanhToan.TabIndex = 47;
            btnThanhToan.Text = "Thanh Toán";
            btnThanhToan.UseVisualStyleBackColor = true;
            // 
            // btnHoaDon
            // 
            btnHoaDon.Location = new System.Drawing.Point(144, 355);
            btnHoaDon.Name = "btnHoaDon";
            btnHoaDon.Size = new System.Drawing.Size(126, 48);
            btnHoaDon.TabIndex = 46;
            btnHoaDon.Text = "In hóa đơn";
            btnHoaDon.UseVisualStyleBackColor = true;
            // 
            // btnDisplay
            // 
            btnDisplay.Location = new System.Drawing.Point(276, 4);
            btnDisplay.Name = "btnDisplay";
            btnDisplay.Size = new System.Drawing.Size(126, 48);
            btnDisplay.TabIndex = 45;
            btnDisplay.Text = "Tìm";
            btnDisplay.UseVisualStyleBackColor = true;
            // 
            // dataGridView1
            // 
            dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            dataGridView1.Location = new System.Drawing.Point(12, 66);
            dataGridView1.Name = "dataGridView1";
            dataGridView1.RowTemplate.Height = 25;
            dataGridView1.Size = new System.Drawing.Size(390, 273);
            dataGridView1.TabIndex = 44;
            // 
            // pictureBox1
            // 
            pictureBox1.Image = (System.Drawing.Image)resources.GetObject("pictureBox1.Image");
            pictureBox1.Location = new System.Drawing.Point(11, 4);
            pictureBox1.Name = "pictureBox1";
            pictureBox1.Size = new System.Drawing.Size(42, 48);
            pictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            pictureBox1.TabIndex = 43;
            pictureBox1.TabStop = false;
            // 
            // usernameLbl
            // 
            usernameLbl.AutoSize = true;
            usernameLbl.Font = new System.Drawing.Font("Tahoma", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            usernameLbl.Location = new System.Drawing.Point(59, 3);
            usernameLbl.Name = "usernameLbl";
            usernameLbl.Size = new System.Drawing.Size(120, 23);
            usernameLbl.TabIndex = 42;
            usernameLbl.Text = "Số điện thoại";
            // 
            // txtUsername
            // 
            txtUsername.Location = new System.Drawing.Point(59, 29);
            txtUsername.Name = "txtUsername";
            txtUsername.Size = new System.Drawing.Size(211, 23);
            txtUsername.TabIndex = 41;
            // 
            // FormThanhToan
            // 
            AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            ClientSize = new System.Drawing.Size(417, 413);
            Controls.Add(btnExit);
            Controls.Add(btnThanhToan);
            Controls.Add(btnHoaDon);
            Controls.Add(btnDisplay);
            Controls.Add(dataGridView1);
            Controls.Add(pictureBox1);
            Controls.Add(usernameLbl);
            Controls.Add(txtUsername);
            Name = "FormThanhToan";
            Text = "Nhân viên";
            ((System.ComponentModel.ISupportInitialize)dataGridView1).EndInit();
            ((System.ComponentModel.ISupportInitialize)pictureBox1).EndInit();
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion

        private System.Windows.Forms.Button btnExit;
        private System.Windows.Forms.Button btnThanhToan;
        private System.Windows.Forms.Button btnHoaDon;
        private System.Windows.Forms.Button btnDisplay;
        private System.Windows.Forms.DataGridView dataGridView1;
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.Label usernameLbl;
        private System.Windows.Forms.TextBox txtUsername;
    }
}