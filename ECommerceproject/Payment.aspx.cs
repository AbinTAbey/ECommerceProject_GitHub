using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.ServiceModel;
using System.Security.Cryptography;
using System.Text;
using System.Web.Security;

namespace ECommerceproject
{
    public partial class Payment : System.Web.UI.Page
    {
        private const string ConnectionString = @"server=DESKTOP-N272NOH\SQLEXPRESS;database=ECommerceProject;integrated security=true";

        protected void Page_Load(object sender, EventArgs e)
        {
            btnPayNow.Enabled = false;
            if (!String.Equals(Convert.ToString(Session["Role"]), "User", StringComparison.Ordinal) || Session["UserId"] == null)
            {
               litStatus.Text = "Sign in with a customer account to use Demo Bank.";
               return;
            }
            DataTable cart = Session["PendingCheckout"] as DataTable;
            string requestKey = Session["PendingCheckoutKey"] as string;
            if (!HasValidCheckout(cart, requestKey))
            {
               SetUnavailableSummary("Checkout details expired or are invalid. Return to checkout to review your cart again.");
               return;
            }
            try
            {
               int userId = Convert.ToInt32(Session["UserId"]);
               decimal total = RefreshCartPrices(cart);
               Session["PendingCheckoutTotal"] = total;
               rptPaymentItems.DataSource = cart;
               rptPaymentItems.DataBind();
               int itemCount = 0;
               foreach (DataRow row in cart.Rows)
                   itemCount += Convert.ToInt32(row["Quantity"]);

               // Bind all trusted order details before the independent account lookup.
               // A missing Bank row must not hide an otherwise valid checkout summary.
               litItems.Text = Server.HtmlEncode(itemCount + " item(s)");
               litCharge.Text = FormatMoney(total);
               litTotal.Text = FormatMoney(total);
               litBalance.Text = "Unavailable";
               litRemaining.Text = "—";

               decimal balance;
               try
               {
                   using (SqlConnection connection = new SqlConnection(ConnectionString))
                   using (SqlCommand command = new SqlCommand("SELECT Balance FROM dbo.Bank WHERE user_id=@uid", connection))
                   {
                       command.Parameters.Add("@uid", SqlDbType.Int).Value = userId;
                       connection.Open();
                       object value = command.ExecuteScalar();
                       if (value == null || value == DBNull.Value)
                       {
                           litStatus.Text = "No Demo Bank account is available for this customer. Your checkout summary is shown; payment is unavailable.";
                           return;
                       }
                       balance = Convert.ToDecimal(value);
                   }
               }
               catch (SqlException)
               {
                   litStatus.Text = "The Demo Bank account could not be checked right now. Your checkout summary is shown; payment is unavailable.";
                   return;
               }

               litBalance.Text = FormatMoney(balance);
               litRemaining.Text = FormatMoney(balance - total);
               if (balance < total)
                   litStatus.Text = "Insufficient Demo Bank balance. Your cart is unchanged; no payment has been made.";
               else
               {
                   litStatus.Text = "Order summary and balance loaded for your signed-in account. This is a simulated Demo Bank payment.";
                   btnPayNow.Enabled = true;
               }
            }
            catch (InvalidOperationException)
            {
               SetUnavailableSummary("A cart item is no longer available or has invalid checkout data. Return to checkout to refresh your cart.");
            }
            catch (SqlException)
            {
               SetUnavailableSummary("Payment details are temporarily unavailable. Your cart has been preserved; please try again later.");
            }
            catch
            {
               SetUnavailableSummary("Payment details could not be loaded. Your cart has been preserved.");
            }
        }

       protected void btnPayNow_Click(object sender, EventArgs e)
       {
           btnPayNow.Enabled = false;
           if (!String.Equals(Request.Form["paymentMethod"], "demo-bank", StringComparison.Ordinal))
           {
               litStatus.Text = "Only the simulated Demo Bank payment is available. No payment was processed.";
               return;
           }
           if (!String.Equals(Convert.ToString(Session["Role"]), "User", StringComparison.Ordinal) || Session["UserId"] == null)
           {
               litStatus.Text = "Sign in with a customer account before paying.";
               return;
           }
           DataTable cart = Session["PendingCheckout"] as DataTable;
           string requestKey = Session["PendingCheckoutKey"] as string;
           if (!HasValidCheckout(cart, requestKey))
           {
               litStatus.Text = "This checkout has expired or is invalid. Return to checkout to review it again; your cart was not charged.";
               return;
           }
           int userId = Convert.ToInt32(Session["UserId"]);
           decimal total = CalculateTotal(cart);
           decimal checkoutTotal;
           object savedCheckoutTotal = Session["PendingCheckoutTotal"];
           if (savedCheckoutTotal != null && Decimal.TryParse(Convert.ToString(savedCheckoutTotal, CultureInfo.InvariantCulture), NumberStyles.Number, CultureInfo.InvariantCulture, out checkoutTotal) && checkoutTotal == total)
               total = checkoutTotal;
           // Re-save the value derived from the refreshed server-side cart, never a posted amount.
           Session["PendingCheckoutTotal"] = total;
           List<CartItemDto> items = new List<CartItemDto>();
           foreach (DataRow row in cart.Rows)
               items.Add(new CartItemDto { ProductId = Convert.ToInt32(row["ProductID"]), ProductName = Convert.ToString(row["ProductName"]), Quantity = Convert.ToInt32(row["Quantity"]), Price = Convert.ToDecimal(row["Price"]) });
           string ticketClaims = userId.ToString(CultureInfo.InvariantCulture) + "|" + requestKey + "|" + CartFingerprint(items);
           string ticket = Convert.ToBase64String(MachineKey.Protect(Encoding.UTF8.GetBytes(ticketClaims), "OrderService", "PlaceOrder"));
           ChannelFactory<IOrderService> factory = new ChannelFactory<IOrderService>("OrderServiceEndpoint");
           factory.Endpoint.Address = new EndpointAddress(new Uri(Request.Url, "OrderService.svc"));
           IOrderService proxy = factory.CreateChannel();
           try
           {
               OrderResult result = proxy.PlaceOrder(userId, total, "Demo Bank", items, requestKey, ticket);
               ((IClientChannel)proxy).Close();
               factory.Close();
               if (!result.Success)
               {
                   litStatus.Text = Server.HtmlEncode(result.Message);
                   return;
               }
               Session["OrderId"] = result.OrderId;
               Session["TransactionId"] = result.TransactionId;
               Session["PaidAmount"] = result.PaidAmount;
               Session["FinalBalance"] = result.FinalBalance;
               Session["PendingRequestKey"] = requestKey;
               Session.Remove("Cart");
               Session.Remove("PendingCheckout");
               Session.Remove("PendingCheckoutTotal");
               Session.Remove("PendingCheckoutKey");
               Response.Redirect("OrderSuccess.aspx", false);
               Context.ApplicationInstance.CompleteRequest();
           }
           catch
           {
               try { ((IClientChannel)proxy).Abort(); } catch { }
               try { factory.Abort(); } catch { }
               litStatus.Text = "Payment could not be confirmed. Your cart is preserved; refresh the payment page before trying again.";
           }
       }

       private static decimal CalculateTotal(DataTable cart)
       {
           decimal subtotal = 0m;
           foreach (DataRow row in cart.Rows)
           {
               int quantity = Convert.ToInt32(row["Quantity"]);
               decimal price = Convert.ToDecimal(row["Price"]);
               if (quantity < 1 || price < 0) throw new InvalidOperationException();
               subtotal += price * quantity;
           }
           return subtotal - 22m + 40m;
       }

       private bool HasValidCheckout(DataTable cart, string requestKey)
       {
           if (cart == null || cart.Rows.Count == 0 || String.IsNullOrEmpty(requestKey) || requestKey.Length != 32)
               return false;

           Guid parsedKey;
           if (!Guid.TryParseExact(requestKey, "N", out parsedKey))
               return false;

           string[] requiredColumns = { "ProductID", "ProductName", "Price", "Quantity" };
           foreach (string column in requiredColumns)
               if (!cart.Columns.Contains(column)) return false;

           foreach (DataRow row in cart.Rows)
           {
               if (row.IsNull("ProductID") || row.IsNull("Quantity") || row.IsNull("Price")) return false;
               int productId;
               int quantity;
               decimal price;
               if (!Int32.TryParse(Convert.ToString(row["ProductID"], CultureInfo.InvariantCulture), out productId) || productId <= 0 ||
                   !Int32.TryParse(Convert.ToString(row["Quantity"], CultureInfo.InvariantCulture), out quantity) || quantity <= 0 ||
                   !Decimal.TryParse(Convert.ToString(row["Price"], CultureInfo.InvariantCulture), NumberStyles.Number, CultureInfo.InvariantCulture, out price) || price < 0m)
                   return false;
           }

           return true;
       }

       private void SetUnavailableSummary(string message)
       {
           litItems.Text = "Unavailable";
           litBalance.Text = "Unavailable";
           litCharge.Text = "—";
           litRemaining.Text = "—";
           litTotal.Text = "—";
           rptPaymentItems.DataSource = null;
           rptPaymentItems.DataBind();
           litStatus.Text = Server.HtmlEncode(message);
       }

       private static decimal RefreshCartPrices(DataTable cart)
       {
           decimal subtotal = 0m;
           using (SqlConnection connection = new SqlConnection(ConnectionString))
           {
               connection.Open();
               foreach (DataRow row in cart.Rows)
               {
                   int productId = Convert.ToInt32(row["ProductID"]);
                   int quantity = Convert.ToInt32(row["Quantity"]);
                   if (productId <= 0 || quantity <= 0) throw new InvalidOperationException("Invalid cart item.");
                   using (SqlCommand command = new SqlCommand("SELECT [product name],[price] FROM dbo.Product WHERE [product id]=@productId", connection))
                   {
                       command.Parameters.Add("@productId", SqlDbType.Int).Value = productId;
                       using (SqlDataReader reader = command.ExecuteReader())
                       {
                           if (!reader.Read()) throw new InvalidOperationException("A product in this cart is no longer available.");
                           decimal price = Convert.ToDecimal(reader["price"]);
                           if (price < 0) throw new InvalidOperationException("Invalid product price.");
                           row["ProductName"] = Convert.ToString(reader["product name"]);
                           row["Price"] = price;
                           subtotal += price * quantity;
                       }
                   }
               }
           }
           return subtotal - 22m + 40m;
       }

       private static string CartFingerprint(List<CartItemDto> items)
       {
           List<string> entries = new List<string>();
           foreach (CartItemDto item in items) entries.Add(item.ProductId.ToString(CultureInfo.InvariantCulture) + ":" + item.Quantity.ToString(CultureInfo.InvariantCulture));
           entries.Sort(StringComparer.Ordinal);
           using (SHA256 sha = SHA256.Create())
               return BitConverter.ToString(sha.ComputeHash(Encoding.UTF8.GetBytes(String.Join(";", entries.ToArray())))).Replace("-", String.Empty);
       }

       private static string FormatMoney(decimal amount)
       {
           return "₹" + amount.ToString("N2", CultureInfo.GetCultureInfo("en-IN"));
       }
    }
}
