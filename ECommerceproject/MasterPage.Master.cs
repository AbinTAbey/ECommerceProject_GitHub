using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ECommerceproject
{
    public partial class MasterPage : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) { HandleLoginProfileState(); }

            if (liContactUs != null)
            {
                string currentPage = System.IO.Path.GetFileName(Request.Url.AbsolutePath);
                liContactUs.Visible = string.Equals(currentPage, "Home.aspx", StringComparison.OrdinalIgnoreCase);
            }

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
