using System;
using System.Data;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ECommerceproject
{
    public partial class Filter : System.Web.UI.Page
    {
        DBConnection dbobj = new DBConnection();
        const int PageSize = 8;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                HandleLoginProfileState();
                LoadProducts();
            }
        }

        private void LoadProducts()
        {
            // -- Query string parameters
            int categoryId = 0;
            int.TryParse(Request.QueryString["categoryid"], out categoryId);

            int page = 1;
            int.TryParse(Request.QueryString["page"], out page);
            if (page < 1) page = 1;

            string sort = (Request.QueryString["sort"] ?? "popularity").ToLower().Trim();

            // -- WHERE clause
            string whereClause = categoryId > 0
                ? "WHERE P.[category id] = " + categoryId
                : "";

            // -- ORDER BY based on sort selection
            string orderBy;
            switch (sort)
            {
                case "lowtohigh":
                    orderBy = "P.[price] ASC";
                    break;
                case "hightolow":
                    orderBy = "P.[price] DESC";
                    break;
                case "latest":
                    orderBy = "P.[product id] DESC";
                    break;
                case "popularity":
                default:
                    orderBy = "P.[product id] ASC";
                    break;
            }

            // -- Total count for pagination and "Showing X of Y"
            string countQuery = "SELECT COUNT(*) FROM Product P " + whereClause;
            int totalProducts = 0;
            int.TryParse(dbobj.fn_scalar(countQuery), out totalProducts);
            int totalPages = (int)Math.Ceiling((double)totalProducts / PageSize);

            // Clamp page to valid range
            if (page > totalPages && totalPages > 0) page = totalPages;

            int offset = (page - 1) * PageSize;

            // -- Products for this page
            string dataQuery =
                "SELECT P.[product id], P.[product name], P.[price], P.[image], " +
                "C.[category name] " +
                "FROM Product P " +
                "INNER JOIN Category C ON P.[category id] = C.[category id] " +
                whereClause + " " +
                "ORDER BY " + orderBy + " " +
                "OFFSET " + offset + " ROWS FETCH NEXT " + PageSize + " ROWS ONLY";

            DataTable dt = dbobj.fn_adapterTable(dataQuery);
            int shownOnPage = (dt != null) ? dt.Rows.Count : 0;

            // -- Issue 1: Add dummy empty rows to ensure exactly 8 items (or 0)
            if (dt != null && dt.Rows.Count > 0 && dt.Rows.Count < PageSize)
            {
                int placeholdersNeeded = PageSize - dt.Rows.Count;
                for (int i = 0; i < placeholdersNeeded; i++)
                {
                    dt.Rows.Add(dt.NewRow()); // Creates a row where all columns are DBNull
                }
            }

            rptProducts.DataSource = dt;
            rptProducts.DataBind();

            // -- "Showing X of Y items"
            litItemCount.Text = string.Format(
                "<span class=\"pl-[10px] text-[12px] pt-[2px] text-[#878787]\">" +
                "(Showing {0} of {1} items)" +
                "</span>",
                shownOnPage, totalProducts);

            // -- Sort buttons
            BuildSortButtons(categoryId, sort);

            // -- Pagination
            BuildPagination(categoryId, sort, page, totalPages);
        }

        private void BuildSortButtons(int categoryId, string currentSort)
        {
            string baseUrl = "Filter.aspx?" +
                (categoryId > 0 ? "categoryid=" + categoryId + "&" : "");

            string normalClass =
                "text-[13px] rounded border-2 hover:bg-[#008ECC] hover:text-white " +
                "border-[#7FC6E5] pl-4 pr-4";
            string activeClass =
                "text-[13px] rounded border-2 bg-[#008ECC] text-white " +
                "border-[#008ECC] pl-4 pr-4";

            string[][] sortOptions = new string[][]
            {
                new string[] { "popularity",  "Popularity"  },
                new string[] { "lowtohigh",   "Low to High" },
                new string[] { "hightolow",   "High to Low" },
                new string[] { "latest",      "Latest"      },
            };

            var sb = new StringBuilder();
            foreach (var opt in sortOptions)
            {
                string cls = opt[0] == currentSort ? activeClass : normalClass;
                sb.AppendFormat(
                    "<a href=\"{0}sort={1}\" class=\"{2}\">{3}</a>",
                    baseUrl, opt[0], cls, opt[1]);
            }

            litSortButtons.Text = sb.ToString();
        }

        private void BuildPagination(int categoryId, string sort, int currentPage, int totalPages)
        {
            if (totalPages <= 1)
            {
                litPagination.Text = "";
                return;
            }

            string baseUrl = "Filter.aspx?" +
                (categoryId > 0 ? "categoryid=" + categoryId + "&" : "") +
                "sort=" + sort + "&";

            var sb = new StringBuilder();

            // PREVIOUS
            string prevClass = "flex justify-center items-center leading-[28px] " +
                               "text-center font-medium text-blue-600 mr-5";
            if (currentPage > 1)
                sb.AppendFormat(
                    "<li><a href=\"{0}page={1}\" class=\"{2}\">PREVIOUS</a></li>",
                    baseUrl, currentPage - 1, prevClass);
            else
                sb.AppendFormat(
                    "<li><span class=\"{0} opacity-40\">PREVIOUS</span></li>",
                    prevClass);

            // Page numbers
            for (int i = 1; i <= totalPages; i++)
            {
                string cls = i == currentPage
                    ? "flex justify-center items-center leading-[28px] links-click active " +
                      "w-8 h-8 text-center rounded-full mr-1 ml-1"
                    : "flex justify-center items-center leading-[28px] links-click " +
                      "w-8 h-8 text-center rounded-full mr-1 ml-1";
                sb.AppendFormat(
                    "<li><a href=\"{0}page={1}\" class=\"{2}\">{1}</a></li>",
                    baseUrl, i, cls);
            }

            // NEXT
            string nextClass = "flex justify-center items-center leading-[28px] " +
                               "link-next text-center font-medium text-blue-600 ml-5";
            if (currentPage < totalPages)
                sb.AppendFormat(
                    "<li><a href=\"{0}page={1}\" class=\"{2}\">NEXT</a></li>",
                    baseUrl, currentPage + 1, nextClass);
            else
                sb.AppendFormat(
                    "<li><span class=\"{0} opacity-40\">NEXT</span></li>",
                    nextClass);

            litPagination.Text = sb.ToString();
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
                litProfileName.Text = "Sign in / Sign up";
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