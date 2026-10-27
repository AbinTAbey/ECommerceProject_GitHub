using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace ECommerceproject
{
    public partial class user : System.Web.UI.Page
    {
        DBConnection dbobj = new DBConnection();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string username = TextBox1.Text;
            string address = TextBox2.Text;
            string phone = TextBox3.Text;
            string email = TextBox4.Text;
            string password = TextBox5.Text;
            string confirmpassword = TextBox6.Text;

            if (password != confirmpassword)
            {
                Label1.Visible = true;
                Label1.Text = "Password and Confirm Password do not match";
                return;
            }

            try
            {
                const string connectionString = @"server=DESKTOP-N272NOH\SQLEXPRESS;database=ECommerceProject;integrated security=true";
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    using (SqlTransaction transaction = connection.BeginTransaction(IsolationLevel.Serializable))
                    {
                        using (SqlCommand check = new SqlCommand("SELECT COUNT(*) FROM User_Reg WITH (UPDLOCK, HOLDLOCK) WHERE [username]=@username", connection, transaction))
                        {
                            check.Parameters.Add("@username", SqlDbType.NVarChar, 256).Value = username;
                            if (Convert.ToInt32(check.ExecuteScalar()) != 0)
                            {
                                transaction.Rollback();
                                Label1.Visible = true;
                                Label1.Text = "Username already exists";
                                return;
                            }
                        }
                        int userId;
                        using (SqlCommand nextId = new SqlCommand("SELECT ISNULL(MAX([user id]),1000)+1 FROM User_Reg WITH (UPDLOCK, HOLDLOCK)", connection, transaction))
                            userId = Convert.ToInt32(nextId.ExecuteScalar());
                        using (SqlCommand insertUser = new SqlCommand("INSERT INTO User_Reg ([user id],[username],[Address],[[Phone no],[Email],[password],[confirm password]) VALUES (@id,@username,@address,@phone,@email,@password,@confirm)", connection, transaction))
                        {
                            insertUser.Parameters.Add("@id", SqlDbType.Int).Value = userId;
                            insertUser.Parameters.Add("@username", SqlDbType.NVarChar, 256).Value = username;
                            insertUser.Parameters.Add("@address", SqlDbType.NVarChar, 1000).Value = address;
                            insertUser.Parameters.Add("@phone", SqlDbType.NVarChar, 50).Value = phone;
                            insertUser.Parameters.Add("@email", SqlDbType.NVarChar, 256).Value = email;
                            insertUser.Parameters.Add("@password", SqlDbType.NVarChar, 256).Value = password;
                            insertUser.Parameters.Add("@confirm", SqlDbType.NVarChar, 256).Value = confirmpassword;
                            insertUser.ExecuteNonQuery();
                        }
                        using (SqlCommand insertBank = new SqlCommand("INSERT INTO Bank (user_id, Balance) VALUES (@id, @balance)", connection, transaction))
                        {
                            insertBank.Parameters.Add("@id", SqlDbType.Int).Value = userId;
                            insertBank.Parameters.Add("@balance", SqlDbType.Decimal).Value = 25000.00m;
                            insertBank.Parameters["@balance"].Precision = 18;
                            insertBank.Parameters["@balance"].Scale = 2;
                            insertBank.ExecuteNonQuery();
                        }
                        transaction.Commit();
                    }
                }
                Label1.Visible = true;
                Label1.Text = "Registration successful.";
                TextBox1.Text = "";
                TextBox2.Text = "";
                TextBox3.Text = "";
                TextBox4.Text = "";
                TextBox5.Text = "";
                TextBox6.Text = "";
            }
            catch (Exception)
            {
                Label1.Visible = true;
                Label1.Text = "Registration failed. Please try again.";
            }
        }

    }
}
