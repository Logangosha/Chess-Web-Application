using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.SessionState;
using static Chess_App.Classes.Chessboard;

namespace Chess_App.Classes
{
    public class Piece
    {
        public enum PieceType
        {
            Pawn = 0,
            Rook,
            Knight,
            Bishop,
            Queen,
            King
        }
        public PieceType Type { get; set; }
        public GameData.Color Color { get; set; }
        public Piece(PieceType type, GameData.Color color)
        {
            Type = type;
            Color = color;
        }
        // constructor overload for pawn from css class
        public Piece(string cssClass)
        {
            Color = ConvertCharacterToColor(cssClass[0]);
            Type = ConvertCharacterToPiece(cssClass[1]);
        }
        public PieceType ConvertCharacterToPiece(char character)
        {
            switch (character)
            {
                case 'p': return PieceType.Pawn;
                case 'r': return PieceType.Rook;
                case 'n': return PieceType.Knight;
                case 'b': return PieceType.Bishop;
                case 'q': return PieceType.Queen;
                case 'k': return PieceType.King;
                default: return PieceType.Pawn;
            }
        }
        public GameData.Color ConvertCharacterToColor(char character)
        {
            switch (character)
            {
                case 'w': return GameData.Color.White;
                case 'b': return GameData.Color.Black;
                default: return GameData.Color.White;
            }
        }
        public static List<Coordinates> GetPawnMoves(Square square, Chessboard chessboard)
        {
            List<Coordinates> possibleMovesForPiece = new List<Coordinates>();

            // check if the pawn is black or white
            if (square.Piece.Color == GameData.Color.White)
            {
                // get moves above pawn
                List<Coordinates> movesOnTop = GetMovesOnTopOfPawn(square, chessboard);
                if (movesOnTop != null)
                    possibleMovesForPiece.AddRange(movesOnTop);

                // get moves diagonally left above pawn
                Coordinates moveTopLeft = GetMoveOnTheTopLeftOfSquare(square, chessboard);
                if (moveTopLeft != null)
                    possibleMovesForPiece.Add(moveTopLeft);

                // get moves diagonally right above pawn
                Coordinates moveTopRight = GetMoveOnTheTopRightOfSquare(square, chessboard);
                if (moveTopRight != null)
                    possibleMovesForPiece.Add(moveTopRight);
            }
            else
            {
                // get moves below pawn
                List<Coordinates> movesOnBottom = GetMovesOnBottomOfPawn(square, chessboard);
                if (movesOnBottom != null)
                    possibleMovesForPiece.AddRange(movesOnBottom);

                // get moves diagonally left below pawn
                Coordinates moveBottomLeft = GetMoveOnTheBottomLeftOfSquare(square, chessboard);
                if (moveBottomLeft != null)
                    possibleMovesForPiece.Add(moveBottomLeft);

                // get moves diagonally right below pawn
                Coordinates moveBottomRight = GetMoveOnTheBottomRightOfSquare(square, chessboard);
                if (moveBottomRight != null)
                    possibleMovesForPiece.Add(moveBottomRight);
            }

            return possibleMovesForPiece;
        }
        public static List<Coordinates> GetMovesOnTopOfPawn(Square square, Chessboard chessboard)
        {
            List<Coordinates> possibleMovesForPiece = new List<Coordinates>();
            Coordinates moveOnTopOfSquare = GetMoveOnTopOfSquare(square, chessboard);

            if (moveOnTopOfSquare != null)
            {
                // Add the move on top of the square
                possibleMovesForPiece.Add(moveOnTopOfSquare);

                // Check double space move
                if (square.Row == Row.Two && IsSquareEmpty(chessboard.Board[(int)square.Row + 2, (int)square.Column]))
                {
                    possibleMovesForPiece.Add(new Coordinates(Row.Four, square.Column));
                }
            }
            return possibleMovesForPiece;
        }
        public static List<Coordinates> GetMovesOnBottomOfPawn(Square square, Chessboard chessboard)
        {
            List<Coordinates> possibleMovesForPiece = new List<Coordinates>();

            Coordinates moveOnBottomOfSquare = GetMoveOnTheBottomOfSquare(square, chessboard);
            if (moveOnBottomOfSquare != null)
            {
                // Add the move on top of the square
                possibleMovesForPiece.Add(moveOnBottomOfSquare);

                // Check double space move
                if (square.Row == Row.Seven && IsSquareEmpty(chessboard.Board[(int)square.Row - 2, (int)square.Column]))
                {
                    possibleMovesForPiece.Add(new Coordinates(Row.Five, square.Column));
                }
            }
            return possibleMovesForPiece;
        }
        public static List<Coordinates> GetKnightMoves(Square square, Chessboard chessboard)
        {
            List<Coordinates> possibleMovesForPiece = new List<Coordinates>();

            // Get L shaped moves for the piece
            List<Coordinates> lShapedMoves = GetLShapedMoves(square, chessboard);
            if (lShapedMoves != null)
                possibleMovesForPiece.AddRange(lShapedMoves);

            return possibleMovesForPiece;
        }
        public static List<Coordinates> GetBishopMoves(Square square, Chessboard chessboard)
        {
            // Get the possible moves for the bishop by combining the moves diagonally to the left, diagonally to the right, diagonally upwards and diagonally downwards
            List<Coordinates> possibleMovesForPiece = new List<Coordinates>();
            // Add the moves to the bottom left obtained from the other function
            possibleMovesForPiece.AddRange(GetMovesOnTheBottomLeftOfSquare(square, chessboard));
            // Add the moves to the bottom right obtained from the other function
            possibleMovesForPiece.AddRange(GetMovesOnTheBottomRightOfSquare(square, chessboard));
            // Add the moves to the top left obtained from the other function
            possibleMovesForPiece.AddRange(GetMovesOnTheTopLeftOfSquare(square, chessboard));
            // Add the moves to the top right obtained from the other function
            possibleMovesForPiece.AddRange(GetMovesOnTheTopRightOfSquare(square, chessboard));
            return possibleMovesForPiece;
        }
        public static List<Coordinates> GetRookMoves(Square square, Chessboard chessboard)
        {
            // Get the possible moves for the rook by combining the moves to the left, right, above and below the square
            List<Coordinates> possibleMovesForPiece = new List<Coordinates>();

            // Add the moves to the left obtained from the other function
            possibleMovesForPiece.AddRange(GetMovesOnTheLeftOfSquare(square, chessboard));

            // Add the moves to the right obtained from the other function
            possibleMovesForPiece.AddRange(GetMovesOnTheRightOfSquare(square, chessboard));

            // Add the moves above obtained from the other function
            possibleMovesForPiece.AddRange(GetMovesOnTheTopOfTheSquare(square, chessboard));

            // Add the moves below obtained from the other function
            possibleMovesForPiece.AddRange(GetMovesOnTheBottomOfTheSquare(square, chessboard));

            return possibleMovesForPiece;
        }
        public static List<Coordinates> GetQueenMoves(Square square, Chessboard chessboard)
        {
            List<Coordinates> possibleMovesForPiece = new List<Coordinates>();
            // Add the moves to the left obtained from the other function
            possibleMovesForPiece.AddRange(GetMovesOnTheLeftOfSquare(square, chessboard));
            // Add the moves to the right obtained from the other function
            possibleMovesForPiece.AddRange(GetMovesOnTheRightOfSquare(square, chessboard));
            // Add the moves above obtained from the other function
            possibleMovesForPiece.AddRange(GetMovesOnTheTopOfTheSquare(square, chessboard));
            // Add the moves below obtained from the other function
            possibleMovesForPiece.AddRange(GetMovesOnTheBottomOfTheSquare(square, chessboard));
            // Add the moves to the bottom left obtained from the other function
            possibleMovesForPiece.AddRange(GetMovesOnTheBottomLeftOfSquare(square, chessboard));
            // Add the moves to the bottom right obtained from the other function
            possibleMovesForPiece.AddRange(GetMovesOnTheBottomRightOfSquare(square, chessboard));
            // Add the moves to the top left obtained from the other function
            possibleMovesForPiece.AddRange(GetMovesOnTheTopLeftOfSquare(square, chessboard));
            // Add the moves to the top right obtained from the other function
            possibleMovesForPiece.AddRange(GetMovesOnTheTopRightOfSquare(square, chessboard));
            return possibleMovesForPiece;
        }
        public static List<Coordinates> GetKingMoves(Square square, Chessboard chessboard)
        {
            List<Coordinates> possibleMovesForPiece = new List<Coordinates>();

            Coordinates moveOnTop = GetMoveOnTopOfSquare(square, chessboard);
            if (moveOnTop != null)
                possibleMovesForPiece.Add(moveOnTop);

            Coordinates moveOnBottom = GetMoveOnTheBottomOfSquare(square, chessboard);
            if (moveOnBottom != null)
                possibleMovesForPiece.Add(moveOnBottom);

            Coordinates moveOnLeft = GetMoveOnTheLeftOfSquare(square, chessboard);
            if (moveOnLeft != null)
                possibleMovesForPiece.Add(moveOnLeft);

            Coordinates moveOnRight = GetMoveOnTheRightOfSquare(square, chessboard);
            if (moveOnRight != null)
                possibleMovesForPiece.Add(moveOnRight);

            Coordinates moveTopLeft = GetMoveOnTheTopLeftOfSquare(square, chessboard);
            if (moveTopLeft != null)
                possibleMovesForPiece.Add(moveTopLeft);

            Coordinates moveTopRight = GetMoveOnTheTopRightOfSquare(square, chessboard);
            if (moveTopRight != null)
                possibleMovesForPiece.Add(moveTopRight);

            Coordinates moveBottomLeft = GetMoveOnTheBottomLeftOfSquare(square, chessboard);
            if (moveBottomLeft != null)
                possibleMovesForPiece.Add(moveBottomLeft);

            Coordinates moveBottomRight = GetMoveOnTheBottomRightOfSquare(square, chessboard);
            if (moveBottomRight != null)
                possibleMovesForPiece.Add(moveBottomRight);

            GameData.Color currentColorTurn = ((TurnHandler)HttpContext.Current.Session["TurnHandler"]).CurrentColorTurn;
            if (currentColorTurn == square.Piece.Color)
            { 
                if (IsKingSideCastleLegal(square, chessboard))
                {
                    if (square.Piece.Color == GameData.Color.White)
                    {
                        possibleMovesForPiece.Add(new Coordinates(Row.One, Column.G));       
                    }
                    else 
                    {
                        possibleMovesForPiece.Add(new Coordinates(Row.Eight, Column.G));
                    }
                }
                if (IsQueenSideCastleLegal(square, chessboard))
                {
                    if (square.Piece.Color == GameData.Color.White)
                    {
                        possibleMovesForPiece.Add(new Coordinates(Row.One, Column.C));
                    }
                    else
                    {
                        possibleMovesForPiece.Add(new Coordinates(Row.Eight, Column.C));
                    }
                }
            }

            return possibleMovesForPiece;
        }
        public static bool IsKingSideCastleLegal(Square square, Chessboard chessboard) {
            // get color of king
            if (square.Piece.Color == GameData.Color.White)
            {
                // check if squares between king and rook are empty (f1 and g1)
                if (chessboard.Board[(int)Row.One, (int)Column.F].Piece == null && chessboard.Board[(int)Row.One, (int)Column.G].Piece == null)
                {
                    GameData.Color nextColorTurn = (((TurnHandler)HttpContext.Current.Session["TurnHandler"]).CurrentColorTurn == GameData.Color.White? GameData.Color.Black: GameData.Color.White);
                    List<Coordinates> castleCoordinates = new List<Coordinates> 
                    {
                        // add coordinates e1 f1 and g1
                        new Coordinates(Row.One, Column.E),
                        new Coordinates(Row.One, Column.F),
                        new Coordinates(Row.One, Column.G),
                    };
                    return !GameData.IsKingCastlingThoughCheck(chessboard, nextColorTurn, castleCoordinates);
                }

            }
            else 
            {
                // check if squares between king and rook are empty (f8 and g8)
                if (chessboard.Board[(int)Row.Eight, (int)Column.F].Piece == null && chessboard.Board[(int)Row.Eight, (int)Column.G].Piece == null)
                {
                    GameData.Color nextColorTurn = (((TurnHandler)HttpContext.Current.Session["TurnHandler"]).CurrentColorTurn == GameData.Color.White ? GameData.Color.Black : GameData.Color.White);
                    List<Coordinates> castleCoordinates = new List<Coordinates>
                    {
                        // add coordinates e8 f8 and g8
                        new Coordinates(Row.Eight, Column.E),
                        new Coordinates(Row.Eight, Column.F),
                        new Coordinates(Row.Eight, Column.G),
                    };
                    return !GameData.IsKingCastlingThoughCheck(chessboard, nextColorTurn, castleCoordinates);
                }
            }
            return false;
        }
        public static bool IsQueenSideCastleLegal(Square square, Chessboard chessboard)
        {
            // get color of king
            if (square.Piece.Color == GameData.Color.White)
            {
                // check if squares between king and rook are empty (b1 and c1 and d1)
                if (chessboard.Board[(int)Row.One, (int)Column.B].Piece == null && chessboard.Board[(int)Row.One, (int)Column.C].Piece == null && chessboard.Board[(int)Row.One, (int)Column.D].Piece == null)
                {
                    GameData.Color nextColorTurn = (((TurnHandler)HttpContext.Current.Session["TurnHandler"]).CurrentColorTurn == GameData.Color.White ? GameData.Color.Black : GameData.Color.White);
                    List<Coordinates> castleCoordinates = new List<Coordinates>
                    {
                        // add coordinates c1 d1 and e1
                        new Coordinates(Row.One, Column.C),
                        new Coordinates(Row.One, Column.D),
                        new Coordinates(Row.One, Column.E),
                    };
                    return !GameData.IsKingCastlingThoughCheck(chessboard, nextColorTurn, castleCoordinates);
                }

            }
            else
            {
                // check if squares between king and rook are empty (b8 and c8 and d8)
                if (chessboard.Board[(int)Row.Eight, (int)Column.B].Piece == null && chessboard.Board[(int)Row.Eight, (int)Column.C].Piece == null && chessboard.Board[(int)Row.Eight, (int)Column.D].Piece == null)
                {
                    GameData.Color nextColorTurn = (((TurnHandler)HttpContext.Current.Session["TurnHandler"]).CurrentColorTurn == GameData.Color.White ? GameData.Color.Black : GameData.Color.White);
                    List<Coordinates> castleCoordinates = new List<Coordinates>
                    {
                        // add coordinates e8 f8 and g8
                        new Coordinates(Row.Eight, Column.C),
                        new Coordinates(Row.Eight, Column.D),
                        new Coordinates(Row.Eight, Column.E),
                    };
                    return !GameData.IsKingCastlingThoughCheck(chessboard, nextColorTurn, castleCoordinates);
                }
            }
            return false;
        }
        public static List<Coordinates> GetMovesOnTheTopLeftOfSquare(Square square, Chessboard chessboard)
        {
            List<Coordinates> movesTopLeft = new List<Coordinates>();
            Chessboard.Row row = square.Coordinates.Row;
            Chessboard.Column column = square.Coordinates.Column;

            // starting with the square diagonally upwards and to the left of the square param the piece is on
            for (int i = (int)row + 1, j = (int)column - 1; i < 8 && j >= 0; i++, j--)
            {
                if (IsSquareEmpty(chessboard.Board[i, j]))
                {
                    movesTopLeft.Add(new Coordinates((Chessboard.Row)i, (Chessboard.Column)j));
                }
                else if (IsSquareOccupiedByOpponent(chessboard.Board[i, j], square.Piece.Color))
                {
                    movesTopLeft.Add(new Coordinates((Chessboard.Row)i, (Chessboard.Column)j));
                    break;
                }
                else
                {
                    break;
                }
            }

            return movesTopLeft;
        }
        public static Coordinates GetMoveOnTheTopLeftOfSquare(Square square, Chessboard chessboard)
        {
            Coordinates moveTopLeft = new Coordinates(square.Coordinates.Row + 1, square.Coordinates.Column - 1);
            if (IsSquareOnBoard(moveTopLeft))
            { 
                if (square.Piece.Type == PieceType.Pawn)
                {
                    if (IsSquareOccupiedByOpponent(chessboard.Board[(int)moveTopLeft.Row, (int)moveTopLeft.Column], square.Piece.Color) || (chessboard.EnPassant != null) && (chessboard.Board[(int)moveTopLeft.Row, (int)moveTopLeft.Column].Coordinates.CoordinateString == chessboard.EnPassant.EnPassentCoordinates.CoordinateString && square.Piece.Color != chessboard.EnPassant.PieceColor))
                    {
                        return moveTopLeft;
                    }
                }
                else 
                {
                    if ((IsSquareEmpty(chessboard.Board[(int)moveTopLeft.Row, (int)moveTopLeft.Column]) || IsSquareOccupiedByOpponent(chessboard.Board[(int)moveTopLeft.Row, (int)moveTopLeft.Column], square.Piece.Color)))
                    {
                        return moveTopLeft;
                    }
                }
            }
            return null;
        }
        public static Coordinates GetMoveOnTheTopRightOfSquare(Square square, Chessboard chessboard)
        {
            Coordinates moveTopRight = new Coordinates(square.Coordinates.Row + 1, square.Coordinates.Column + 1);
            if (IsSquareOnBoard(moveTopRight))
            { 
                if (square.Piece.Type == PieceType.Pawn)
                {
                    if (IsSquareOccupiedByOpponent(chessboard.Board[(int)moveTopRight.Row, (int)moveTopRight.Column], square.Piece.Color) || (chessboard.EnPassant != null) && (chessboard.Board[(int)moveTopRight.Row, (int)moveTopRight.Column].Coordinates.CoordinateString == chessboard.EnPassant.EnPassentCoordinates.CoordinateString && square.Piece.Color != chessboard.EnPassant.PieceColor))
                    {
                        return moveTopRight;
                    }
                }
                else
                {
                    if ((IsSquareEmpty(chessboard.Board[(int)moveTopRight.Row, (int)moveTopRight.Column]) || IsSquareOccupiedByOpponent(chessboard.Board[(int)moveTopRight.Row, (int)moveTopRight.Column], square.Piece.Color)))
                    {
                        return moveTopRight;
                    }
                }
            }
            return null;
        }
        public static Coordinates GetMoveOnTheBottomLeftOfSquare(Square square, Chessboard chessboard)
        {
            Coordinates moveBottomLeft = new Coordinates(square.Coordinates.Row - 1, square.Coordinates.Column - 1);
            if (IsSquareOnBoard(moveBottomLeft))
            {
                if (square.Piece.Type == PieceType.Pawn)
                {
                    if (IsSquareOccupiedByOpponent(chessboard.Board[(int)moveBottomLeft.Row, (int)moveBottomLeft.Column], square.Piece.Color) || ((chessboard.EnPassant != null) && (chessboard.Board[(int)moveBottomLeft.Row, (int)moveBottomLeft.Column].Coordinates.CoordinateString == chessboard.EnPassant.EnPassentCoordinates.CoordinateString && square.Piece.Color != chessboard.EnPassant.PieceColor)))
                    {
                        return moveBottomLeft;
                    }
                }
                else
                {
                    if ((IsSquareEmpty(chessboard.Board[(int)moveBottomLeft.Row, (int)moveBottomLeft.Column]) || IsSquareOccupiedByOpponent(chessboard.Board[(int)moveBottomLeft.Row, (int)moveBottomLeft.Column], square.Piece.Color)))
                    {
                        return moveBottomLeft;
                    }
                }
            }
            return null;
        }
        public static Coordinates GetMoveOnTheBottomRightOfSquare(Square square, Chessboard chessboard)
        {
            Coordinates moveBottomRight = new Coordinates(square.Coordinates.Row - 1, square.Coordinates.Column + 1);
            if (IsSquareOnBoard(moveBottomRight))
            { 
                if (square.Piece.Type == PieceType.Pawn)
                {
                    if (IsSquareOccupiedByOpponent(chessboard.Board[(int)moveBottomRight.Row, (int)moveBottomRight.Column], square.Piece.Color) || ((chessboard.EnPassant != null) && (chessboard.Board[(int)moveBottomRight.Row, (int)moveBottomRight.Column].Coordinates.CoordinateString == chessboard.EnPassant.EnPassentCoordinates.CoordinateString && square.Piece.Color != chessboard.EnPassant.PieceColor)))
                    {
                        return moveBottomRight;
                    }
                }
                else 
                {
                    if ((IsSquareEmpty(chessboard.Board[(int)moveBottomRight.Row, (int)moveBottomRight.Column]) || IsSquareOccupiedByOpponent(chessboard.Board[(int)moveBottomRight.Row, (int)moveBottomRight.Column], square.Piece.Color)))
                    {
                        return moveBottomRight;
                    }
                }
            }
            return null;
        }
        public static Coordinates GetMoveOnTheLeftOfSquare(Square square, Chessboard chessboard)
        {
            Coordinates moveToLeft = new Coordinates(square.Coordinates.Row, square.Coordinates.Column - 1);
            if (IsSquareOnBoard(moveToLeft) && (IsSquareEmpty(chessboard.Board[(int)moveToLeft.Row, (int)moveToLeft.Column]) || IsSquareOccupiedByOpponent(chessboard.Board[(int)moveToLeft.Row, (int)moveToLeft.Column], square.Piece.Color)))
            {
                return moveToLeft;
            }
            return null;
        }
        public static Coordinates GetMoveOnTheRightOfSquare(Square square, Chessboard chessboard)
        {
            Coordinates moveToRight = new Coordinates(square.Coordinates.Row, square.Coordinates.Column + 1);
            if (IsSquareOnBoard(moveToRight) && (IsSquareEmpty(chessboard.Board[(int)moveToRight.Row, (int)moveToRight.Column]) || IsSquareOccupiedByOpponent(chessboard.Board[(int)moveToRight.Row, (int)moveToRight.Column], square.Piece.Color)))
            {
                return moveToRight;
            }
            return null;
        }
        public static Coordinates GetMoveOnTopOfSquare(Square square, Chessboard chessboard)
        {
            
            Coordinates moveAbove = new Coordinates(square.Coordinates.Row + 1, square.Coordinates.Column);
            if (square.Piece.Type == PieceType.Pawn)
            {
                if (IsSquareOnBoard(moveAbove) && IsSquareEmpty(chessboard.Board[(int)moveAbove.Row, (int)moveAbove.Column]))
                {
                    return moveAbove;
                }
            }
            else 
            {
                if (IsSquareOnBoard(moveAbove) && (IsSquareEmpty(chessboard.Board[(int)moveAbove.Row, (int)moveAbove.Column]) || IsSquareOccupiedByOpponent(chessboard.Board[(int)moveAbove.Row, (int)moveAbove.Column], square.Piece.Color)))
                {
                    return moveAbove;
                }   
            }
            return null;
        }
        public static Coordinates GetMoveOnTheBottomOfSquare(Square square, Chessboard chessboard)
        {
            Coordinates moveBelow = new Coordinates(square.Coordinates.Row - 1, square.Coordinates.Column);
            if (square.Piece.Type == PieceType.Pawn)
            {
                if (IsSquareOnBoard(moveBelow) && IsSquareEmpty(chessboard.Board[(int)moveBelow.Row, (int)moveBelow.Column]))
                {
                    return moveBelow;
                }
            }
            else
            {
                if (IsSquareOnBoard(moveBelow) && (IsSquareEmpty(chessboard.Board[(int)moveBelow.Row, (int)moveBelow.Column]) || IsSquareOccupiedByOpponent(chessboard.Board[(int)moveBelow.Row, (int)moveBelow.Column], square.Piece.Color)))
                {
                    return moveBelow;
                }
            }
            return null;
        }
        public static List<Coordinates> GetMovesOnTheBottomLeftOfSquare(Square square, Chessboard chessboard)
        {
            List<Coordinates> movesBottomLeft = new List<Coordinates>();
            Chessboard.Row row = square.Coordinates.Row;
            Chessboard.Column column = square.Coordinates.Column;

            // starting with the square diagonally downwards and to the left of the square param the piece is on
            for (int i = (int)row - 1, j = (int)column - 1; i >= 0 && j >= 0; i--, j--)
            {
                if (IsSquareEmpty(chessboard.Board[i, j]))
                {
                    movesBottomLeft.Add(new Coordinates((Chessboard.Row)i, (Chessboard.Column)j));
                }
                else if (IsSquareOccupiedByOpponent(chessboard.Board[i, j], square.Piece.Color))
                {
                    movesBottomLeft.Add(new Coordinates((Chessboard.Row)i, (Chessboard.Column)j));
                    break;
                }
                else
                {
                    break;
                }
            }
            return movesBottomLeft;
        }
        public static List<Coordinates> GetMovesOnTheTopRightOfSquare(Square square, Chessboard chessboard)
        {
            List<Coordinates> movesTopRight = new List<Coordinates>();
            Chessboard.Row row = square.Coordinates.Row;
            Chessboard.Column column = square.Coordinates.Column;

            // starting with the square diagonally upwards and to the right of the square param the piece is on
            for (int i = (int)row + 1, j = (int)column + 1; i < 8 && j < 8; i++, j++)
            {
                if (IsSquareEmpty(chessboard.Board[i, j]))
                {
                    movesTopRight.Add(new Coordinates((Chessboard.Row)i, (Chessboard.Column)j));
                }
                else if (IsSquareOccupiedByOpponent(chessboard.Board[i, j], square.Piece.Color))
                {
                    movesTopRight.Add(new Coordinates((Chessboard.Row)i, (Chessboard.Column)j));
                    break;
                }
                else
                {
                    break;
                }
            }

            return movesTopRight;
        }
        public static List<Coordinates> GetMovesOnTheBottomRightOfSquare(Square square, Chessboard chessboard)
        {
            List<Coordinates> movesBottomRight = new List<Coordinates>();
            Chessboard.Row row = square.Coordinates.Row;
            Chessboard.Column column = square.Coordinates.Column;

            // starting with the square diagonally downwards and to the right of the square param the piece is on
            for (int i = (int)row - 1, j = (int)column + 1; i >= 0 && j < 8; i--, j++)
            {
                if (IsSquareEmpty(chessboard.Board[i, j]))
                {
                    movesBottomRight.Add(new Coordinates((Chessboard.Row)i, (Chessboard.Column)j));
                }
                else if (IsSquareOccupiedByOpponent(chessboard.Board[i, j], square.Piece.Color))
                {
                    movesBottomRight.Add(new Coordinates((Chessboard.Row)i, (Chessboard.Column)j));
                    break;
                }
                else
                {
                    break;
                }
            }

            return movesBottomRight;
        }
        public static List<Coordinates> GetMovesOnTheLeftOfSquare(Square square, Chessboard chessboard)
        {
            List<Coordinates> movesToTheLeft = new List<Coordinates>();
            Chessboard.Row row = square.Coordinates.Row;
            Chessboard.Column column = square.Coordinates.Column;

            for (int i = (int)column - 1; i >= 0; i--)
            {
                if (IsSquareEmpty(chessboard.Board[(int)row, i]))
                {
                    movesToTheLeft.Add(new Coordinates(row, (Chessboard.Column)i));
                }
                else if (IsSquareOccupiedByOpponent(chessboard.Board[(int)row, i], square.Piece.Color))
                {
                    movesToTheLeft.Add(new Coordinates(row, (Chessboard.Column)i));
                    break;
                }
                else
                {
                    break;
                }
            }

            return movesToTheLeft;
        }
        public static List<Coordinates> GetMovesOnTheRightOfSquare(Square square, Chessboard chessboard)
        {
            List<Coordinates> movesToTheRight = new List<Coordinates>();
            Chessboard.Row row = square.Coordinates.Row;
            Chessboard.Column column = square.Coordinates.Column;
            // starting with the square to the right of the square param the piece is on
            for (int i = (int)column + 1; i < 8; i++)
            {
                if (IsSquareEmpty(chessboard.Board[(int)row, i]))
                {
                    movesToTheRight.Add(new Coordinates(row, (Chessboard.Column)i));
                }
                else if (IsSquareOccupiedByOpponent(chessboard.Board[(int)row, i], square.Piece.Color))
                {
                    movesToTheRight.Add(new Coordinates(row, (Chessboard.Column)i));
                    break;
                }
                else
                {
                    break;
                }
            }
            return movesToTheRight;
        }
        public static List<Coordinates> GetMovesOnTheTopOfTheSquare(Square square, Chessboard chessboard)
        {
            List<Coordinates> movesAbove = new List<Coordinates>();
            Chessboard.Row row = square.Coordinates.Row;
            Chessboard.Column column = square.Coordinates.Column;
            // starting with the square above the square param the piece is on
            for (int i = (int)row - 1; i >= 0; i--)
            {
                if (IsSquareEmpty(chessboard.Board[i, (int)column]))
                {
                    movesAbove.Add(new Coordinates((Chessboard.Row)i, column));
                }
                else if (IsSquareOccupiedByOpponent(chessboard.Board[i, (int)column], square.Piece.Color))
                {
                    movesAbove.Add(new Coordinates((Chessboard.Row)i, column));
                    break;
                }
                else
                {
                    break;
                }
            }
            return movesAbove;
        }
        public static List<Coordinates> GetMovesOnTheBottomOfTheSquare(Square square, Chessboard chessboard)
        {
            List<Coordinates> movesBelow = new List<Coordinates>();
            Chessboard.Row row = square.Coordinates.Row;
            Chessboard.Column column = square.Coordinates.Column;
            // starting with the square below the square param the piece is on
            for (int i = (int)row + 1; i < 8; i++)
            {
                if (IsSquareEmpty(chessboard.Board[i, (int)column]))
                {
                    movesBelow.Add(new Coordinates((Chessboard.Row)i, column));
                }
                else if (IsSquareOccupiedByOpponent(chessboard.Board[i, (int)column], square.Piece.Color))
                {
                    movesBelow.Add(new Coordinates((Chessboard.Row)i, column));
                    break;
                }
                else
                {
                    break;
                }
            }
            return movesBelow;
        }
        public static List<Coordinates> GetLShapedMoves(Square square, Chessboard chessboard)
        {
            List<Coordinates> movesLShaped = new List<Coordinates>();
            Chessboard.Row row = square.Coordinates.Row;
            Chessboard.Column column = square.Coordinates.Column;
            // Define the possible knight move offsets
            int[] rowOffsets = { 1, 2, 2, 1, -1, -2, -2, -1 };
            int[] colOffsets = { -2, -1, 1, 2, 2, 1, -1, -2 };

            for (int i = 0; i < rowOffsets.Length; i++)
            {
                Coordinates newCoordinates = new Coordinates(row + rowOffsets[i], column + colOffsets[i]);

                if (IsSquareOnBoard(newCoordinates) && (IsSquareEmpty(chessboard.Board[(int)newCoordinates.Row, (int)newCoordinates.Column]) || IsSquareOccupiedByOpponent(chessboard.Board[(int)newCoordinates.Row, (int)newCoordinates.Column], square.Piece.Color)))
                {
                    movesLShaped.Add(newCoordinates);
                }
            }
            return movesLShaped;
        }
        public static bool IsSquareEmpty(Square square)
        {
            return square.Piece == null;
        }
        public static bool IsSquareOccupiedByOpponent(Square square, GameData.Color color)
        {
            return square.Piece != null && square.Piece.Color != color;
        }
        public static bool IsSquareOccupiedByAlly(Square square, GameData.Color color)
        {
            return square.Piece != null && square.Piece.Color == color;
        }
        public static bool IsSquareOnBoard(Coordinates coordinates)
        {
            return coordinates.Row >= Chessboard.Row.One && coordinates.Row <= Chessboard.Row.Eight &&
                coordinates.Column >= Chessboard.Column.A && coordinates.Column <= Chessboard.Column.H;
        }
    }
}