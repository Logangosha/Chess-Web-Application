using System;
using System.Diagnostics;
using System.Net;
using System.Net.Mail;
using System.Web.Services;
using System.Configuration;
using Chess_App.Classes;

namespace Chess_App
{
    public partial class Recover : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ViewState["RecoverEmail"] = "Logangosha@gmail.com";
        }

        private static string GenerateCode()
        {
            Random random = new Random();
            string code = "";
            for (int i = 0; i < 6; i++)
            {
                code += random.Next(0, 9).ToString();
            }
            return code;
        }

        [WebMethod]
        public static bool VerifyRecoveryCode(string email, string code)
        {
            try
            {
                bool result = DatabaseAccess.VerifyRecoveryCode(email, code);
                return result;
            }
            catch (Exception e)
            {
                Debug.WriteLine("C# Error " + e.Message);
                return false;
            }
        }

        [WebMethod]
        public static void SendRecoveryEmail(string email)
        {
            try
            {
                // Your Gmail credentials
                string gmailAddress = ConfigurationManager.AppSettings["GmailUsername"];
                // debug gmail address
                Debug.WriteLine("gmail address: " + gmailAddress);
                string gmailPassword = ConfigurationManager.AppSettings["GmailPassword"];
                // debug gmail password
                Debug.WriteLine("gmail password: " + gmailPassword);

                // Create and configure the SmtpClient
                SmtpClient smtpClient = new SmtpClient("smtp.gmail.com");
                smtpClient.Port = 587;
                smtpClient.Credentials = new NetworkCredential(gmailAddress, gmailPassword);
                smtpClient.EnableSsl = true;

                // Create the email message
                MailMessage mailMessage = new MailMessage();
                mailMessage.From = new MailAddress(gmailAddress);
                mailMessage.To.Add(email);
                mailMessage.Subject = "Account Recovery Code";

                // Generate a random recovery code and save it in the database
                string code = GenerateCode().ToString();
                DatabaseAccess.StoreRecoveryCode(email, code);

                mailMessage.Body = "Your account recovery code is: " + code ; // Include the actual recovery code

                // Send the email
                smtpClient.Send(mailMessage);
            }
            catch (Exception e)
            {
                Debug.WriteLine("C# Error " + e.Message);
            }
        }

        [WebMethod]
        public static void ChangePassword(string password, string email)
        {
            try
            {
                string username = DatabaseAccess.GetUsernameFromEmail(email);
                // display username 
                Debug.WriteLine("Username is " + username);
                DatabaseAccess.SaveNewPassword(username, password);
            }
            catch (Exception e)
            {
                Debug.WriteLine("C# Error " + e.Message);
            }
        }
    }
}