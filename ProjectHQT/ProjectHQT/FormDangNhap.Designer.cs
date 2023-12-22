
namespace ProjectHQT
{
    partial class FormDangNhap
    {
        /// <summary>
        ///  Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        ///  Clean up any resources being used.
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
        ///  Required method for Designer support - do not modify
        ///  the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FormDangNhap));
            lblTen = new System.Windows.Forms.Label();
            txtUsername = new System.Windows.Forms.TextBox();
            txtPass = new System.Windows.Forms.TextBox();
            usernameLbl = new System.Windows.Forms.Label();
            label1 = new System.Windows.Forms.Label();
            btnDangNhap = new System.Windows.Forms.Button();
            pictureBox1 = new System.Windows.Forms.PictureBox();
            pictureBox2 = new System.Windows.Forms.PictureBox();
            sepe = new System.Windows.Forms.Label();
            button1 = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)pictureBox1).BeginInit();
            ((System.ComponentModel.ISupportInitialize)pictureBox2).BeginInit();
            SuspendLayout();
            // 
            // lblTen
            // 
            lblTen.AllowDrop = true;
            lblTen.AutoSize = true;
            lblTen.Font = new System.Drawing.Font("Tahoma", 25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            lblTen.Location = new System.Drawing.Point(22, 9);
            lblTen.Name = "lblTen";
            lblTen.Size = new System.Drawing.Size(261, 82);
            lblTen.TabIndex = 0;
            lblTen.Text = " Quản lý phòng \r\nkhám nha khoa";
            lblTen.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            lblTen.Click += lblTen_Click;
            // 
            // txtUsername
            // 
            txtUsername.Location = new System.Drawing.Point(60, 163);
            txtUsername.Name = "txtUsername";
            txtUsername.Size = new System.Drawing.Size(223, 22);
            txtUsername.TabIndex = 1;
            // 
            // txtPass
            // 
            txtPass.Location = new System.Drawing.Point(60, 231);
            txtPass.Name = "txtPass";
            txtPass.Size = new System.Drawing.Size(223, 22);
            txtPass.TabIndex = 2;
            txtPass.UseSystemPasswordChar = true;
            // 
            // usernameLbl
            // 
            usernameLbl.AutoSize = true;
            usernameLbl.Font = new System.Drawing.Font("Tahoma", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            usernameLbl.Location = new System.Drawing.Point(60, 137);
            usernameLbl.Name = "usernameLbl";
            usernameLbl.Size = new System.Drawing.Size(120, 23);
            usernameLbl.TabIndex = 3;
            usernameLbl.Text = "Số điện thoại";
            // 
            // label1
            // 
            label1.AutoSize = true;
            label1.Font = new System.Drawing.Font("Tahoma", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            label1.Location = new System.Drawing.Point(60, 205);
            label1.Name = "label1";
            label1.Size = new System.Drawing.Size(88, 23);
            label1.TabIndex = 4;
            label1.Text = "Mật khẩu";
            // 
            // btnDangNhap
            // 
            btnDangNhap.Location = new System.Drawing.Point(45, 265);
            btnDangNhap.Name = "btnDangNhap";
            btnDangNhap.Size = new System.Drawing.Size(84, 38);
            btnDangNhap.TabIndex = 5;
            btnDangNhap.Text = "Đăng nhập";
            btnDangNhap.UseVisualStyleBackColor = true;
            btnDangNhap.Click += btnDangNhap_Click;
            // 
            // pictureBox1
            // 
            pictureBox1.Image = (System.Drawing.Image)resources.GetObject("pictureBox1.Image");
            pictureBox1.Location = new System.Drawing.Point(12, 137);
            pictureBox1.Name = "pictureBox1";
            pictureBox1.Size = new System.Drawing.Size(42, 48);
            pictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            pictureBox1.TabIndex = 6;
            pictureBox1.TabStop = false;
            // 
            // pictureBox2
            // 
            pictureBox2.Image = (System.Drawing.Image)resources.GetObject("pictureBox2.Image");
            pictureBox2.Location = new System.Drawing.Point(12, 205);
            pictureBox2.Name = "pictureBox2";
            pictureBox2.Size = new System.Drawing.Size(42, 48);
            pictureBox2.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            pictureBox2.TabIndex = 7;
            pictureBox2.TabStop = false;
            // 
            // sepe
            // 
            sepe.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            sepe.Location = new System.Drawing.Point(-3, 109);
            sepe.Name = "sepe";
            sepe.Size = new System.Drawing.Size(300, 2);
            sepe.TabIndex = 8;
            // 
            // button1
            // 
            button1.Location = new System.Drawing.Point(152, 265);
            button1.Name = "button1";
            button1.Size = new System.Drawing.Size(106, 38);
            button1.TabIndex = 9;
            button1.Text = "Đổi mật khẩu";
            button1.UseVisualStyleBackColor = true;
            // 
            // FormDangNhap
            // 
            AutoScaleDimensions = new System.Drawing.SizeF(7F, 14F);
            AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            ClientSize = new System.Drawing.Size(295, 315);
            Controls.Add(button1);
            Controls.Add(sepe);
            Controls.Add(pictureBox2);
            Controls.Add(pictureBox1);
            Controls.Add(btnDangNhap);
            Controls.Add(label1);
            Controls.Add(usernameLbl);
            Controls.Add(txtPass);
            Controls.Add(txtUsername);
            Controls.Add(lblTen);
            Font = new System.Drawing.Font("Tahoma", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            Name = "FormDangNhap";
            Text = "Đăng nhập";
            Load += FormDangNhap_Load;
            ((System.ComponentModel.ISupportInitialize)pictureBox1).EndInit();
            ((System.ComponentModel.ISupportInitialize)pictureBox2).EndInit();
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion

        private System.Windows.Forms.Label lblTen;
        private System.Windows.Forms.TextBox txtUsername;
        private System.Windows.Forms.TextBox txtPass;
        private System.Windows.Forms.Label usernameLbl;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button btnDangNhap;
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.PictureBox pictureBox2;
        private System.Windows.Forms.Label sepe;
        private System.Windows.Forms.Button button1;
    }
}

