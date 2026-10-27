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
    public partial class Category : System.Web.UI.Page
    {
        DBConnection dbobj = new DBConnection();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindCategories();
            }
        }

        private void BindCategories()
        {
            string search = txtSearch.Text.Trim();
            string query = "SELECT [category id], [category name] AS categoryname, [photo] AS image FROM Category";
            if (!string.IsNullOrEmpty(search))
            {
                query += " WHERE [category name] LIKE @search";
            }
            query += " ORDER BY [category id] DESC";

            using (SqlConnection connection = new SqlConnection(@"server=DESKTOP-N272NOH\SQLEXPRESS;database=ECommerceProject;integrated security=true"))
            using (SqlCommand command = new SqlCommand(query, connection))
            using (SqlDataAdapter adapter = new SqlDataAdapter(command))
            {
                if (!string.IsNullOrEmpty(search))
                {
                    command.Parameters.Add("@search", SqlDbType.NVarChar, 255).Value = "%" + search + "%";
                }
                DataTable categories = new DataTable();
                adapter.Fill(categories);
                gvCategories.DataSource = categories;
                gvCategories.DataBind();
            }
        }

        protected string CategoryPhotoUrl(object photoValue)
        {
            string storedPath = photoValue == null ? string.Empty : photoValue.ToString().Trim();
            string relativePath = storedPath.Replace('\\', '/');
            if (relativePath.StartsWith("~/", StringComparison.Ordinal))
            {
                relativePath = relativePath.Substring(2);
            }
            relativePath = relativePath.TrimStart('/');
            if (relativePath.IndexOf('/') < 0 && relativePath.Length > 0)
            {
                relativePath = "Phs/" + relativePath;
            }
            if (relativePath.Length > 0 && System.IO.File.Exists(Server.MapPath("~/" + relativePath)))
            {
                return ResolveUrl("~/" + relativePath);
            }
            string fileName = System.IO.Path.GetFileName(relativePath);
            string uploadPath = "~/Phs/" + fileName;
            if (fileName.Length > 0 && System.IO.File.Exists(Server.MapPath(uploadPath)))
            {
                return ResolveUrl(uploadPath);
            }
            return ResolveUrl("~/Phs/png-transparent.png");
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            gvCategories.EditIndex = -1;
            BindCategories();
        }

        protected void btnClearFilters_Click(object sender, EventArgs e)
        {
            txtSearch.Text = string.Empty;
            gvCategories.EditIndex = -1;
            BindCategories();
        }

        protected void gvCategories_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvCategories.EditIndex = e.NewEditIndex;
            BindCategories();
        }

        protected void gvCategories_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvCategories.EditIndex = -1;
            BindCategories();
        }

        protected void gvCategories_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int categoryId = Convert.ToInt32(gvCategories.DataKeys[e.RowIndex].Value);
            GridViewRow row = gvCategories.Rows[e.RowIndex];
            string categoryName = ((TextBox)row.FindControl("txtEditName")).Text.Trim();
            if (string.IsNullOrEmpty(categoryName))
            {
                lblListMessage.Text = "Category name cannot be empty.";
                lblListMessage.Visible = true;
                e.Cancel = true;
                return;
            }

            FileUpload upload = (FileUpload)row.FindControl("fuEditPhoto");
            string photoPath = null;
            if (upload != null && upload.HasFile)
            {
                photoPath = "~/Phs/" + System.IO.Path.GetFileName(upload.FileName);
                upload.SaveAs(Server.MapPath(photoPath));
            }
            string query = photoPath == null
                ? "UPDATE Category SET [category name] = @name WHERE [category id] = @id"
                : "UPDATE Category SET [category name] = @name, [photo] = @photo WHERE [category id] = @id";
            using (SqlConnection connection = new SqlConnection(@"server=DESKTOP-N272NOH\SQLEXPRESS;database=ECommerceProject;integrated security=true"))
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                command.Parameters.Add("@name", SqlDbType.NVarChar, 255).Value = categoryName;
                command.Parameters.Add("@id", SqlDbType.Int).Value = categoryId;
                if (photoPath != null)
                {
                    command.Parameters.Add("@photo", SqlDbType.NVarChar, 500).Value = photoPath;
                }
                connection.Open();
                command.ExecuteNonQuery();
            }
            gvCategories.EditIndex = -1;
            BindCategories();
        }

        protected void gvCategories_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int categoryId = Convert.ToInt32(gvCategories.DataKeys[e.RowIndex].Value);
            using (SqlConnection connection = new SqlConnection(@"server=DESKTOP-N272NOH\SQLEXPRESS;database=ECommerceProject;integrated security=true"))
            using (SqlCommand command = new SqlCommand("DELETE FROM Category WHERE [category id] = @id", connection))
            {
                command.Parameters.Add("@id", SqlDbType.Int).Value = categoryId;
                connection.Open();
                command.ExecuteNonQuery();
            }
            BindCategories();
        }

        protected void btnAddCategory_Click(object sender, EventArgs e)
        {
            string categoryName = txtCategoryName.Text.Trim();

            if (string.IsNullOrEmpty(categoryName))
            {
                lblMessage.Visible = true;
                lblMessage.Text = "Please enter a category name";
                return;
            }

            if (!fuCategoryPhoto.HasFile)
            {
                lblMessage.Visible = true;
                lblMessage.Text = "Please select a category photo";
                return;
            }

            string p = "~/Phs/" + fuCategoryPhoto.FileName;

            fuCategoryPhoto.SaveAs(Server.MapPath(p));

            string safeName = categoryName.Replace("'", "''");
            string safePath = p.Replace("'", "''");

            string query = "insert into Category ([category name], [photo]) values('" +
                            safeName + "', '" + safePath + "')";

            int i = dbobj.fn_nonquery(query);

            if (i > 0)
            {
                lblMessage.Visible = true;
                lblMessage.Text = "Category added successfully";
                txtCategoryName.Text = "";
            }
            else
            {
                lblMessage.Visible = true;
                lblMessage.Text = "Failed to add category";
            }
        }
    }
}
