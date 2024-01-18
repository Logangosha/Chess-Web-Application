using Chess_App.Classes;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static Chess_App.GameData;

namespace Chess_App.Classes
{
    public class Chessboard
    {
        public enum Column
        {
            A = 0,
            B,
            C,
            D,
            E,
            F,
            G,
            H
        }
        public enum Row
        {
            One = 0,
            Two,
            Three,
            Four,
            Five,
            Six,
            Seven,
            Eight
        }
        public Square[,] Board { get; private set; }
        public GameMode CurrentGameMode { get; set; }
        public bool IsKingCaptured { get; set; }
        public EnPassent EnPassant { get; set; }
        // Constructor
        public Chessboard(GameMode gameMode)
        {
            Board = new Square[8, 8];
            EnPassant = null;
            IsKingCaptured = false;
            CurrentGameMode = gameMode;

            // Initialize each Square
            for (int row = 0; row < 8; row++)
            {
                for (int col = 0; col < 8; col++)
                {
                    Board[row, col] = new Square((Row)row, (Column)col);
                }
            }
            Setup();
        }
        // This method is used to place a piece on a square
        public void PlacePiece(Piece piece, Row row, Column col)
        {
            if (row >= Row.One && row <= Row.Eight && col >= Column.A && col <= Column.H)
            {
                Board[(int)row, (int)col].Piece = piece;
            }
        }
        // This method is used to setup the board with the initial pieces
        public void SetupPieces(List<Piece> pieces)
        {
            // White pieces
            PlacePiece(pieces[0], Row.One, Column.A);
            PlacePiece(pieces[1], Row.One, Column.B);
            PlacePiece(pieces[2], Row.One, Column.C);
            PlacePiece(pieces[3], Row.One, Column.D);
            PlacePiece(pieces[4], Row.One, Column.E);
            PlacePiece(pieces[5], Row.One, Column.F);
            PlacePiece(pieces[6], Row.One, Column.G);
            PlacePiece(pieces[7], Row.One, Column.H);
            PlacePiece(pieces[8], Row.Two, Column.A);
            PlacePiece(pieces[9], Row.Two, Column.B);
            PlacePiece(pieces[10], Row.Two, Column.C);
            PlacePiece(pieces[11], Row.Two, Column.D);
            PlacePiece(pieces[12], Row.Two, Column.E);
            PlacePiece(pieces[13], Row.Two, Column.F);
            PlacePiece(pieces[14], Row.Two, Column.G);
            PlacePiece(pieces[15], Row.Two, Column.H);

            // Black pieces
            PlacePiece(pieces[16], Row.Eight, Column.A);
            PlacePiece(pieces[17], Row.Eight, Column.B);
            PlacePiece(pieces[18], Row.Eight, Column.C);
            PlacePiece(pieces[19], Row.Eight, Column.D);
            PlacePiece(pieces[20], Row.Eight, Column.E);
            PlacePiece(pieces[21], Row.Eight, Column.F);
            PlacePiece(pieces[22], Row.Eight, Column.G);
            PlacePiece(pieces[23], Row.Eight, Column.H);
            PlacePiece(pieces[24], Row.Seven, Column.A);
            PlacePiece(pieces[25], Row.Seven, Column.B);
            PlacePiece(pieces[26], Row.Seven, Column.C);
            PlacePiece(pieces[27], Row.Seven, Column.D);
            PlacePiece(pieces[28], Row.Seven, Column.E);
            PlacePiece(pieces[29], Row.Seven, Column.F);
            PlacePiece(pieces[30], Row.Seven, Column.G);
            PlacePiece(pieces[31], Row.Seven, Column.H);
        }
        public List<Piece> CreatePieces() {
            List<Piece> pieces = new List<Piece>() {
                new Piece(Piece.PieceType.Rook, Color.White),
                new Piece(Piece.PieceType.Knight, Color.White),
                new Piece(Piece.PieceType.Bishop, Color.White),
                new Piece(Piece.PieceType.Queen, Color.White),
                new Piece(Piece.PieceType.King, Color.White),
                new Piece(Piece.PieceType.Bishop, Color.White),
                new Piece(Piece.PieceType.Knight, Color.White),
                new Piece(Piece.PieceType.Rook, Color.White),
                new Piece(Piece.PieceType.Pawn, Color.White),
                new Piece(Piece.PieceType.Pawn, Color.White),
                new Piece(Piece.PieceType.Pawn, Color.White),
                new Piece(Piece.PieceType.Pawn, Color.White),
                new Piece(Piece.PieceType.Pawn, Color.White),
                new Piece(Piece.PieceType.Pawn, Color.White),
                new Piece(Piece.PieceType.Pawn, Color.White),
                new Piece(Piece.PieceType.Pawn, Color.White),
                new Piece(Piece.PieceType.Rook, Color.Black),
                new Piece(Piece.PieceType.Knight, Color.Black),
                new Piece(Piece.PieceType.Bishop, Color.Black),
                new Piece(Piece.PieceType.Queen, Color.Black),
                new Piece(Piece.PieceType.King, Color.Black),
                new Piece(Piece.PieceType.Bishop, Color.Black),
                new Piece(Piece.PieceType.Knight, Color.Black),
                new Piece(Piece.PieceType.Rook, Color.Black),
                new Piece(Piece.PieceType.Pawn, Color.Black),
                new Piece(Piece.PieceType.Pawn, Color.Black),
                new Piece(Piece.PieceType.Pawn, Color.Black),
                new Piece(Piece.PieceType.Pawn, Color.Black),
                new Piece(Piece.PieceType.Pawn, Color.Black),
                new Piece(Piece.PieceType.Pawn, Color.Black),
                new Piece(Piece.PieceType.Pawn, Color.Black),
                new Piece(Piece.PieceType.Pawn, Color.Black)

            };
            return pieces;

        }
        // Method to set up the initial board with pieces
        private void Setup()
        {
            SetupPieces(CreatePieces());
        }
        // Update Chessboard 
        public void UpdateChessboard(Square initialSquare, Piece pieceOnInitialSquare, Square targetSquare, int currentTurnNumber)
        {
            // check if king is on target square
            if (targetSquare.Piece != null && targetSquare.Piece.Type == Piece.PieceType.King)
                IsKingCaptured = true;

            SpecialMoveProcessing(initialSquare, pieceOnInitialSquare, targetSquare, currentTurnNumber);
            // this should toggle enpassant to null if the turn number is not the same as the current turn number
            if (EnPassant != null && EnPassant.TurnNumber != currentTurnNumber)
            {
                EnPassant = null;
            }
            // Remove piece from initial square
            initialSquare.Piece = null;
            // Place piece on target square
            targetSquare.Piece = pieceOnInitialSquare;
            // Update Squares on Board
            Board[(int)initialSquare.Row, (int)initialSquare.Column] = initialSquare;
            Board[(int)targetSquare.Row, (int)targetSquare.Column] = targetSquare;
        }
        public void SpecialMoveProcessing(Square initialSquare, Piece pieceOnInitialSquare, Square targetSquare, int currentTurnNumber)
        {
            // pawn special moves
            if (pieceOnInitialSquare.Type == Piece.PieceType.Pawn)
            {
                if (targetSquare.Row == Row.Eight || targetSquare.Row == Row.One)
                {
                    //// promote pawn
                    //PromotePawn(targetSquare, pieceOnInitialSquare);
                }

                if (initialSquare.Row + 2 == targetSquare.Row)
                {
                    Coordinates moveOnTopOfSquare = new Coordinates((Row)(initialSquare.Row + 1), (Column)Convert.ToInt32(initialSquare.Column));
                    EnPassent enPassent = new EnPassent(moveOnTopOfSquare, currentTurnNumber, pieceOnInitialSquare.Color);
                    EnPassant = enPassent;
                }
                else if (initialSquare.Row - 2 == targetSquare.Row)
                {
                    Coordinates moveOnBottomOfSquare = new Coordinates((Row)(initialSquare.Row - 1), (Column)Convert.ToInt32(initialSquare.Column));
                    EnPassent enPassent = new EnPassent(moveOnBottomOfSquare, currentTurnNumber, pieceOnInitialSquare.Color);
                    EnPassant = enPassent;
                }
                else if (EnPassant != null && targetSquare.Coordinates.CoordinateString == EnPassant.EnPassentCoordinates.CoordinateString) 
                {
                    // check to see what color the piece is
                    if (pieceOnInitialSquare.Color == Color.White)
                    {
                        // remove black pawn from board
                        Board[(int)EnPassant.EnPassentCoordinates.Row -1, (int)EnPassant.EnPassentCoordinates.Column].Piece = null;
                    }
                    else
                    {
                        // remove white pawn from board
                        Board[(int)EnPassant.EnPassentCoordinates.Row +1, (int)EnPassant.EnPassentCoordinates.Column].Piece = null;
                    }
                }
            }
            // king special moves
            if (pieceOnInitialSquare.Type == Piece.PieceType.King) 
            {
                int ColumnDifference = (int)targetSquare.Column - (int)initialSquare.Column;
                if (ColumnDifference == 2)
                {
                    if (pieceOnInitialSquare.Color == Color.White)
                    {
                        // white king castled on the king side
                        // get h1 rook
                        Piece h1 = Board[(int)Row.One, (int)Column.H].Piece;
                        Board[(int)Row.One, (int)Column.H].Piece = null;
                        // move h1 rook to f1
                        Board[(int)Row.One, (int)Column.F].Piece = h1;
                    }
                    else 
                    {
                        // black king castled on the king side
                        // get h8 rook
                        Piece h8 = Board[(int)Row.Eight, (int)Column.H].Piece;
                        Board[(int)Row.Eight, (int)Column.H].Piece = null;
                        // move h8 rook to f8
                        Board[(int)Row.Eight, (int)Column.F].Piece = h8;
                    }
                }
                else if(ColumnDifference == -2) 
                {
                    // king castled on the queen side
                    if (pieceOnInitialSquare.Color == Color.White)
                    {
                        // white king castled on the queen side
                        // get a1 rook
                        Piece a1 = Board[(int)Row.One, (int)Column.A].Piece;
                        Board[(int)Row.One, (int)Column.A].Piece = null;
                        // move a1 rook to c1
                        Board[(int)Row.One, (int)Column.D].Piece = a1;
                    }
                    else
                    {
                        // black king castled on the queen side
                        // get a8 rook
                        Piece a8 = Board[(int)Row.Eight, (int)Column.A].Piece;
                        Board[(int)Row.Eight, (int)Column.A].Piece = null;
                        // move a8 rook to c8
                        Board[(int)Row.Eight, (int)Column.D].Piece = a8;
                    }
                }
                // if the king did castle then we want to move the rook
            }
        }
    }
}
