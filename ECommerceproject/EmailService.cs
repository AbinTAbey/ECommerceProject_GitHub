using System;
using System.Configuration;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Web;

namespace ECommerceproject
{
    public static class EmailService
    {
        public static string SmtpHost => ConfigurationManager.AppSettings["SmtpHost"] ?? "smtp.gmail.com";

        public static int SmtpPort
        {
            get
            {
                int port;
                return int.TryParse(ConfigurationManager.AppSettings["SmtpPort"], out port) ? port : 587;
            }
        }

        public static bool SmtpEnableSsl
        {
            get
            {
                bool ssl;
                return bool.TryParse(ConfigurationManager.AppSettings["SmtpEnableSsl"], out ssl) ? ssl : true;
            }
        }

        public static string SmtpUsername =>
            ConfigurationManager.AppSettings["SmtpUsername"] ??
            ConfigurationManager.AppSettings["SmtpSenderEmail"] ??
            "abinabey124@gmail.com";

        public static string SmtpSenderName =>
            ConfigurationManager.AppSettings["SmtpSenderName"] ?? "FlipShop Support";

        public static string AdminFeedbackEmail =>
            ConfigurationManager.AppSettings["AdminFeedbackEmail"] ??
            ConfigurationManager.AppSettings["AdminNotificationEmail"] ??
            "adr22cs005@cea.ac.in";

        public static string SmtpPassword =>
            ConfigurationManager.AppSettings["SmtpPassword"] ?? string.Empty;

        /// <summary>
        /// Sends an email via Gmail SMTP using the mentor's SendEmail2 signature and approach.
        /// Configured with Host: smtp.gmail.com, Port: 587, SSL enabled, UseDefaultCredentials: false,
        /// UTF-8 encoding, HTML support, and robust resource disposal.
        /// </summary>
        public static void SendEmail2(
            string yourName,
            string yourGmailUserName,
            string yourGmailPassword,
            string toName,
            string toEmail,
            string subject,
            string body)
        {
            SendEmail2(yourName, yourGmailUserName, yourGmailPassword, toName, toEmail, subject, body, null, null);
        }

        /// <summary>
        /// Sends an email via Gmail SMTP with optional Reply-To configuration.
        /// Allows admin notifications to have Reply-To addressed directly to the customer's registered email.
        /// </summary>
        public static void SendEmail2(
            string yourName,
            string yourGmailUserName,
            string yourGmailPassword,
            string toName,
            string toEmail,
            string subject,
            string body,
            string replyToEmail,
            string replyToName = null)
        {
            if (string.IsNullOrWhiteSpace(yourGmailUserName))
                throw new ArgumentException("Sender Gmail username cannot be empty.", nameof(yourGmailUserName));

            if (string.IsNullOrWhiteSpace(yourGmailPassword) ||
                string.Equals(yourGmailPassword.Trim(), "PLACEHOLDER_APP_PASSWORD", StringComparison.OrdinalIgnoreCase))
                throw new InvalidOperationException("Gmail App Password is not configured. Please set SmtpPassword in appSettings.secrets.config.");

            if (string.IsNullOrWhiteSpace(toEmail))
                throw new ArgumentException("Recipient email cannot be empty.", nameof(toEmail));

            ServicePointManager.SecurityProtocol |= SecurityProtocolType.Tls12;

            using (MailMessage mail = new MailMessage())
            {
                mail.From = new MailAddress(yourGmailUserName, yourName ?? string.Empty, Encoding.UTF8);
                mail.To.Add(new MailAddress(toEmail, toName ?? string.Empty, Encoding.UTF8));

                if (!string.IsNullOrWhiteSpace(replyToEmail))
                {
                    mail.ReplyToList.Add(new MailAddress(replyToEmail.Trim(), replyToName ?? string.Empty, Encoding.UTF8));
                }

                mail.Subject = subject ?? string.Empty;
                mail.SubjectEncoding = Encoding.UTF8;
                mail.Body = body ?? string.Empty;
                mail.BodyEncoding = Encoding.UTF8;
                mail.IsBodyHtml = true;

                using (SmtpClient smtp = new SmtpClient(SmtpHost, SmtpPort))
                {
                    smtp.EnableSsl = SmtpEnableSsl;
                    smtp.UseDefaultCredentials = false;
                    smtp.Credentials = new NetworkCredential(yourGmailUserName, yourGmailPassword.Trim());
                    smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
                    smtp.Timeout = 15000;

                    try
                    {
                        smtp.Send(mail);
                    }
                    catch (SmtpException)
                    {
                        // Preserve stack trace without exposing credentials in logs
                        throw;
                    }
                    catch (Exception)
                    {
                        throw;
                    }
                }
            }
        }

        /// <summary>
        /// Builds the formatted HTML notification for administrators.
        /// Displays customer details and feedback message.
        /// Does not include local URLs or reply buttons; normal Gmail replies are handled via Reply-To.
        /// </summary>
        public static string BuildFeedbackNotificationBody(string customerName, string customerEmail, string subject, string message)
        {
            string safeName = HttpUtility.HtmlEncode(string.IsNullOrWhiteSpace(customerName) ? "Customer" : customerName);
            string safeEmail = HttpUtility.HtmlEncode(string.IsNullOrWhiteSpace(customerEmail) ? "(Not available)" : customerEmail);
            string safeSubject = HttpUtility.HtmlEncode(subject ?? string.Empty);
            string safeMessage = HttpUtility.HtmlEncode(message ?? string.Empty).Replace("\n", "<br/>");

            return $@"
<div style=""font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; border: 1px solid #e5e7eb; border-radius: 8px; overflow: hidden;"">
  <div style=""background-color: #008ECC; padding: 20px; color: #ffffff;"">
    <h2 style=""margin: 0; font-size: 20px;"">New Customer Feedback — FlipShop</h2>
  </div>
  <div style=""padding: 24px; color: #1f2937; line-height: 1.6;"">
    <p style=""margin: 0 0 8px 0;""><strong>Customer:</strong> {safeName}</p>
    
    <p style=""margin: 0 0 16px 0;""><strong>Subject:</strong> {safeSubject}</p>
    <div style=""background-color: #f9fafb; border-left: 4px solid #008ECC; padding: 14px 16px; margin: 16px 0; border-radius: 4px;"">
      <strong style=""display: block; margin-bottom: 6px; color: #374151;"">Feedback Message:</strong>
      <p style=""margin: 0; color: #1f2937;"">{safeMessage}</p>
    </div>
    <div style=""background-color: #f0fdf4; border: 1px solid #bbf7d0; border-radius: 6px; padding: 12px; margin-top: 20px; font-size: 13px; color: #166534;"">
      <strong>Direct Reply:</strong> Click <em>Reply</em> in Gmail to respond directly to this customer.
    </div>
  </div>
</div>";
        }

        /// <summary>
        /// Builds the customer-facing reply email body.
        /// Shields the administrator's institutional email address.
        /// </summary>
        public static string BuildCustomerReplyBody(string subject, string replyMessage)
        {
            string safeSubject = HttpUtility.HtmlEncode(subject);
            string safeReply = HttpUtility.HtmlEncode(replyMessage).Replace("\n", "<br/>");

            return $@"
<div style=""font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; border: 1px solid #e5e7eb; border-radius: 8px; overflow: hidden;"">
  <div style=""background-color: #008ECC; padding: 20px; color: #ffffff;"">
    <h2 style=""margin: 0; font-size: 20px;"">FlipShop Support Response</h2>
  </div>
  <div style=""padding: 24px; color: #1f2937; line-height: 1.6;"">
    <p>Dear Customer,</p>
    <p>Thank you for contacting FlipShop. Our support team has reviewed your feedback regarding <strong>{safeSubject}</strong>.</p>
    <div style=""background-color: #f9fafb; border-left: 4px solid #008ECC; padding: 14px 16px; margin: 16px 0; border-radius: 4px; color: #374151;"">
      {safeReply}
    </div>
    <p style=""margin-top: 24px;"">If you have any further questions or require additional assistance, please reach out through our Contact Us page on the website.</p>
    <p style=""margin-bottom: 0;"">Warm regards,<br/><strong>FlipShop Support Team</strong></p>
  </div>
  <div style=""background-color: #f3f4f6; padding: 12px 20px; font-size: 12px; color: #6b7280; text-align: center;"">
    &copy; {DateTime.UtcNow.Year} FlipShop. All rights reserved.
  </div>
</div>";
        }
    }
}
