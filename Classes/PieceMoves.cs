using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using static Chess_App.Classes.Chessboard;

namespace Chess_App
{
    public class PieceMoves
    {
        public Coordinates PieceCoordinates { get; set; }
        public List<Coordinates> PossibleMoveCoordinates { get; set; }
    }
}