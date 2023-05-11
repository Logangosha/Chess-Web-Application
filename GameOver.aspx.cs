using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Chess_App
{
    public partial class GameOver : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Rematch_Command(object sender, CommandEventArgs e)
        {
            switch (e.CommandName.ToString())
            {
                case "Yes":
                    Response.Redirect("Game.aspx");
                    break;
                case "No":
                    Response.Redirect("Home.aspx");
                    break;
            }
        }
    }
}