using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace Chess_App.Classes
{
    public class AccountValidation
    {
        public static bool UsingAccount()
        {
            var accountInfo = HttpContext.Current.Session["AccountInfo"];
            if (accountInfo != null)
            {
                if (accountInfo is Guest)
                {
                    return false;
                }
                else
                {
                    return true;
                }
            }
            else
            {
                HttpContext.Current.Response.Redirect("Default.aspx");
                return false;
            }
        }
    }
}