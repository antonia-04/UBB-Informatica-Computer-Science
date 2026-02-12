using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Linq;
using System.Windows.Forms;

namespace Laborator_1
{
    public partial class Form1 : Form
    {
        private DataSet dataSet = new DataSet();
        private SqlDataAdapter parentAdapter = new SqlDataAdapter();
        private SqlDataAdapter childAdapter = new SqlDataAdapter();
        private Dictionary<string, Type> columnTypes = new();

        private string connectionString = ConfigurationManager.ConnectionStrings["connection"].ConnectionString;

        private BindingSource bindingParent = new BindingSource();
        private BindingSource bindingChild = new BindingSource();

        private string ParentTable = ConfigurationManager.AppSettings["ParentTable"];
        private string ChildTable = ConfigurationManager.AppSettings["ChildTable"];
        private string ParentPrimaryKey = ConfigurationManager.AppSettings["ParentPrimaryKey"];
        private string ChildPrimaryKey = ConfigurationManager.AppSettings["ChildPrimaryKey"];
        private string ChildForeignKey = ConfigurationManager.AppSettings["ChildForeignKey"];

        private List<string> childColumns = new List<string>(ConfigurationManager.AppSettings["ChildColumnNames"].Split(','));
        private List<string> insertParams = new List<string>(ConfigurationManager.AppSettings["InsertChildParameters"].Split(','));

        public Form1()
        {
            InitializeComponent();
            GenerateDynamicControls();
            bindingChild.CurrentChanged += bindingChild_CurrentChanged;
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    parentAdapter = new SqlDataAdapter($"SELECT * FROM {ParentTable}", connection);
                    childAdapter = new SqlDataAdapter($"SELECT * FROM {ChildTable}", connection);

                    parentAdapter.Fill(dataSet, ParentTable);
                    childAdapter.Fill(dataSet, ChildTable);

                    DataColumn pkColumn = dataSet.Tables[ParentTable].Columns[ParentPrimaryKey];
                    DataColumn fkColumn = dataSet.Tables[ChildTable].Columns[ChildForeignKey];
                    DataRelation relation = new DataRelation("FK_Generic", pkColumn, fkColumn);
                    dataSet.Relations.Add(relation);

                    bindingParent.DataSource = dataSet.Tables[ParentTable];
                    FabricaView.DataSource = bindingParent;

                    bindingChild.DataMember = "FK_Generic";
                    bindingChild.DataSource = bindingParent;
                    MedicamenteView.DataSource = bindingChild;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Eroare: " + ex.Message);
            }
        }
        private void GenerateDynamicControls()
        {
            int startY = FabricaView.Location.Y + FabricaView.Height + 20; 
            int startX = FabricaView.Location.X;

            for (int i = 0; i < childColumns.Count; i++)
            {
                Label label = new Label
                {
                    Text = childColumns[i],
                    Location = new System.Drawing.Point(startX, startY + i * 30),
                    Size = new System.Drawing.Size(120, 20)
                };
                this.Controls.Add(label);

                TextBox textBox = new TextBox
                {
                    Name = childColumns[i],
                    Location = new System.Drawing.Point(startX + 130, startY + i * 30),
                    Size = new System.Drawing.Size(150, 20)
                };
                this.Controls.Add(textBox);
            }
        }


        private void button4_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    parentAdapter.SelectCommand.Connection = connection;
                    childAdapter.SelectCommand.Connection = connection;

                    dataSet.Tables[ChildTable]?.Clear();
                    dataSet.Tables[ParentTable]?.Clear();

                    parentAdapter.Fill(dataSet, ParentTable);
                    childAdapter.Fill(dataSet, ChildTable);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Refresh failed: " + ex.Message);
            }
        }

        private void bindingChild_CurrentChanged(object sender, EventArgs e)
        {
            if (bindingChild.Current is DataRowView rowView)
            {
                foreach (var col in childColumns)
                {
                    if (Controls.ContainsKey(col) && rowView.DataView.Table.Columns.Contains(col))
                    {
                        ((TextBox)this.Controls[col]).Text = rowView[col]?.ToString();
                    }
                }
            }
            else
            {
                foreach (var col in childColumns)
                {
                    if (Controls.ContainsKey(col))
                    {
                        ((TextBox)this.Controls[col]).Clear();
                    }
                }
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    // Exclude coloana identity
                    var insertColumns = childColumns.Where(c => c != ChildPrimaryKey).ToList();
                    var insertParameters = insertParams; 

                    string query = $"INSERT INTO {ChildTable} ({string.Join(",", insertColumns)}) VALUES ({string.Join(",", insertParameters)})";
                    SqlCommand command = new SqlCommand(query, connection);

                    for (int i = 0; i < insertColumns.Count; i++)
                    {
                        string param = insertParameters[i];
                        string column = insertColumns[i];
                        string value = this.Controls[column] is TextBox tb ? tb.Text : "";
                        command.Parameters.AddWithValue(param, value);
                    }

                    command.ExecuteNonQuery();
                }

                MessageBox.Show("Inserare reușită!");
                button4_Click(null, null);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Eroare la inserare: " + ex.Message);
            }
        }


        private void button3_Click(object sender, EventArgs e)
        {
            if (bindingChild.Current is not DataRowView rowView) return;

            string id = rowView[ChildPrimaryKey].ToString();

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    var setClause = string.Join(",", childColumns.Where(c => c != ChildPrimaryKey).Select(c => $"{c}=@{c}"));
                    SqlCommand command = new SqlCommand($"UPDATE {ChildTable} SET {setClause} WHERE {ChildPrimaryKey}=@{ChildPrimaryKey}", connection);

                    foreach (var col in childColumns)
                    {
                        string value = Controls[col] is TextBox tb ? tb.Text : "";
                        command.Parameters.AddWithValue("@" + col, value);
                    }

                    command.ExecuteNonQuery();
                }

                MessageBox.Show("Actualizare reușită!");
                button4_Click(null, null);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Eroare la actualizare: " + ex.Message);
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (bindingChild.Current is not DataRowView rowView) return;

            string id = rowView[ChildPrimaryKey].ToString();

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    SqlCommand command = new SqlCommand($"DELETE FROM {ChildTable} WHERE {ChildPrimaryKey}=@id", connection);
                    command.Parameters.AddWithValue("@id", id);
                    command.ExecuteNonQuery();
                }

                MessageBox.Show("Ștergere reușită!");
                button4_Click(null, null);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Eroare la ștergere: " + ex.Message);
            }
        }
    }
}
