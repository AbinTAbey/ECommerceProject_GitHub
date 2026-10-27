using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ECommerceproject
{
    public partial class cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                HandleLoginProfileState();
                LoadCart();
            }
        }

        private void LoadCart()
        {
            DataTable dtCart = Session["Cart"] as DataTable;
            
            if (dtCart == null || dtCart.Rows.Count == 0)
            {
                pnlEmpty.Visible = true;
                rptCart.Visible = false;
                lblCartCount.Text = "0";
                lblItemCount.Text = "0";
                lblTotalPrice.Text = "0";
                lblGrandTotal.Text = "0";
                return;
            }

            pnlEmpty.Visible = false;
            rptCart.Visible = true;
            rptCart.DataSource = dtCart;
            rptCart.DataBind();

            int totalItems = 0;
            decimal totalPrice = 0;

            foreach (DataRow row in dtCart.Rows)
            {
                int qty = (int)row["Quantity"];
                decimal price = (decimal)row["Price"];
                totalItems += qty;
                totalPrice += (qty * price);
            }

            lblCartCount.Text = dtCart.Rows.Count.ToString();
            lblItemCount.Text = totalItems.ToString();
            lblTotalPrice.Text = totalPrice.ToString("0.00");
            lblGrandTotal.Text = totalPrice.ToString("0.00");
        }

        protected void rptCart_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            DataTable dtCart = Session["Cart"] as DataTable;
            if (dtCart == null) return;

            int productId = Convert.ToInt32(e.CommandArgument);

            for (int i = 0; i < dtCart.Rows.Count; i++)
            {
                DataRow row = dtCart.Rows[i];
                if ((int)row["ProductID"] == productId)
                {
                    int qty = (int)row["Quantity"];
                    int stock = (int)row["Stock"];

                    if (e.CommandName == "Plus")
                    {
                        if (qty < stock)
                            row["Quantity"] = qty + 1;
                    }
                    else if (e.CommandName == "Minus")
                    {
                        if (qty > 1)
                            row["Quantity"] = qty - 1;
                    }
                    else if (e.CommandName == "Remove")
                    {
                        dtCart.Rows.RemoveAt(i);
                    }
                    break;
                }
            }

            Session["Cart"] = dtCart;
            LoadCart();
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
