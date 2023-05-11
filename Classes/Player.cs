using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Chess_App.Classes
{
    public class Player
    {
        public PlayerAccount AccountPlayer { get; set; }
        public Guest GuestPlayer { get; set; }
        public Computer ComputerPlayer { get; set; }
        public bool Color { get; set; }
        public Player(PlayerAccount accountPlayer, bool color )
        {
            AccountPlayer = accountPlayer;
            GuestPlayer = null;
            ComputerPlayer = null;
            Color = color;
        }
        public Player(Guest guestPlayer, bool color)
        {
            AccountPlayer = null;
            GuestPlayer = guestPlayer;
            ComputerPlayer = null;
            Color = color;
        }
        public Player(Computer computerPlayer, bool color)
        {
            AccountPlayer = null;
            GuestPlayer = null;
            ComputerPlayer = computerPlayer;
            Color = color;
        }
    }
}