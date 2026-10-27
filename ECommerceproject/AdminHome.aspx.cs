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
    public partial class Admin : System.Web.UI.Page
    {
        DBConnection dbobj = new DBConnection();

        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (Session["Role"] == null || Session["Role"].ToString() != "Admin")
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadProducts();
            }
        }

        void LoadProducts()
        {
            string query =
                "SELECT P.[product id], " +
                "C.[category name], " +
                "P.[image] " +
                "FROM Product P " +
                "INNER JOIN Category C " +
                "ON P.[category id] = C.[category id] " +
                "ORDER BY P.[product id] DESC";

            DataTable dt = dbobj.fn_adapterTable(query);

            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string productid =
                GridView1.DataKeys[e.RowIndex].Value.ToString();

            string query =
                "DELETE FROM Product WHERE [product id] = @productid";

            SqlParameter[] parameters =
            {
                new SqlParameter("@productid", productid)
            };

            dbobj.fn_nonquery(query, parameters);

            LoadProducts();
        }
    }
}