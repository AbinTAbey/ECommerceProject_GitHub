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
    public partial class Product : System.Web.UI.Page
    {
        DBConnection dbobj = new DBConnection();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string catQuery = "select [category id], [category name] from Category";
                DataTable dt = dbobj.fn_adapterTable(catQuery);

                DropDownList1.DataSource = dt;
                DropDownList1.DataTextField = "category name";   
                DropDownList1.DataValueField = "category id";     
                DropDownList1.DataBind();
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            
                string productName = TextBox1.Text.Trim();
                string description = TextBox2.Text.Trim();
                string priceText = TextBox3.Text.Trim();
                string quantityText = TextBox4.Text.Trim();

                if (string.IsNullOrEmpty(productName) || string.IsNullOrEmpty(description) ||
                    string.IsNullOrEmpty(priceText) || string.IsNullOrEmpty(quantityText))
                {
                    Label1.Visible = true;
                    Label1.Text = "Please fill in all fields";
                    return;
                }

                int categoryId;
                if (!int.TryParse(DropDownList1.SelectedValue, out categoryId))
                {
                    Label1.Visible = true;
                    Label1.Text = "Please select a valid category";
                    return;
                }

                decimal price;
                if (!decimal.TryParse(priceText, out price) || price <= 0)
                {
                    Label1.Visible = true;
                    Label1.Text = "Please enter a valid price";
                    return;
                }

                int quantity;
                if (!int.TryParse(quantityText, out quantity) || quantity < 0)
                {
                    Label1.Visible = true;
                    Label1.Text = "Please enter a valid quantity";
                    return;
                }

                if (!FileUpload1.HasFile)
                {
                    Label1.Visible = true;
                    Label1.Text = "Please select a product image";
                    return;
                }

                string ext = System.IO.Path.GetExtension(FileUpload1.FileName).ToLower();
                if (ext != ".jpg" && ext != ".jpeg" && ext != ".png" && ext != ".gif")
                {
                    Label1.Visible = true;
                    Label1.Text = "Only image files are allowed (jpg, jpeg, png, gif)";
                    return;
                }

            // Ensure the ProductPhotos directory exists
            string photoDir = Server.MapPath("~/ProductPhotos/");
            if (!System.IO.Directory.Exists(photoDir))
                System.IO.Directory.CreateDirectory(photoDir);

            // Generate a unique filename to prevent overwrites
            string safeOriginal = System.IO.Path.GetFileName(FileUpload1.FileName);
            string uniqueFilename = Guid.NewGuid().ToString("N") + ext;
            string p = "~/ProductPhotos/" + uniqueFilename;

            try
                {
                    FileUpload1.SaveAs(Server.MapPath(p));
                }
                catch (Exception)
                {
                    Label1.Visible = true;
                    Label1.Text = "Failed to upload image";
                    return;
               }

                string safeName = productName.Replace("'", "''");
                string safeDescription = description.Replace("'", "''");
                string safeImagePath = p.Replace("'", "''");

                string query = "insert into Product ([product name], [category id], [description], [price], [quantity], [image]) values('" +
                                safeName + "', " + categoryId + ", '" + safeDescription + "', " +
                                price + ", " + quantity + ", '" + safeImagePath + "')";

                int i = dbobj.fn_nonquery(query);

                if (i > 0)
                {
                    Label1.Visible = true;
                    Label1.Text = "Product added successfully";
                    TextBox1.Text = "";
                    TextBox2.Text = "";
                    TextBox3.Text = "";
                    TextBox4.Text = "";
                }
                else
                {
                    Label1.Visible = true;
                    Label1.Text = "Failed to add product";
                }
            
        }
    }
}