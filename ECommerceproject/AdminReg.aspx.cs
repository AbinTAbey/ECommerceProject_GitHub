using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ECommerceproject
{
    public partial class AdminReg : System.Web.UI.Page
    {
        DBConnection dbobj = new DBConnection();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string adminname = TextBox1.Text.Trim();
            string adminemail = TextBox4.Text.Trim();

            
            if (string.IsNullOrEmpty(adminname) || string.IsNullOrEmpty(adminemail))
            {
                Label1.Visible = true;
                Label1.Text = "Please fill in all fields";
                return;
            }

           
            string safeName = adminname.Replace("'", "''");
            string safeEmail = adminemail.Replace("'", "''");

            string checkquery = "select count(*) from Admin where [admin email]='" + safeEmail + "'";
            string count = dbobj.fn_scalar(checkquery);

            if (count != "0")
            {
                Label1.Visible = true;
                Label1.Text = "Admin with this email already exists";
                return;
            }

            string query = "insert into Admin ([admin name], [admin email]) values('" + safeName + "', '" + safeEmail + "')";
            int i = dbobj.fn_nonquery(query);

            if (i > 0)
            {
                //Label1.Visible = true;
                //Label1.Text = "Admin registration successful";
                //TextBox1.Text = "";
                //TextBox4.Text = "";
                Response.Redirect("Login.aspx?type=admin");
            }
            else
            {
                Label1.Visible = true;
                Label1.Text = "Admin registration failed";
            }
        }
    }
}