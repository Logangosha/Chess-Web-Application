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
        public string fName { get; set; }
        public string lName { get; set; }
        public string uName { get; set; }
        public string email { get; set; }
        public string dob { get; set; }
        public AccountPassword password { get; set; }
        public List<Friend> friends { get; set; }
        public List<Classes.Game> gameHistory { get; set; }
        public List<Notification> notifications { get; set; }
        public bool PlayerStatus { get; set; }
        //when account is logged into
        public PlayerAccount(string _fName, string _lName, string _uName, string _email, string _dob, AccountPassword _password, List<Friend> _friends, List<Classes.Game> _gameHistory, List<Notification> _notifications)
        {
            fName = _fName;
            lName = _lName;
            uName = _uName;
            email = _email;
            dob = _dob;
            password = _password;
            friends = _friends;
            gameHistory = _gameHistory;
            notifications = _notifications;
            PlayerStatus = true;
    }
        // when account is created 
        public PlayerAccount(string _fName, string _lName, string _uName, string _email, string _dob, AccountPassword _password)
        {
            fName = _fName;
            lName = _lName;
            uName = _uName;
            email = _email;
            dob = _dob;
            password = _password;
            friends = new List<Friend> { };
            gameHistory = new List<Classes.Game> { };
            notifications = new List<Notification> { };
            PlayerStatus = true;
        }
    }
}