using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ECommerceproject
{
    public partial class ProductDetails : System.Web.UI.Page
    {
        DBConnection dbobj = new DBConnection();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                HandleLoginProfileState();
                string pdtid = Request.QueryString["pdtid"];
                if (!string.IsNullOrEmpty(pdtid))
                    LoadProduct(pdtid);
            }
        }

        private void LoadProduct(string pdtid)
        {
            int id;
            if (!int.TryParse(pdtid, out id)) return;

            string query =
                "SELECT P.[product id], P.[product name], P.[description], " +
                "P.[price], P.[quantity], P.[image], C.[category name] " +
                "FROM Product P " +
                "INNER JOIN Category C ON P.[category id] = C.[category id] " +
                "WHERE P.[product id] = " + id;

            DataTable dt = dbobj.fn_adapterTable(query);

            if (dt == null || dt.Rows.Count == 0) return;

            DataRow row = dt.Rows[0];

            string imagePath = row["image"].ToString();
            string resolvedImage = string.IsNullOrEmpty(imagePath) ? "./assets/image/1.jpeg" : imagePath;
            
            zoom_01.ImageUrl = resolvedImage;
            zoom_01.AlternateText = row["product name"].ToString();
            zoom_01.Attributes["data-zoom-image"] = Page.ResolveUrl(resolvedImage);

            lblProductName.Text  = row["product name"].ToString();
            lblPrice.Text        = row["price"].ToString();
            lblDescription.Text  = row["description"].ToString();
            
            int qty = 0;
            int.TryParse(row["quantity"].ToString(), out qty);
            
            if (qty > 0)
            {
                lblQuantity.Text = "In Stock";
                lblQuantity.CssClass = "text-green-600 font-bold";
                lnkAddToCart.Enabled = true;
                lnkBuyNow.Enabled = true;
            }
            else
            {
                lblQuantity.Text = "Out of Stock";
                lblQuantity.CssClass = "text-red-600 font-bold";
                lnkAddToCart.Enabled = false;
                lnkBuyNow.Enabled = false;
            }

            imgThumbnail1.ImageUrl = zoom_01.ImageUrl;
            imgThumbnail1.AlternateText = zoom_01.AlternateText;
            
            // Store product details in ViewState for cart addition
            ViewState["pdtid"] = id;
            ViewState["pdtname"] = row["product name"].ToString();
            ViewState["price"] = row["price"].ToString();
            ViewState["image"] = resolvedImage;
            ViewState["stock"] = qty;
        }

        protected void lnkAddToCart_Click(object sender, EventArgs e)
        {
            AddToCart();
            Response.Redirect("cart.aspx");
        }

        protected void lnkBuyNow_Click(object sender, EventArgs e)
        {
            AddToCart();
            Response.Redirect("cart.aspx");
        }

        private void AddToCart()
        {
            if (ViewState["pdtid"] == null) return;
            
            int pdtid = (int)ViewState["pdtid"];
            string name = ViewState["pdtname"].ToString();
            decimal price = Convert.ToDecimal(ViewState["price"]);
            string image = ViewState["image"].ToString();
            int stock = (int)ViewState["stock"];

            DataTable dtCart = Session["Cart"] as DataTable;
            if (dtCart == null)
            {
                dtCart = new DataTable();
                dtCart.Columns.Add("ProductID", typeof(int));
                dtCart.Columns.Add("ProductName", typeof(string));
                dtCart.Columns.Add("Image", typeof(string));
                dtCart.Columns.Add("Price", typeof(decimal));
                dtCart.Columns.Add("Quantity", typeof(int));
                dtCart.Columns.Add("Stock", typeof(int));
            }

            bool found = false;
            foreach (DataRow row in dtCart.Rows)
            {
                if ((int)row["ProductID"] == pdtid)
                {
                    int currentQty = (int)row["Quantity"];
                    if (currentQty < stock)
                    {
                        row["Quantity"] = currentQty + 1;
                    }
                    found = true;
                    break;
                }
            }

            if (!found)
            {
                if (stock > 0)
                {
                    dtCart.Rows.Add(pdtid, name, image, price, 1, stock);
                }
            }

            Session["Cart"] = dtCart;
        }
    
        private void HandleLoginProfileState()
        {
            if (lnkLoginProfile == null) return;
            string profileText = "Sign in / Sign up";
            if (Session["UserId"] != null && Session["Username"] != null)
            {
                string fullName = Session["Username"].ToString();
                profileText = fullName.Split(new[] { ' ' }, StringSplitOptions.RemoveEmptyEntries)[0];
            }
            lnkLoginProfile.Text = "<span style=\"display:flex; align-items:center;\"><svg xmlns=\"http://www.w3.org/2000/svg\" class=\"h-6 w-6\" viewBox=\"0 0 20 20\" fill=\"currentColor\"><path fill-rule=\"evenodd\" d=\"M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z\" clip-rule=\"evenodd\" /></svg></span><span class=\"hidden md:hidden sm:hidden lg:block ml-2 mt-[2px]\">" + profileText + "</span>";
        }

        protected void lnkLoginProfile_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] != null && Session["Username"] != null)
            {
                Session.Clear();
                Session.Abandon();
                Response.Redirect("Home.aspx");
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }
    }
}
