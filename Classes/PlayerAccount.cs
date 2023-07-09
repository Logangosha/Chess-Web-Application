using Chess_App;
using Microsoft.AspNet.FriendlyUrls.ModelBinding;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Chess_App.Classes;

namespace Chess_App
{
    public class PlayerAccount
    {
        public string Username { get; set; }
        public string Email { get; set; }
        public byte[][] PasswordData { get; set; }
        public Theme Theme { get; set; }
        public List<Friend> Friends { get; set; }
        public List<Classes.Game> GameHistory { get; set; }
        public List<Notification> Notifications { get; set; }
        public bool PlayerStatus { get; set; }

        //when account is logged into
        public PlayerAccount(string _uName, string _email, Theme theme)
        {

            Username = _uName;
            Email = _email;
            Theme = theme;
        }
        // when account is created 
        public PlayerAccount(string _uName, string _email, byte[][] _password)
        {

            Username = _uName;
            Email = _email;
            PasswordData = _password;
        }
    }
}