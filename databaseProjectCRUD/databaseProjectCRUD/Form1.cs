using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace databaseProjectCRUD
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            wyswietl_pobyty();
            wyswietl_pokoje();
            wyswietl_mieszkancow();
            groupBox1.Visible = true;
        }
        private string conString = "Data Source=MICHAEL-STRIX\\SQLEXPRESS;Initial Catalog=hotel;Integrated Security=True";

        private void wyswietl_pobyty()
        {
            dataGridView1.Columns.Clear();
            DataTable dtemployees = new DataTable(); // DOCKI
            using (SqlConnection con = new SqlConnection(conString))
            {
                using (SqlCommand cmd = new SqlCommand("exec pokazPobyty;", con))
                {
                    con.Open();
                    if (con.State == ConnectionState.Open)
                    {
                        SqlDataReader reader = cmd.ExecuteReader();
                        dtemployees.Load(reader);
                        dataGridView1.DataSource = dtemployees;
                    }
                }
            }
        }

        private void wyswietl_pokoje()
        {
            dataGridView2.Columns.Clear();
            DataTable dtemployees = new DataTable(); // DOCKI
            using (SqlConnection con = new SqlConnection(conString))
            {
                using (SqlCommand cmd = new SqlCommand("exec pokazPokoje;", con))
                {
                    con.Open();
                    if (con.State == ConnectionState.Open)
                    {
                        SqlDataReader reader = cmd.ExecuteReader();
                        dtemployees.Load(reader);
                        dataGridView2.DataSource = dtemployees;
                    }
                }
            }
        }

        private void wyswietl_mieszkancow()
        {
            dataGridView3.Columns.Clear();
            DataTable dtemployees = new DataTable(); // DOCKI
            using (SqlConnection con = new SqlConnection(conString))
            {
                using (SqlCommand cmd = new SqlCommand("exec pokazMieszkancow;", con))
                {
                    con.Open();
                    if (con.State == ConnectionState.Open)
                    {
                        SqlDataReader reader = cmd.ExecuteReader();
                        dtemployees.Load(reader);
                        dataGridView3.DataSource = dtemployees;
                    }
                }
            }
        }


        private int id_pokoju;
        private int id_pobytu;
        private string[] mieszkancy = new string[4];
        private void przypisz_wartosci_zmiennym()
        {
            for(int i = 0; i < dataGridView2.Rows.Count; i++) // LOOKING FOR ID_POKOJU
            {
                if (dataGridView2[0, i].Selected)
                {
                    id_pokoju = int.Parse(dataGridView2[0, i].Value.ToString());
                }
            }

            for (int i = 0; i < dataGridView1.Rows.Count; i++) // LOOKING FOR ID_POBYTU
            {
                if (dataGridView1[0, i].Selected)
                {
                    id_pobytu = int.Parse(dataGridView1[0, i].Value.ToString());
                }
            }


            for (int i = 0; i < 4; i++) // ZEROWANIE TABLICY MIESZKANCOW
            {
                mieszkancy[i] = "null";
            }

            int j = 0;
            for (int i = 0; i < dataGridView3.Rows.Count; i++) // LOOKING FOR ID_MIESZKANCOW
            {
                if (dataGridView3[0, i].Selected)
                {
                    mieszkancy[j] = dataGridView3[0, i].Value.ToString();
                    j++;
                }
            }
        }




        private void button2_Click(object sender, EventArgs e) //INSERT BTN
        {

            przypisz_wartosci_zmiennym();


                using (SqlConnection con = new SqlConnection(conString))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        con.Open();
                        cmd.Connection = con;
                        cmd.CommandText = "exec dodajPobyt @Data_Zamledowania, @Data_Odmeldowania, @Id_Pokoju, @m1, @m2,@m3,@m4, @cash";
                        cmd.Parameters.AddWithValue("@Data_Zamledowania", textBox1.Text);
                        cmd.Parameters.AddWithValue("@Data_Odmeldowania", textBox2.Text);
                        cmd.Parameters.AddWithValue("@Id_Pokoju", id_pokoju);
                    if (mieszkancy[0] == "null")
                    {
                        cmd.Parameters.AddWithValue("@m1", DBNull.Value); //mieszkancy[0].ToString()
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@m1", mieszkancy[0]); //mieszkancy[0].ToString()
                    }
                    if (mieszkancy[1] == "null")
                    {
                        cmd.Parameters.AddWithValue("@m2", DBNull.Value); //mieszkancy[0].ToString()
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@m2", mieszkancy[1]); //mieszkancy[0].ToString()
                    }
                    if (mieszkancy[2] == "null")
                    {
                        cmd.Parameters.AddWithValue("@m3", DBNull.Value); //mieszkancy[0].ToString()
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@m3", mieszkancy[2]); //mieszkancy[0].ToString()
                    }
                    if (mieszkancy[3] == "null")
                    {
                        cmd.Parameters.AddWithValue("@m4", DBNull.Value); //mieszkancy[0].ToString()
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@m4", mieszkancy[3]); //mieszkancy[0].ToString()
                    }

                   
                        cmd.Parameters.AddWithValue("@cash", textBox3.Text);
                        cmd.ExecuteReader();
                        con.Close();
                    }
                }
                wyswietl_pobyty();
            
        }

        private void button3_Click(object sender, EventArgs e) // UPDATE BTN
        {
            przypisz_wartosci_zmiennym();


           
            using (SqlConnection con = new SqlConnection(conString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandText = "exec ZaaktualizujPobyt @Data_Zamledowania, @Data_Odmeldowania, @Id_Pokoju, @m1, @m2,@m3,@m4, @cash, @updateID";
                    cmd.Parameters.AddWithValue("@Data_Zamledowania", textBox1.Text);
                    cmd.Parameters.AddWithValue("@Data_Odmeldowania", textBox2.Text);
                    cmd.Parameters.AddWithValue("@Id_Pokoju", id_pokoju);
                    if (mieszkancy[0] == "null")
                    {
                        cmd.Parameters.AddWithValue("@m1", DBNull.Value); //mieszkancy[0].ToString()
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@m1", mieszkancy[0]); //mieszkancy[0].ToString()
                    }
                    if (mieszkancy[1] == "null")
                    {
                        cmd.Parameters.AddWithValue("@m2", DBNull.Value); //mieszkancy[0].ToString()
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@m2", mieszkancy[1]); //mieszkancy[0].ToString()
                    }
                    if (mieszkancy[2] == "null")
                    {
                        cmd.Parameters.AddWithValue("@m3", DBNull.Value); //mieszkancy[0].ToString()
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@m3", mieszkancy[2]); //mieszkancy[0].ToString()
                    }
                    if (mieszkancy[3] == "null")
                    {
                        cmd.Parameters.AddWithValue("@m4", DBNull.Value); //mieszkancy[0].ToString()
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@m4", mieszkancy[3]); //mieszkancy[0].ToString()
                    }


                    cmd.Parameters.AddWithValue("@cash", textBox3.Text);
                    cmd.Parameters.AddWithValue("@updateID", id_pobytu);
                    cmd.ExecuteReader();
                    con.Close();
                }
            }
            wyswietl_pobyty();
            
        }

        private void button4_Click(object sender, EventArgs e) // DELETE BTN
        {
            int index = 0;
            for (int i = 0; i < dataGridView1.Rows.Count; i++)
            {
                if (dataGridView1[0, i].Selected == true)
                {
                    index = int.Parse(dataGridView1[0, i].Value.ToString());
                }
            }
            if (index == 0)
            {
                MessageBox.Show("Wybierz rekord, ktory chcesz usunac wybierajac odpowiedni WIERSZ w kolumnie ID_Pobytu");
            }
            else
            {

                using (SqlConnection con = new SqlConnection(conString))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        con.Open();
                        cmd.Connection = con;
                        cmd.CommandText = "exec usunPobyt @ID_DEL";
                        cmd.Parameters.AddWithValue("@ID_DEL", index);
                        cmd.ExecuteReader();
                        con.Close();
                    }
                }
                wyswietl_pobyty();
            }
        }

        
            
        
    }
}
