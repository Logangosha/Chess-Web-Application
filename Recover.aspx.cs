using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Chess_App
{
    public partial class Recover : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ViewState["RecoverEmail"] = "Logangosha@gmail.com";
        }

        protected void ContinueBtn_Click(object sender, EventArgs e)
        {
            
        }
    }
}