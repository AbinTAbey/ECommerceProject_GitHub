using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.ServiceModel.Activation;
using System.Security.Cryptography;
using System.Text;
using System.Web.Security;

namespace ECommerceproject
{
    [AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
    public class OrderService : IOrderService
    {
        private const string ConnStr = @"server=DESKTOP-N272NOH\SQLEXPRESS;database=ECommerceProject;integrated security=true";
        private const decimal DeliveryCharge = 40m;
        private const decimal CheckoutDiscount = 22m;

        public OrderResult PlaceOrder(int userId, decimal totalAmount, string paymentMethod,
            List<CartItemDto> items, string requestKey, string authenticationTicket)
        {
            if (userId <= 0 || items == null || items.Count == 0 || items.Count > 100 || totalAmount <= 0)
                return Fail("Invalid checkout data.");
            Guid parsedKey;
            if (!Guid.TryParseExact(requestKey, "N", out parsedKey)) return Fail("Invalid checkout request.");
            if (!String.Equals(paymentMethod, "Demo Bank", StringComparison.Ordinal))
                return Fail("Only the simulated Demo Bank payment is available.");

            try
            {
                byte[] protectedClaims = Convert.FromBase64String(authenticationTicket ?? String.Empty);
                byte[] unprotected = MachineKey.Unprotect(protectedClaims, "OrderService", "PlaceOrder");
                string claims = unprotected == null ? String.Empty : Encoding.UTF8.GetString(unprotected);
                if (!String.Equals(claims, userId.ToString(CultureInfo.InvariantCulture) + "|" + requestKey + "|" + CartFingerprint(items), StringComparison.Ordinal))
                    return Fail("Checkout authentication failed.");
            }
            catch { return Fail("Checkout authentication failed."); }

            foreach (CartItemDto item in items)
                if (item == null || item.ProductId <= 0 || item.Quantity <= 0) return Fail("Invalid product or quantity in cart.");

            string transactionId = "TXN" + parsedKey.ToString("N").ToUpperInvariant();
            int orderId = 0;
            decimal paidAmount = 0m;
            decimal finalBalance = 0m;
            DateTime paymentDate = DateTime.MinValue;
            List<CartItemDto> validatedItems = new List<CartItemDto>();

            try
            {
                using (SqlConnection connection = new SqlConnection(ConnStr))
                {
                    connection.Open();
                    using (SqlTransaction transaction = connection.BeginTransaction(IsolationLevel.Serializable))
                    {
                        try
                        {
                            using (SqlCommand lockCommand = new SqlCommand("DECLARE @result int; EXEC @result=sp_getapplock @Resource=@resource,@LockMode='Exclusive',@LockOwner='Transaction',@LockTimeout=10000; SELECT @result;", connection, transaction))
                            {
                                lockCommand.Parameters.Add("@resource", SqlDbType.NVarChar, 255).Value = "OrderPayment:" + requestKey;
                                if (Convert.ToInt32(lockCommand.ExecuteScalar()) < 0) throw new InvalidOperationException("Checkout is already being processed. Please retry shortly.");
                            }

                            using (SqlCommand prior = new SqlCommand("SELECT p.order_id,p.user_id,p.Amount,p.PaymentDate,p.Status,o.Status AS OrderStatus FROM Payment p INNER JOIN [Order] o ON o.order_id=p.order_id WHERE p.TransactionId=@transactionId", connection, transaction))
                            {
                                prior.Parameters.Add("@transactionId", SqlDbType.NVarChar, 100).Value = transactionId;
                                using (SqlDataReader reader = prior.ExecuteReader())
                                {
                                    if (reader.Read())
                                    {
                                        if (Convert.ToInt32(reader["user_id"]) != userId || !String.Equals(Convert.ToString(reader["Status"]), "Success", StringComparison.OrdinalIgnoreCase) || !String.Equals(Convert.ToString(reader["OrderStatus"]), "Confirmed", StringComparison.OrdinalIgnoreCase))
                                            throw new InvalidOperationException("This checkout key is already associated with a different or incomplete payment.");
                                        orderId = Convert.ToInt32(reader["order_id"]);
                                        paidAmount = Convert.ToDecimal(reader["Amount"]);
                                        paymentDate = Convert.ToDateTime(reader["PaymentDate"]);
                                    }
                                }
                            }
                            if (orderId > 0)
                            {
                                using (SqlCommand bank = new SqlCommand("SELECT Balance FROM Bank WITH (UPDLOCK,HOLDLOCK) WHERE user_id=@userId", connection, transaction))
                                {
                                    bank.Parameters.Add("@userId", SqlDbType.Int).Value = userId;
                                    object balance = bank.ExecuteScalar();
                                    if (balance == null || balance == DBNull.Value) throw new InvalidOperationException("Demo Bank account not found.");
                                    finalBalance = Convert.ToDecimal(balance);
                                }
                                transaction.Commit();
                                return new OrderResult { Success = true, OrderId = orderId, TransactionId = transactionId, PaidAmount = paidAmount, FinalBalance = finalBalance, PaymentDate = paymentDate, PaymentMethod = paymentMethod, Message = "This checkout was already processed." };
                            }

                            using (SqlCommand user = new SqlCommand("SELECT COUNT(*) FROM User_Reg WITH (UPDLOCK,HOLDLOCK) WHERE [user id]=@userId", connection, transaction))
                            {
                                user.Parameters.Add("@userId", SqlDbType.Int).Value = userId;
                                if (Convert.ToInt32(user.ExecuteScalar()) != 1) throw new InvalidOperationException("Customer account was not found.");
                            }

                            HashSet<int> productIds = new HashSet<int>();
                            decimal subtotal = 0m;
                            foreach (CartItemDto requested in items)
                            {
                                if (!productIds.Add(requested.ProductId)) throw new InvalidOperationException("The cart contains a duplicate product entry.");
                                using (SqlCommand product = new SqlCommand("SELECT [product name],[price] FROM Product WITH (UPDLOCK,HOLDLOCK) WHERE [product id]=@productId", connection, transaction))
                                {
                                    product.Parameters.Add("@productId", SqlDbType.Int).Value = requested.ProductId;
                                    using (SqlDataReader reader = product.ExecuteReader())
                                    {
                                        if (!reader.Read()) throw new InvalidOperationException("A product in the cart is no longer available.");
                                        decimal currentPrice = Convert.ToDecimal(reader["price"]);
                                        string currentName = Convert.ToString(reader["product name"]);
                                        validatedItems.Add(new CartItemDto { ProductId = requested.ProductId, ProductName = currentName, Quantity = requested.Quantity, Price = currentPrice });
                                        subtotal += currentPrice * requested.Quantity;
                                    }
                                }
                            }

                            paidAmount = subtotal - CheckoutDiscount + DeliveryCharge;
                            if (paidAmount != totalAmount) throw new InvalidOperationException("The cart prices changed. Please return to checkout and review the updated total.");

                            using (SqlCommand bank = new SqlCommand("SELECT Balance FROM Bank WITH (UPDLOCK,HOLDLOCK) WHERE user_id=@userId", connection, transaction))
                            {
                                bank.Parameters.Add("@userId", SqlDbType.Int).Value = userId;
                                object balance = bank.ExecuteScalar();
                                if (balance == null || balance == DBNull.Value) throw new InvalidOperationException("Demo Bank account not found.");
                                if (Convert.ToDecimal(balance) < paidAmount) throw new InvalidOperationException("Insufficient Demo Bank balance.");
                            }

                            using (SqlCommand insertOrder = new SqlCommand("INSERT INTO [Order](user_id,TotalAmount,Status,OrderDate) VALUES(@userId,@amount,'Confirmed',GETDATE()); SELECT CAST(SCOPE_IDENTITY() AS int);", connection, transaction))
                            {
                                insertOrder.Parameters.Add("@userId", SqlDbType.Int).Value = userId;
                                SqlParameter amount = insertOrder.Parameters.Add("@amount", SqlDbType.Decimal); amount.Precision = 18; amount.Scale = 2; amount.Value = paidAmount;
                                orderId = Convert.ToInt32(insertOrder.ExecuteScalar());
                            }

                            foreach (CartItemDto item in validatedItems)
                            {
                                using (SqlCommand archive = new SqlCommand("INSERT INTO cart(Pdtid,Quantity,Reg_id,Price,[Product Name],[Cart Status],[order id]) VALUES(@productId,@quantity,@userId,@price,@name,'Ordered',@orderId)", connection, transaction))
                                {
                                    archive.Parameters.Add("@productId", SqlDbType.Int).Value = item.ProductId;
                                    archive.Parameters.Add("@quantity", SqlDbType.Int).Value = item.Quantity;
                                    archive.Parameters.Add("@userId", SqlDbType.Int).Value = userId;
                                    SqlParameter price = archive.Parameters.Add("@price", SqlDbType.Decimal); price.Precision = 18; price.Scale = 2; price.Value = item.Price;
                                    archive.Parameters.Add("@name", SqlDbType.NVarChar, 256).Value = item.ProductName;
                                    archive.Parameters.Add("@orderId", SqlDbType.Int).Value = orderId;
                                    archive.ExecuteNonQuery();
                                }
                            }

                            using (SqlCommand deduct = new SqlCommand("UPDATE Bank SET Balance=Balance-@amount WHERE user_id=@userId AND Balance>=@amount", connection, transaction))
                            {
                                SqlParameter amount = deduct.Parameters.Add("@amount", SqlDbType.Decimal); amount.Precision = 18; amount.Scale = 2; amount.Value = paidAmount;
                                deduct.Parameters.Add("@userId", SqlDbType.Int).Value = userId;
                                if (deduct.ExecuteNonQuery() != 1) throw new InvalidOperationException("Balance deduction failed; payment was rolled back.");
                            }

                            paymentDate = DateTime.Now;
                            using (SqlCommand payment = new SqlCommand("INSERT INTO Payment(order_id,user_id,PaymentMethod,Amount,Status,TransactionId,PaymentDate) VALUES(@orderId,@userId,@method,@amount,'Success',@transactionId,GETDATE())", connection, transaction))
                            {
                                payment.Parameters.Add("@orderId", SqlDbType.Int).Value = orderId;
                                payment.Parameters.Add("@userId", SqlDbType.Int).Value = userId;
                                payment.Parameters.Add("@method", SqlDbType.NVarChar, 50).Value = paymentMethod;
                                SqlParameter amount = payment.Parameters.Add("@amount", SqlDbType.Decimal); amount.Precision = 18; amount.Scale = 2; amount.Value = paidAmount;
                                payment.Parameters.Add("@transactionId", SqlDbType.NVarChar, 100).Value = transactionId;
                                payment.ExecuteNonQuery();
                            }
                            using (SqlCommand savedPaymentDate = new SqlCommand("SELECT PaymentDate FROM Payment WHERE TransactionId=@transactionId", connection, transaction))
                            {
                                savedPaymentDate.Parameters.Add("@transactionId", SqlDbType.NVarChar, 100).Value = transactionId;
                                paymentDate = Convert.ToDateTime(savedPaymentDate.ExecuteScalar());
                            }
                            using (SqlCommand bank = new SqlCommand("SELECT Balance FROM Bank WHERE user_id=@userId", connection, transaction))
                            {
                                bank.Parameters.Add("@userId", SqlDbType.Int).Value = userId;
                                finalBalance = Convert.ToDecimal(bank.ExecuteScalar());
                            }
                            transaction.Commit();
                        }
                        catch (Exception error)
                        {
                            try { transaction.Rollback(); } catch { }
                            return Fail(error.Message);
                        }
                    }
                }
                return new OrderResult { Success = true, OrderId = orderId, TransactionId = transactionId, PaidAmount = paidAmount, FinalBalance = finalBalance, PaymentDate = paymentDate, PaymentMethod = paymentMethod, Message = "Order placed successfully." };
            }
            catch (Exception)
            {
                return Fail("The payment could not be completed. No order or deduction was committed.");
            }
        }

        private static OrderResult Fail(string message)
        {
            return new OrderResult { Success = false, Message = message, TransactionId = String.Empty };
        }

        private static string CartFingerprint(List<CartItemDto> items)
        {
            List<string> entries = new List<string>();
            foreach (CartItemDto item in items)
            {
                if (item == null) return String.Empty;
                entries.Add(item.ProductId.ToString(CultureInfo.InvariantCulture) + ":" + item.Quantity.ToString(CultureInfo.InvariantCulture));
            }
            entries.Sort(StringComparer.Ordinal);
            using (SHA256 sha = SHA256.Create())
                return BitConverter.ToString(sha.ComputeHash(Encoding.UTF8.GetBytes(String.Join(";", entries.ToArray())))).Replace("-", String.Empty);
        }
    }
}
