using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ProjectHQT
{
    public partial class FormDangNhap : Form
    {
        public FormDangNhap()
        {
            InitializeComponent();
        }

        private void FormDangNhap_Load(object sender, EventArgs e)
        {

        }

        private void btnDangNhap_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text;
            string password = txtPass.Text;
            if (String.Equals(username, "admin") && String.Equals(username, password))
                MessageBox.Show("Dang nhap thanh cong");
            else
                MessageBox.Show("Ngu");
        }

        private void lblTen_Click(object sender, EventArgs e)
        {

        }
    }
}
