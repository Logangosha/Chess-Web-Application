using Chess_App.Classes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Chess_App
{
    public class Coordinates
    {
        public Chessboard.Row Row { get; set; }
        public Chessboard.Column Column { get; set; }
        public string CoordinateString { get; set; }
        public Coordinates(Chessboard.Row row, Chessboard.Column column)
        {
            Row = row;
            Column = column;
            CoordinateString = Column.ToString() + Row.ToString();
        }
    }
}