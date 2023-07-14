using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Chess_App.Classes;

namespace Chess_App
{
    public partial class SiteMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
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
        }
    }
}