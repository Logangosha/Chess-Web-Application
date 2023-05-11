using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Chess_App
{
    public class AccountPassword
    {
        public string userPassword { get; set; }
        public AccountPassword(string _userPassword)
        {
            userPassword = _userPassword;
        }
    }
}