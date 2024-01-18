using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Chess_App
{
    public class TurnHandler
    {
        public GameData.Color CurrentColorTurn { get; set; }
        public int CurrentTurn { get; set; }
        public string Markee { get; set; }
        public TurnHandler()
        {
            CurrentColorTurn = GameData.Color.White;
            CurrentTurn = 1;
            Markee = "Welcome! White to move.";
        }

        public void ChangeTurn()
        {
            if (CurrentColorTurn == GameData.Color.White)
            {
                CurrentColorTurn = GameData.Color.Black;
            }
            else
            {
                CurrentColorTurn = GameData.Color.White;
                NextTurn();
            }
        }

        public void NextTurn()
        { 
            CurrentTurn++;
        }

        public void SetMarkee(string markee)
        {
            Markee = markee;
        }
    }
}