using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace ECommerceproject
{
    public partial class Contactus : System.Web.UI.Page
    {
        private const string ConnStr =
            @"server=DESKTOP-N272NOH\SQLEXPRESS;database=ECommerceProject;integrated security=true";

        protected void Page_Load(object sender, EventArgs e)
        {
            // Only authenticated customers with Role == "User" may access Contact Us
            if (Session["UserId"] == null || Session["Role"] == null || Session["Role"].ToString() != "User")
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                cuSuccess.Attributes["class"] = "cu-alert ok";
                cuFail.Attributes["class"] = "cu-alert fail";

                int userId = GetCurrentUserId();
                if (userId > 0)
                {
                    string customerName;
                    string registeredEmail;
                    GetRegisteredIdentity(userId, out customerName, out registeredEmail);
                    txtEmail.Text = registeredEmail;
                }
            }
        }

        protected void btnSubmitFeedback_Click(object sender, EventArgs e)
        {
            // Re-validate session server-side
            if (Session["UserId"] == null || Session["Role"] == null || Session["Role"].ToString() != "User")
            {
                Response.Redirect("Login.aspx");
                return;
            }

            int userId = GetCurrentUserId();
            if (userId <= 0)
            {
                ShowFailure("Session error. Please log in again.");
                return;
            }

            string subject = (txtSubject.Text ?? string.Empty).Trim();
            string message = (txtMessage.Text ?? string.Empty).Trim();

            // Validate inputs
            if (string.IsNullOrEmpty(subject))
            {
                ShowFailure("Subject is required.");
                return;
            }

            if (subject.Length > 150)
            {
                ShowFailure("Subject cannot exceed 150 characters.");
                return;
            }

            if (string.IsNullOrEmpty(message))
            {
                ShowFailure("Feedback message is required.");
                return;
            }

            if (message.Length > 1000)
            {
                ShowFailure("Feedback message cannot exceed 1000 characters.");
                return;
            }

            // Always retrieve registered email directly from DB - never trust browser-posted value
            string customerName;
            string registeredEmail;
            GetRegisteredIdentity(userId, out customerName, out registeredEmail);
            if (string.IsNullOrWhiteSpace(registeredEmail))
            {
                ShowFailure("Unable to retrieve your registered email from account. Please verify your profile.");
                return;
            }

            if (string.IsNullOrWhiteSpace(customerName)) customerName = "Customer";

            int feedbackId;
            try
            {
                feedbackId = InsertFeedback(userId, customerName, registeredEmail, subject, message);
            }
            catch
            {
                ShowFailure("We couldn't save your feedback. Please try again later.", "We couldn't save your feedback.");
                return;
            }

            // Retrieve SMTP configuration
            string username = EmailService.SmtpUsername;
            string password = EmailService.SmtpPassword;
            string adminEmail = EmailService.AdminFeedbackEmail;

            if (string.IsNullOrWhiteSpace(password) || string.Equals(password.Trim(), "PLACEHOLDER_APP_PASSWORD", StringComparison.OrdinalIgnoreCase))
            {
                try { UpdateFeedbackEmailStatus(feedbackId, "Failed"); } catch { }
                ShowFailure("Your feedback was saved, but its notification email could not be sent. Please contact support if you need a follow-up.", "Feedback saved, email failed.");
                return;
            }

            string notificationBody = EmailService.BuildFeedbackNotificationBody(customerName, registeredEmail, subject, message);

            try
            {
                // Keep the existing admin notification and customer Reply-To behavior.
                EmailService.SendEmail2(
                    yourName: "FlipShop Feedback",
                    yourGmailUserName: username,
                    yourGmailPassword: password,
                    toName: "FlipShop Administrator",
                    toEmail: adminEmail,
                    subject: "[FlipShop Feedback] " + subject,
                    body: notificationBody,
                    replyToEmail: registeredEmail,
                    replyToName: customerName);
            }
            catch
            {
                try { UpdateFeedbackEmailStatus(feedbackId, "Failed"); } catch { }
                ShowFailure("Your feedback was saved, but its notification email failed. Please contact support if you need a follow-up.", "Feedback saved, email failed.");
                return;
            }

            try
            {
                UpdateFeedbackEmailStatus(feedbackId, "Sent");
            }
            catch
            {
                ShowFailure("The notification was submitted, but its delivery status could not be saved. Please contact support before retrying.", "Feedback saved; delivery status unavailable.");
                return;
            }

            txtSubject.Text = string.Empty;
            txtMessage.Text = string.Empty;
            cuSuccess.Attributes["class"] = "cu-alert ok on";
            cuFail.Attributes["class"] = "cu-alert fail";
        }

        private void ShowFailure(string message, string title = "We couldn't send your feedback.")
        {
            cuSuccess.Attributes["class"] = "cu-alert ok";
            cuFail.Attributes["class"] = "cu-alert fail on";
            if (cuFailTitle != null) cuFailTitle.InnerText = title;
            if (cuFailMsg != null)
            {
                cuFailMsg.InnerText = message;
            }
        }

        private int GetCurrentUserId()
        {
            object uidObj = Session["UserId"];
            if (uidObj == null) return 0;
            int uid;
            return int.TryParse(uidObj.ToString(), out uid) ? uid : 0;
        }

        private void GetRegisteredIdentity(int userId, out string customerName, out string email)
        {
            customerName = string.Empty;
            email = string.Empty;
            try
            {
                using (SqlConnection con = new SqlConnection(ConnStr))
                using (SqlCommand cmd = new SqlCommand("SELECT [username], [Email] FROM User_Reg WHERE [user id] = @uid", con))
                {
                    cmd.Parameters.Add("@uid", SqlDbType.Int).Value = userId;
                    con.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            customerName = reader["username"] == DBNull.Value ? string.Empty : reader["username"].ToString().Trim();
                            email = reader["Email"] == DBNull.Value ? string.Empty : reader["Email"].ToString().Trim();
                        }
                    }
                }
            }
            catch
            {
                customerName = string.Empty;
                email = string.Empty;
            }
        }

        private int InsertFeedback(int userId, string customerName, string email, string subject, string message)
        {
            const string sql = @"SET XACT_ABORT ON;
                BEGIN TRANSACTION;
                DECLARE @feedbackId int;
                SELECT TOP (1) @feedbackId = FeedbackId
                FROM dbo.Feedback WITH (UPDLOCK, HOLDLOCK)
                WHERE UserId = @UserId AND CustomerEmail = @CustomerEmail AND Subject = @Subject
                  AND FeedbackMessage = @FeedbackMessage AND EmailStatus IN ('Pending', 'Failed')
                  AND SubmittedAt >= DATEADD(MINUTE, -30, GETDATE())
                ORDER BY SubmittedAt DESC, FeedbackId DESC;
                IF @feedbackId IS NULL
                BEGIN
                    INSERT INTO dbo.Feedback
                        (UserId, CustomerName, CustomerEmail, Subject, FeedbackMessage, SubmittedAt, Status, EmailStatus)
                    VALUES (@UserId, @CustomerName, @CustomerEmail, @Subject, @FeedbackMessage, GETDATE(), 'New', 'Pending');
                    SET @feedbackId = CAST(SCOPE_IDENTITY() AS int);
                END
                COMMIT TRANSACTION;
                SELECT @feedbackId;";
            using (SqlConnection con = new SqlConnection(ConnStr))
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.Add("@UserId", SqlDbType.Int).Value = userId;
                cmd.Parameters.Add("@CustomerName", SqlDbType.NVarChar, 200).Value = customerName;
                cmd.Parameters.Add("@CustomerEmail", SqlDbType.NVarChar, 320).Value = email;
                cmd.Parameters.Add("@Subject", SqlDbType.NVarChar, 150).Value = subject;
                cmd.Parameters.Add("@FeedbackMessage", SqlDbType.NVarChar, 1000).Value = message;
                con.Open();
                object result = cmd.ExecuteScalar();
                if (result == null || result == DBNull.Value) throw new InvalidOperationException("FeedbackId did not return an identity value.");
                return Convert.ToInt32(result);
            }
        }

        private void UpdateFeedbackEmailStatus(int feedbackId, string status)
        {
            if (status != "Sent" && status != "Failed") throw new ArgumentException("Invalid email status.", nameof(status));
            using (SqlConnection con = new SqlConnection(ConnStr))
            using (SqlCommand cmd = new SqlCommand("UPDATE dbo.Feedback SET EmailStatus = @status WHERE FeedbackId = @id", con))
            {
                cmd.Parameters.Add("@status", SqlDbType.NVarChar, 20).Value = status;
                cmd.Parameters.Add("@id", SqlDbType.Int).Value = feedbackId;
                con.Open();
                cmd.ExecuteNonQuery();
            }
        }
    }
}
