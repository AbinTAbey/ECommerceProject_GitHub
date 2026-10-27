using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace ECommerceproject
{
    public partial class Checkout : System.Web.UI.Page
    {
        DBConnection dbobj = new DBConnection();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                HandleLoginProfileState();
                LoadUserInfo();
                LoadCartSummary();
            }
        }

        private void LoadUserInfo()
        {
            string username = Session["Username"] as string;

            if (!string.IsNullOrEmpty(username))
            {
                string safeUsername = username.Replace("'", "''");
                string query = "SELECT [user id], [username], [Address], [[Phone no], [Email] FROM User_Reg WHERE username = '" + safeUsername + "'";
                
                SqlDataReader dr = dbobj.fn_reader(query);
                if (dr.Read())
                {
                    string phone = dr["[Phone no"].ToString();
                    string address = dr["Address"].ToString();
                    string email = dr["Email"].ToString();

                    lblLoginName.Text = username;
                    lblLoginPhone.Text = phone;
                    
                    lblLoginNameSaved.Text = username;
                    lblLoginPhoneSaved.Text = phone;

                    lblAddressNameSaved.Text = username;
                    lblAddressPhoneSaved.Text = phone;
                    lblAddressEmailSaved.Text = email;
                    
                    if (Session["TempDeliveryAddress"] != null)
                    {
                        lblAddressFullSaved.Text = Session["TempDeliveryAddress"].ToString();
                    }
                    else
                    {
                        lblAddressFullSaved.Text = address;
                    }

                    // Pre-fill delivery form
                    txtName.Text = username;
                    txtMobile.Text = phone;
                    txtAddress.Text = address;
                    txtEmail.Text = email;
                }
                dr.Close();
            }
            else
            {
                lblLoginName.Text = "Not signed in";
                lblLoginPhone.Text = "";
            }
        }

        private void LoadCartSummary()
        {
            DataTable dtCart = Session["Cart"] as DataTable;

            if (dtCart == null || dtCart.Rows.Count == 0)
            {
                rptReviewCart.Visible = false;
                pnlEmptyCart.Visible = true;
                lblItemCount.Text = "0";
                lblSubTotal.Text = "0.00";
                lblGrandTotal.Text = "0.00";
                lblReviewItemCount.Text = "0 items";
                return;
            }

            pnlEmptyCart.Visible = false;
            rptReviewCart.Visible = true;
            rptReviewCart.DataSource = dtCart;
            rptReviewCart.DataBind();

            int totalItems = 0;
            decimal subTotal = 0;

            foreach (DataRow row in dtCart.Rows)
            {
                int qty = Convert.ToInt32(row["Quantity"]);
                decimal price = Convert.ToDecimal(row["Price"]);
                totalItems += qty;
                subTotal += qty * price;
            }

            decimal deliveryCharge = 40m;
            decimal discount = 22m; // Existing checkout summary displays a fixed ₹22 discount.
            decimal grandTotal = subTotal - discount + deliveryCharge;

            lblItemCount.Text = totalItems.ToString();
            lblSubTotal.Text = subTotal.ToString("0.00");
            lblGrandTotal.Text = grandTotal.ToString("0.00");
            lblReviewItemCount.Text = totalItems + " item(s)";
        }

        protected void btnChangeAddress_Click(object sender, EventArgs e)
        {
            pnlDeliverySaved.Visible = false;
            pnlDeliveryOptions.Visible = true;
            pnlAddNewAddress.Visible = false;
            pnlEditDetails.Visible = false;
        }

        protected void btnAddAddressOption_Click(object sender, EventArgs e)
        {
            pnlDeliveryOptions.Visible = false;
            pnlAddNewAddress.Visible = true;
        }

        protected void btnEditDetailsOption_Click(object sender, EventArgs e)
        {
            pnlDeliveryOptions.Visible = false;
            pnlEditDetails.Visible = true;
        }

        protected void btnSaveTempAddress_Click(object sender, EventArgs e)
        {
            string newAddress = txtAddress.Text;

            Session["TempDeliveryAddress"] = newAddress;
            lblAddressFullSaved.Text = newAddress;

            pnlAddNewAddress.Visible = false;
            pnlDeliverySaved.Visible = true;
        }

        protected void btnSaveDetails_Click(object sender, EventArgs e)
        {
            string currentUsername = Session["Username"] as string;
            if (string.IsNullOrEmpty(currentUsername)) return;

            string safeCurrentUsername = currentUsername.Replace("'", "''");
            string safeNewName = txtName.Text.Replace("'", "''");
            string safeMobile = txtMobile.Text.Replace("'", "''");
            string safeEmail = txtEmail.Text.Replace("'", "''");

            string query = "UPDATE User_Reg SET [username] = '" + safeNewName + "', [[Phone no] = '" + safeMobile + "', [Email] = '" + safeEmail + "' WHERE username = '" + safeCurrentUsername + "'";
            dbobj.fn_nonquery(query);

            Session["Username"] = txtName.Text;

            LoadUserInfo();

            pnlEditDetails.Visible = false;
            pnlDeliverySaved.Visible = true;
        }

        protected void btnContinueCheckout_Click(object sender, EventArgs e) { }
        protected void btnChangeLogin_Click(object sender, EventArgs e) { }
        protected void btnChangeCart_Click(object sender, EventArgs e) { }
        protected void btnContinueCart_Click(object sender, EventArgs e) { }
        protected void btnConfirmOrder_Click(object sender, EventArgs e)
        {
            if (!String.Equals(Request.Form["flexRadioDefault"], "online", StringComparison.Ordinal))
            {
                ClientScript.RegisterStartupScript(GetType(), "payment-method", "alert('Cash on Delivery is not connected. Please choose Online to continue with simulated Demo Bank payment.');", true);
                return;
            }
            if (Session["UserId"] == null || !String.Equals(Convert.ToString(Session["Role"]), "User", StringComparison.Ordinal))
            {
                Response.Redirect("Login.aspx");
                return;
            }
            DataTable cart = Session["Cart"] as DataTable;
            if (cart == null || cart.Rows.Count == 0)
            {
                lblGrandTotal.Text = "Your cart is empty.";
                return;
            }
            decimal subtotal = 0m;
            foreach (DataRow row in cart.Rows)
                subtotal += Convert.ToDecimal(row["Price"]) * Convert.ToInt32(row["Quantity"]);
            Session["PendingCheckout"] = cart.Copy();
            Session["PendingCheckoutTotal"] = subtotal - 22m + 40m;
            Session["PendingCheckoutKey"] = Guid.NewGuid().ToString("N");
            Response.Redirect("Payment.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }

        private void HandleLoginProfileState()
        {
            if (lnkLoginProfile == null) return;
            if (Session["UserId"] != null && Session["Username"] != null)
            {
                string fullName = Session["Username"].ToString();
                string firstName = fullName.Split(new[] { ' ' }, StringSplitOptions.RemoveEmptyEntries)[0];
                litProfileName.Text = firstName;
            }
            else
            {
                litProfileName.Text = "";
            }
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
