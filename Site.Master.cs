using System;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Web;
using System.Web.Services;
using System.Web.UI;

namespace Chess_App
{
    public partial class SiteMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Debug.WriteLine("Page load");
                Session["RemainingSessionTime"] = DateTime.Now.AddMinutes(14);
                string connectionString = "Data Source=mssql.anaxanet.com;Integrated Security=False;User ID=exkqffth_lgauchat;Password=UY*2d0!h5aI7Ni;Connect Timeout=30;Encrypt=False;Network Library=dbmssocn;Packet Size=4096";

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    try
                    {
                        connection.Open();
                        Debug.WriteLine("Connection successful!");
                    }
                    catch (Exception ex)
                    {
                        Debug.WriteLine("Error: " + ex.Message);
                    }
                }
                if (Session["AccountInfo"] == null)
                {
                    // check what page we are on
                    string path = HttpContext.Current.Request.Url.AbsolutePath;
                    bool pageWithoutAccount = path.Contains("default") || path.Contains("Register") || path.Contains("Login") || path.Contains("Recover");
                    Debug.WriteLine(path);
                    if (!pageWithoutAccount)
                        Response.Redirect("default.aspx");
                }
            }
            else 
            {
                SignUserOut();
            }
        }

        [WebMethod]
        public static void SignUserOut()
        {
            try
            {
                
                Debug.WriteLine("SignUserOut called");
                // if the current time is greater than the time in RemainingSessionTime
                // then the user has been inactive for 15 minutes
                // so we sign them out

                if ((DateTime)HttpContext.Current.Session["RemainingSessionTime"] <= DateTime.Now)
                {
                    Debug.WriteLine("Out of time");
                    
                        // check to see if the user is a guest or a player
                        if (HttpContext.Current.Session["AccountInfo"] is Guest)
                            {
                            HttpContext.Current.Response.Redirect("Default.aspx");
                        }
                        else if (HttpContext.Current.Session["AccountInfo"] is PlayerAccount)
                        {
                            PlayerAccount playerAccount = (PlayerAccount)HttpContext.Current.Session["AccountInfo"];
                            playerAccount.Logout();
                            HttpContext.Current.Response.Redirect("Default.aspx");
                        }
                        else
                        {
                            Debug.WriteLine("UserLeavesWebsite called but userAccount is null");
                            HttpContext.Current.Response.Redirect("Default.aspx");
                        }
                }
                else
                {
                    Debug.WriteLine("Not out of time");
                }
            }
            catch (Exception e)
            {
                Debug.WriteLine("C# Error " + e.Message);
            }
        }

        [WebMethod]
        public static void SetRemainingSessionTime()
        {
            HttpContext.Current.Session["RemainingSessionTime"] = DateTime.Now.AddMinutes(14);
        }
    }
}