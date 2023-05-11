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
                if (accountInfo.GetType() == typeof(PlayerAccount))
                    return true;
                else
                    return false;
            }
            else
                return false;
        }
    }
}