using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Diagnostics;


namespace Chess_App
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connectionString = "Data Source=DESKTOP-DCC5NI2\\SQLEXPRESS01;Initial Catalog=chess_app_db;Integrated Security=True;";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                try
                {
                    connection.Open();

                    // Perform a test query or operation
                    SqlCommand command = new SqlCommand("SELECT 1", connection);
                    object result = command.ExecuteScalar();

                    // Check the result or perform further operations

                    // Connection is successful
                    Debug.WriteLine("Succsess");
                }
                catch (Exception ex)
                {
                    // Connection failed or exception occurred
                    Debug.WriteLine(ex.ToString());
                }
                finally
                {
                    // Close the connection after testing
                    connection.Close();
                }
            }
            if (Session["AccountInfo"] != null)
            {
                Session["AccountInfo"] = null;
            }
        }


        protected void LoginBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }

        protected void PlayAsGuestBtn_Click(object sender, EventArgs e)
        {
            Guest guest = new Guest();
            Session["AccountInfo"] = guest;
            Response.Redirect("Home.aspx");
        }

        protected void NeedAnAccountBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("Register.aspx");
        }
    }
}