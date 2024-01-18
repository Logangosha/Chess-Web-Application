using Chess_App.Classes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Chess_App
{
    public class Move
    {
        public int Turn { get; set; }
        public GameData.Color Color { get; set; }
        public string Notation { get; set; }

        public Move(int turn, GameData.Color color, string notation)
        {
            Turn = turn;
            Color = color;
            Notation = notation;
        }
    }
}