using System;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;

namespace ECommerceproject
{
    public partial class OrderSuccess : System.Web.UI.Page
    {
        private const string ConnectionString = @"server=DESKTOP-N272NOH\SQLEXPRESS;database=ECommerceProject;integrated security=true";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!String.Equals(Convert.ToString(Session["Role"]), "User", StringComparison.Ordinal) || Session["UserId"] == null || Session["OrderId"] == null || Session["PendingRequestKey"] == null)
            {
                Response.Redirect("Home.aspx");
                return;
            }
            if (IsPostBack) return;
            int userId = Convert.ToInt32(Session["UserId"]);
            int orderId = Convert.ToInt32(Session["OrderId"]);
            Guid checkoutKey;
            string requestKey = Convert.ToString(Session["PendingRequestKey"]);
            if (!Guid.TryParseExact(requestKey, "N", out checkoutKey)) { Response.Redirect("Home.aspx"); return; }
            string transactionId = "TXN" + checkoutKey.ToString("N").ToUpperInvariant();
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand("SELECT o.order_id,o.OrderDate,o.Status,p.Amount,p.TransactionId,p.PaymentDate FROM [Order] o INNER JOIN Payment p ON p.order_id=o.order_id WHERE o.order_id=@oid AND o.user_id=@uid AND p.user_id=@uid AND p.TransactionId=@transactionId AND o.Status='Confirmed' AND p.Status='Success'", connection))
                {
                    command.Parameters.Add("@oid", SqlDbType.Int).Value = orderId;
                    command.Parameters.Add("@uid", SqlDbType.Int).Value = userId;
                    command.Parameters.Add("@transactionId", SqlDbType.NVarChar, 100).Value = transactionId;
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (!reader.Read()) { Response.Redirect("Home.aspx"); return; }
                        lblOrderId.Text = reader["order_id"].ToString();
                        lblConfirmationOrderId.Text = lblOrderId.Text;
                        DateTime orderDate = Convert.ToDateTime(reader["OrderDate"]);
                        DateTime paymentDate = Convert.ToDateTime(reader["PaymentDate"]);
                        lblOrderDate.Text = "Placed " + orderDate.ToString("dd MMM yyyy, h:mm tt", CultureInfo.GetCultureInfo("en-IN")) +
                            " · paid " + paymentDate.ToString("dd MMM yyyy, h:mm tt", CultureInfo.GetCultureInfo("en-IN"));
                        lblOrderStatus.Text = Convert.ToString(reader["Status"]);
                        lblPaymentAmount.Text = Convert.ToDecimal(reader["Amount"]).ToString("N2", CultureInfo.GetCultureInfo("en-IN"));
                        lblTransactionId.Text = Server.HtmlEncode(Convert.ToString(reader["TransactionId"]));
                    }
                }
                using (SqlCommand items = new SqlCommand("SELECT [Product Name] AS ProductName,Quantity,Price FROM cart WHERE [order id]=@oid", connection))
                {
                    items.Parameters.Add("@oid", SqlDbType.Int).Value = orderId;
                    DataTable table = new DataTable();
                    using (SqlDataAdapter adapter = new SqlDataAdapter(items)) adapter.Fill(table);
                    rptItems.DataSource = table;
                    rptItems.DataBind();
                }
                using (SqlCommand balance = new SqlCommand("SELECT Balance FROM Bank WHERE user_id=@uid", connection))
                {
                    balance.Parameters.Add("@uid", SqlDbType.Int).Value = userId;
                    object value = balance.ExecuteScalar();
                    if (value == null || value == DBNull.Value) { Response.Redirect("Home.aspx"); return; }
                    lblFinalBalance.Text = Convert.ToDecimal(value).ToString("N2", CultureInfo.GetCultureInfo("en-IN"));
                }
            }
        }

        protected string GetItemPrice(object price)
        {
            return Convert.ToDecimal(price).ToString("N2", CultureInfo.GetCultureInfo("en-IN"));
        }
    }
}
