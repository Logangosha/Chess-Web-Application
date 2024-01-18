using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using static Chess_App.Classes.Chessboard;

namespace Chess_App.Classes
{
    public class Square
    {
        public Coordinates Coordinates { get; set; }
        public Chessboard.Row Row { get; set; }
        public Chessboard.Column Column { get; set; }
        public Piece Piece { get; set; }
        public Square(Chessboard.Row row, Chessboard.Column column)
        {
            Row = row;
            Column = column;
            Coordinates = new Coordinates(row, column);
            Piece = null; // No piece initially placed on the square
        }
        // Constructor overload for pawn from css class
        public Square(string cssClass)
        {
            Column = ConvertCharacterToColumn(cssClass[0]);
            Row = ConvertCharacterToRow(cssClass[1]);
            Coordinates = new Coordinates(Row, Column);
            Piece = null;
        }

        public static Chessboard.Column ConvertCharacterToColumn(char character)
        {
            switch (character)
            {
                case 'a': return Chessboard.Column.A;
                case 'b': return Chessboard.Column.B;
                case 'c': return Chessboard.Column.C;
                case 'd': return Chessboard.Column.D;
                case 'e': return Chessboard.Column.E;
                case 'f': return Chessboard.Column.F;
                case 'g': return Chessboard.Column.G;
                case 'h': return Chessboard.Column.H;
                default: return Chessboard.Column.A;
            }
        }

        public static Chessboard.Row ConvertCharacterToRow(char character)
        {
            switch (character)
            {
                case '1': return Chessboard.Row.One;
                case '2': return Chessboard.Row.Two;
                case '3': return Chessboard.Row.Three;
                case '4': return Chessboard.Row.Four;
                case '5': return Chessboard.Row.Five;
                case '6': return Chessboard.Row.Six;
                case '7': return Chessboard.Row.Seven;
                case '8': return Chessboard.Row.Eight;
                default: return Chessboard.Row.One;
            }
        }
    }
}