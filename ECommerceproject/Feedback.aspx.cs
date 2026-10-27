using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ECommerceproject
{
    public partial class Feedback : Page
    {
        private const string ConnStr = @"server=DESKTOP-N272NOH\SQLEXPRESS;database=ECommerceProject;integrated security=true";
        private static readonly string[] ValidStatuses = { "New", "Viewed", "Resolved" };

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!RequireAdmin()) return;
            if (!IsPostBack)
            {
                BindWorkspace();
            }
        }

        private bool RequireAdmin()
        {
            if (Session["Role"] != null && string.Equals(Session["Role"].ToString(), "Admin", StringComparison.Ordinal)) return true;
            Response.Redirect("Login.aspx", true);
            return false;
        }

        private void BindWorkspace()
        {
            try
            {
                BindCounts();
                BindFeedbackList();
                int feedbackId = SelectedFeedbackId;
                if (feedbackId > 0) BindDetail(feedbackId);
                ShowError(string.Empty);
            }
            catch (Exception ex)
            {
                ShowError("Feedback data could not be loaded. " + ex.Message);
            }
        }

        private int SelectedFeedbackId
        {
            get { int value; return int.TryParse(hfFeedbackId.Value, out value) ? value : 0; }
            set { hfFeedbackId.Value = value > 0 ? value.ToString() : string.Empty; }
        }

        private void BindCounts()
        {
            const string sql = @"SELECT
                SUM(CASE WHEN Status = 'New' THEN 1 ELSE 0 END) AS NewCount,
                SUM(CASE WHEN Status = 'Viewed' THEN 1 ELSE 0 END) AS ViewedCount,
                SUM(CASE WHEN Status = 'Resolved' THEN 1 ELSE 0 END) AS ResolvedCount
                FROM dbo.Feedback";
            using (SqlConnection con = new SqlConnection(ConnStr))
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                con.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        countNew.Text = reader["NewCount"] == DBNull.Value ? "0" : reader["NewCount"].ToString();
                        countViewed.Text = reader["ViewedCount"] == DBNull.Value ? "0" : reader["ViewedCount"].ToString();
                        countResolved.Text = reader["ResolvedCount"] == DBNull.Value ? "0" : reader["ResolvedCount"].ToString();
                    }
                }
            }
        }

        private void BindFeedbackList()
        {
            const string sql = @"SELECT FeedbackId, CustomerName, CustomerEmail, Subject, FeedbackMessage,
                SubmittedAt, Status, EmailStatus FROM dbo.Feedback ORDER BY SubmittedAt DESC, FeedbackId DESC";
            using (SqlConnection con = new SqlConnection(ConnStr))
            using (SqlDataAdapter adapter = new SqlDataAdapter(sql, con))
            {
                DataTable table = new DataTable();
                adapter.Fill(table);
                rptFeedback.DataSource = table;
                rptFeedback.DataBind();
            }
        }

        protected string SafeStatus(object value)
        {
            string status = Convert.ToString(value);
            return ValidStatuses.Contains(status, StringComparer.OrdinalIgnoreCase) ? status.ToLowerInvariant() : "new";
        }

        protected string SafeEmailStatus(object value)
        {
            string status = Convert.ToString(value);
            string[] allowed = { "Pending", "Sent", "Failed" };
            return allowed.Contains(status, StringComparer.OrdinalIgnoreCase) ? status.ToLowerInvariant() : "pending";
        }

        protected string SearchValue(object name, object subject)
        {
            return HttpUtility.HtmlAttributeEncode((Convert.ToString(name) + " " + Convert.ToString(subject)).ToLowerInvariant());
        }

        protected string FormatDate(object value)
        {
            DateTime date;
            return DateTime.TryParse(Convert.ToString(value), out date) ? date.ToString("yyyy-MM-dd HH:mm") : string.Empty;
        }

        protected void rptFeedback_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (!RequireAdmin()) return;
            int feedbackId;
            if (!int.TryParse(Convert.ToString(e.CommandArgument), out feedbackId) || feedbackId <= 0)
            {
                ShowError("The selected feedback record is invalid.");
                return;
            }
            try
            {
                SelectedFeedbackId = feedbackId;
                if (e.CommandName == "Select")
                {
                    UpdateStatus(feedbackId, "Viewed", true);
                }
                BindWorkspace();
                fbList.Visible = false;
                fbDetail.Visible = true;
            }
            catch (Exception ex)
            {
                ShowError("The feedback details could not be opened. " + ex.Message);
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            if (!RequireAdmin()) return;
            SelectedFeedbackId = 0;
            fbDetail.Visible = false;
            fbList.Visible = true;
            BindWorkspace();
        }

        protected void btnMarkViewed_Click(object sender, EventArgs e)
        {
            ChangeSelectedStatus("Viewed");
        }

        protected void btnMarkResolved_Click(object sender, EventArgs e)
        {
            ChangeSelectedStatus("Resolved");
        }

        private void ChangeSelectedStatus(string status)
        {
            if (!RequireAdmin()) return;
            if (!ValidStatuses.Contains(status, StringComparer.Ordinal))
            {
                ShowError("That feedback status is not allowed.");
                return;
            }
            try
            {
                if (SelectedFeedbackId <= 0) throw new InvalidOperationException("Select a feedback record first.");
                UpdateStatus(SelectedFeedbackId, status, false);
                BindWorkspace();
                fbList.Visible = false;
                fbDetail.Visible = true;
            }
            catch (Exception ex) { ShowError("The feedback status was not updated. " + ex.Message); }
        }

        private static void UpdateStatus(int feedbackId, string status, bool onlyIfNew)
        {
            if (!ValidStatuses.Contains(status, StringComparer.Ordinal)) throw new InvalidOperationException("Invalid feedback status.");
            string sql = onlyIfNew
                ? "UPDATE dbo.Feedback SET Status = @status WHERE FeedbackId = @id AND Status = 'New'"
                : "UPDATE dbo.Feedback SET Status = @status WHERE FeedbackId = @id";
            using (SqlConnection con = new SqlConnection(ConnStr))
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.Add("@status", SqlDbType.NVarChar, 20).Value = status;
                cmd.Parameters.Add("@id", SqlDbType.Int).Value = feedbackId;
                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        private void BindDetail(int feedbackId)
        {
            const string sql = @"SELECT FeedbackId, CustomerName, CustomerEmail, Subject, FeedbackMessage,
                SubmittedAt, Status, EmailStatus FROM dbo.Feedback WHERE FeedbackId = @id";
            using (SqlConnection con = new SqlConnection(ConnStr))
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.Add("@id", SqlDbType.Int).Value = feedbackId;
                con.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (!reader.Read()) throw new InvalidOperationException("The selected feedback record no longer exists.");
                    litDetailId.Text = HttpUtility.HtmlEncode(reader["FeedbackId"].ToString());
                    litDetailStatus.Text = HttpUtility.HtmlEncode(reader["Status"].ToString());
                    litDetailStatus.CssClass = "badge badge-" + SafeStatus(reader["Status"]);
                    litDetailSubject.Text = HttpUtility.HtmlEncode(reader["Subject"].ToString());
                    litDetailMessage.Text = HttpUtility.HtmlEncode(reader["FeedbackMessage"].ToString()).Replace("\r\n", "\n").Replace("\n", "<br />");
                    litDetailName.Text = HttpUtility.HtmlEncode(reader["CustomerName"].ToString());
                    litDetailEmail.Text = HttpUtility.HtmlEncode(reader["CustomerEmail"].ToString());
                    litDetailDate.Text = HttpUtility.HtmlEncode(FormatDate(reader["SubmittedAt"]));
                    litDetailEmailStatus.Text = HttpUtility.HtmlEncode(reader["EmailStatus"].ToString());
                    litDetailEmailStatus.CssClass = "badge badge-" + SafeEmailStatus(reader["EmailStatus"]);
                }
            }
            BindReplies(feedbackId);
        }

        private void BindReplies(int feedbackId)
        {
            ReplySchema schema;
            using (SqlConnection con = new SqlConnection(ConnStr))
            {
                con.Open();
                schema = ReplySchema.Inspect(con);
                string sql = "SELECT " + Q(schema.Id) + " AS ReplyId, " + Q(schema.Admin) + " AS AdminName, " +
                    Q(schema.Message) + " AS ReplyMessage, " + Q(schema.Created) + " AS RepliedAt, " +
                    Q(schema.EmailStatus) + " AS EmailStatus FROM dbo.FeedbackReplies WHERE " + Q(schema.FeedbackId) +
                    " = @feedbackId ORDER BY " + Q(schema.Created) + " ASC, " + Q(schema.Id) + " ASC";
                using (SqlDataAdapter adapter = new SqlDataAdapter(sql, con))
                {
                    adapter.SelectCommand.Parameters.Add("@feedbackId", SqlDbType.Int).Value = feedbackId;
                    DataTable replies = new DataTable();
                    adapter.Fill(replies);
                    rptReplies.DataSource = replies;
                    rptReplies.DataBind();
                    litNoReplies.Visible = replies.Rows.Count == 0;
                }
            }
        }

        protected void btnSendReply_Click(object sender, EventArgs e)
        {
            if (!RequireAdmin()) return;
            int feedbackId = SelectedFeedbackId;
            string message = (txtReply.Text ?? string.Empty).Trim();
            if (feedbackId <= 0 || string.IsNullOrWhiteSpace(message) || message.Length > 2000)
            {
                ShowReplyMessage("Select feedback and enter a reply of 1–2000 characters.", false);
                return;
            }
            int replyId;
            string customerName, customerEmail, subject;
            try { replyId = InsertReply(feedbackId, message, out customerName, out customerEmail, out subject); }
            catch (Exception ex) { ShowReplyMessage("The reply could not be saved. " + ex.Message, false); return; }

            bool sent = TrySendReply(customerName, customerEmail, subject, message, out string error);
            try { UpdateReplyEmailStatus(replyId, sent ? "Sent" : "Failed"); }
            catch (Exception ex)
            {
                txtReply.Text = string.Empty;
                try { BindWorkspace(); } catch { }
                fbList.Visible = false;
                fbDetail.Visible = true;
                ShowReplyMessage("The reply was saved, but its delivery status could not be updated. " + ex.Message, false);
                return;
            }
            txtReply.Text = string.Empty;
            try { BindWorkspace(); } catch (Exception ex) { ShowReplyMessage("Reply was saved. The page could not refresh its history. " + ex.Message, sent); }
            fbList.Visible = false;
            fbDetail.Visible = true;
            ShowReplyMessage(sent ? "Reply emailed successfully." : "Reply saved, but email delivery failed. Use Retry on that reply. " + error, sent);
        }

        private int InsertReply(int feedbackId, string message, out string customerName, out string customerEmail, out string subject)
        {
            customerName = customerEmail = subject = string.Empty;
            using (SqlConnection con = new SqlConnection(ConnStr))
            {
                con.Open();
                using (SqlCommand feedback = new SqlCommand("SELECT CustomerName, CustomerEmail, Subject FROM dbo.Feedback WHERE FeedbackId = @id", con))
                {
                    feedback.Parameters.Add("@id", SqlDbType.Int).Value = feedbackId;
                    using (SqlDataReader r = feedback.ExecuteReader())
                    {
                        if (!r.Read()) throw new InvalidOperationException("The selected feedback record does not exist.");
                        customerName = Convert.ToString(r["CustomerName"]);
                        customerEmail = Convert.ToString(r["CustomerEmail"]);
                        subject = Convert.ToString(r["Subject"]);
                    }
                }
                if (string.IsNullOrWhiteSpace(customerEmail)) throw new InvalidOperationException("The feedback record has no customer email address.");

                ReplySchema schema = ReplySchema.Inspect(con);
                string sql = "INSERT INTO dbo.FeedbackReplies (" + Q(schema.FeedbackId) + ", " + Q(schema.Admin) + ", " +
                    Q(schema.Message) + ", " + Q(schema.Created) + ", " + Q(schema.EmailStatus) + ") VALUES (@feedbackId, @admin, @message, @created, 'Pending'); SELECT CAST(SCOPE_IDENTITY() AS int);";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.Add("@feedbackId", SqlDbType.Int).Value = feedbackId;
                    string adminName = Convert.ToString(Session["AdminName"]);
                    if (string.IsNullOrWhiteSpace(adminName)) throw new InvalidOperationException("Administrator display name is missing from the authenticated session.");
                    cmd.Parameters.Add("@admin", SqlDbType.NVarChar, 200).Value = adminName;
                    cmd.Parameters.Add("@message", SqlDbType.NVarChar, 2000).Value = message;
                    cmd.Parameters.Add("@created", SqlDbType.DateTime).Value = DateTime.Now;
                    object id = cmd.ExecuteScalar();
                    if (id == null || id == DBNull.Value) throw new InvalidOperationException("FeedbackReplies must generate a reply identity value to support safe retry.");
                    return Convert.ToInt32(id);
                }
            }
        }

        private bool TrySendReply(string customerName, string customerEmail, string subject, string message, out string error)
        {
            try
            {
                EmailService.SendEmail2(
                    yourName: "FlipShop Support",
                    yourGmailUserName: EmailService.SmtpUsername,
                    yourGmailPassword: EmailService.SmtpPassword,
                    toName: customerName,
                    toEmail: customerEmail,
                    subject: "[FlipShop Support] " + subject,
                    body: EmailService.BuildCustomerReplyBody(subject, message));
                error = string.Empty;
                return true;
            }
            catch (Exception ex)
            {
                error = ex.Message;
                return false;
            }
        }

        protected void rptReplies_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (!RequireAdmin()) return;
            if (e.CommandName != "Retry") return;
            int replyId;
            if (!int.TryParse(Convert.ToString(e.CommandArgument), out replyId) || replyId <= 0)
            {
                ShowReplyMessage("The reply selected for retry is invalid.", false);
                return;
            }
            try
            {
                RetryReply(replyId);
                BindWorkspace();
                fbList.Visible = false;
                fbDetail.Visible = true;
            }
            catch (Exception ex) { ShowReplyMessage("The saved reply could not be retried. " + ex.Message, false); }
        }

        private void RetryReply(int replyId)
        {
            using (SqlConnection con = new SqlConnection(ConnStr))
            {
                con.Open();
                ReplySchema schema = ReplySchema.Inspect(con);
                string sql = "SELECT r." + Q(schema.Id) + " AS ReplyId, r." + Q(schema.FeedbackId) + " AS FeedbackId, r." +
                    Q(schema.Message) + " AS ReplyMessage, r." + Q(schema.EmailStatus) + " AS EmailStatus, f.CustomerName, f.CustomerEmail, f.Subject FROM dbo.FeedbackReplies r " +
                    "INNER JOIN dbo.Feedback f ON f.FeedbackId = r." + Q(schema.FeedbackId) + " WHERE r." + Q(schema.Id) + " = @id";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.Add("@id", SqlDbType.Int).Value = replyId;
                    using (SqlDataReader r = cmd.ExecuteReader())
                    {
                        if (!r.Read()) throw new InvalidOperationException("The saved reply no longer exists.");
                        if (!string.Equals(Convert.ToString(r["EmailStatus"]), "Failed", StringComparison.OrdinalIgnoreCase))
                            throw new InvalidOperationException("Only a reply with Failed email status can be retried.");
                        SelectedFeedbackId = Convert.ToInt32(r["FeedbackId"]);
                        string customerName = Convert.ToString(r["CustomerName"]);
                        string email = Convert.ToString(r["CustomerEmail"]);
                        string replySubject = Convert.ToString(r["Subject"]);
                        string replyMessage = Convert.ToString(r["ReplyMessage"]);
                        r.Close();
                        bool sent = TrySendReply(customerName, email, replySubject, replyMessage, out string error);
                        UpdateReplyEmailStatus(replyId, sent ? "Sent" : "Failed");
                        ShowReplyMessage(sent ? "The saved reply was emailed successfully." : "Email delivery failed again. " + error, sent);
                    }
                }
            }
        }

        private void UpdateReplyEmailStatus(int replyId, string status)
        {
            if (status != "Sent" && status != "Failed") throw new InvalidOperationException("Invalid reply delivery status.");
            using (SqlConnection con = new SqlConnection(ConnStr))
            {
                con.Open();
                ReplySchema schema = ReplySchema.Inspect(con);
                using (SqlCommand cmd = new SqlCommand("UPDATE dbo.FeedbackReplies SET " + Q(schema.EmailStatus) + " = @status WHERE " + Q(schema.Id) + " = @id", con))
                {
                    cmd.Parameters.Add("@status", SqlDbType.NVarChar, 20).Value = status;
                    cmd.Parameters.Add("@id", SqlDbType.Int).Value = replyId;
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private void ShowReplyMessage(string message, bool success)
        {
            litReplyNotice.Text = HttpUtility.HtmlEncode(message);
            litReplyNotice.CssClass = success ? "fb-note on" : "fb-note on is-error";
        }

        private void ShowError(string message)
        {
            litPageError.Text = HttpUtility.HtmlEncode(message);
            litPageError.Visible = !string.IsNullOrEmpty(message);
        }

        private static string Q(string identifier) { return "[" + identifier.Replace("]", "]]" ) + "]"; }

        private sealed class ReplySchema
        {
            public string Id, FeedbackId, Admin, Message, Created, EmailStatus;
            public bool IdIsIdentity;

            public static ReplySchema Inspect(SqlConnection con)
            {
                DataTable columns = new DataTable();
                using (SqlCommand cmd = new SqlCommand("SELECT TOP (0) * FROM dbo.FeedbackReplies", con))
                using (SqlDataAdapter adapter = new SqlDataAdapter(cmd)) adapter.Fill(columns);
                string[] names = columns.Columns.Cast<DataColumn>().Select(c => c.ColumnName).ToArray();
                Func<string[], string> pick = candidates => candidates.FirstOrDefault(c => names.Contains(c, StringComparer.OrdinalIgnoreCase));
                var schema = new ReplySchema
                {
                    Id = pick(new[] { "FeedbackReplyId", "ReplyId", "FeedbackReplyID", "ReplyID", "Id" }),
                    FeedbackId = pick(new[] { "FeedbackId", "FeedbackID" }),
                    Admin = pick(new[] { "AdminName", "AdministratorName", "RepliedBy", "Admin", "SenderName" }),
                    Message = pick(new[] { "ReplyMessage", "Message", "ReplyText", "FeedbackReply", "Reply" }),
                    Created = pick(new[] { "RepliedAt", "CreatedAt", "SubmittedAt", "ReplyDate", "Timestamp" }),
                    EmailStatus = pick(new[] { "EmailStatus", "DeliveryStatus" })
                };
                if (new[] { schema.Id, schema.FeedbackId, schema.Admin, schema.Message, schema.Created, schema.EmailStatus }.Any(string.IsNullOrEmpty))
                {
                    throw new InvalidOperationException("dbo.FeedbackReplies schema is not compatible. Required semantic columns: an identity reply ID, FeedbackId, administrator name, reply message, reply timestamp, and email delivery status. Existing columns: " + string.Join(", ", names));
                }
                using (SqlCommand identity = new SqlCommand("SELECT COUNT(*) FROM sys.identity_columns WHERE object_id = OBJECT_ID(N'dbo.FeedbackReplies') AND name = @column", con))
                {
                    identity.Parameters.Add("@column", SqlDbType.NVarChar, 128).Value = schema.Id;
                    schema.IdIsIdentity = Convert.ToInt32(identity.ExecuteScalar()) == 1;
                }
                if (!schema.IdIsIdentity)
                {
                    throw new InvalidOperationException("dbo.FeedbackReplies reply key '" + schema.Id + "' is not an identity column. No insert was attempted because a stable reply ID is required for retry.");
                }
                return schema;
            }
        }
    }
}
