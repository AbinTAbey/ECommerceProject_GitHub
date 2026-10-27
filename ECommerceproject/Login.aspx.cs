using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ECommerceproject
{
    public partial class Login : System.Web.UI.Page
    {
        DBConnection dbobj = new DBConnection();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                UserPanel.Visible = true;
                AdminPanel.Visible = false;
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {

            string type = RadioButtonList1.SelectedValue;
            Label1.Visible = true;

            if (type == "User")
            {
                string username = TextBox1.Text.Trim();
                string password = TextBox2.Text;

                if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
                {
                    Label1.Text = "Please enter username and password";
                    return;
                }

                string safeUsername = username.Replace("'", "''");
                string safePassword = password.Replace("'", "''");

                string checkQuery = "select count(*) from User_Reg where [username]='" + safeUsername +
                                     "' and [password]='" + safePassword + "'";
                string count = dbobj.fn_scalar(checkQuery);
                if (count != "0")
                {
                    string idQuery = "select [user id] from User_Reg where [username]='" + safeUsername +
                                     "' and [password]='" + safePassword + "'";
                    string userId = dbobj.fn_scalar(idQuery);
                    Session["UserId"] = userId;
                    Session["Username"] = username;
                    Session["Role"] = "User";
                    Response.Redirect("Home.aspx");
                }
                else
                {
                    Label1.Text = "Invalid username or password";
                }
            }
            else if (type == "Admin")
            {
                string adminName = TextBox3.Text.Trim();
                string adminEmail = TextBox4.Text.Trim();

                if (string.IsNullOrEmpty(adminName) || string.IsNullOrEmpty(adminEmail))
                {
                    Label1.Text = "Please enter admin name and email";
                    return;
                }

                string safeName = adminName.Replace("'", "''");
                string safeEmail = adminEmail.Replace("'", "''");

                
                string checkQuery = "select count(*) from Admin where [admin name]='" + safeName +
                                     "' and [admin email]='" + safeEmail + "'";
                string count = dbobj.fn_scalar(checkQuery);

                if (count != "0")
                {
                    Session["AdminName"] = adminName;
                    Session["Role"] = "Admin";
                    Response.Redirect("AdminHome.aspx");
                }
                else
                {
                    Label1.Text = "Invalid admin name or email";
                }
            }
        }

        protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (RadioButtonList1.SelectedValue == "User")
            {
                UserPanel.Visible = true;
                AdminPanel.Visible = false;
                HyperLink1.Visible = true;  
                HyperLink2.Visible = false;
            }
            else
            {
                UserPanel.Visible = false;
                AdminPanel.Visible = true;
                HyperLink1.Visible = false;
                HyperLink2.Visible = true;
            }

            Label1.Visible = false;
        }
    }
}