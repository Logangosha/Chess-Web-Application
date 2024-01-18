using Chess_App.Classes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Chess_App
{
    public partial class MoveHistory
    {
        public List<Move> Moves { get; set; }
        
        public MoveHistory()
        {
            Moves = new List<Move>();
        }
        public void AddMove(Move move)
        {
            Moves.Add(move);
        }

    }
}