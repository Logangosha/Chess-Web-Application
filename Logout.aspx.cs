using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Chess_App
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string action = Request.QueryString["action"];

            if (action == "logout")
            {
                // Perform the logout action
                // Update the user's status to "offline" in the database
            }
            else
            {
                // Regular page navigation, no action needed
            }
        }
    }
}