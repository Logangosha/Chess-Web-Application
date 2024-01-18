<%@ Page Title="GamePage" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GamePage.aspx.cs" Inherits="Chess_App.GamePage" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="GamePage">
        <div class="chessboard">
            <div class="markee">
                <h1></h1>
            </div>
            <div class="board-container">
                <div class="board">
                    <div class="board-row">
                        <div class="board-square white-square a8">
                        </div>
                        <div class="board-square black-square b8">
                        </div>
                        <div class="board-square white-square c8">
                        </div>
                        <div class="board-square black-square d8">
                        </div>
                        <div class="board-square white-square e8">
                        </div>
                        <div class="board-square black-square f8">
                        </div>
                        <div class="board-square white-square g8">
                        </div>
                        <div class="board-square black-square h8">
                        </div>
                    </div>
                    <div class="board-row">
                        <div class="board-square black-square a7">
                        </div>
                        <div class="board-square white-square b7">
                        </div>
                        <div class="board-square black-square c7">
                        </div>
                        <div class="board-square white-square d7">
                        </div>
                        <div class="board-square black-square e7">
                        </div>
                        <div class="board-square white-square f7">
                        </div>
                        <div class="board-square black-square g7">
                        </div>
                        <div class="board-square white-square h7">
                        </div>
                    </div>
                    <div class="board-row">
                        <div class="board-square white-square a6"></div>
                        <div class="board-square black-square b6"></div>
                        <div class="board-square white-square c6"></div>
                        <div class="board-square black-square d6"></div>
                        <div class="board-square white-square e6"></div>
                        <div class="board-square black-square f6"></div>
                        <div class="board-square white-square g6"></div>
                        <div class="board-square black-square h6"></div>
                    </div>
                    <div class="board-row">
                        <div class="board-square black-square a5"></div>
                        <div class="board-square white-square b5"></div>
                        <div class="board-square black-square c5"></div>
                        <div class="board-square white-square d5"></div>
                        <div class="board-square black-square e5"></div>
                        <div class="board-square white-square f5"></div>
                        <div class="board-square black-square g5"></div>
                        <div class="board-square white-square h5"></div>
                    </div>
                    <div class="board-row">
                        <div class="board-square white-square a4"></div>
                        <div class="board-square black-square b4"></div>
                        <div class="board-square white-square c4"></div>
                        <div class="board-square black-square d4"></div>
                        <div class="board-square white-square e4"></div>
                        <div class="board-square black-square f4"></div>
                        <div class="board-square white-square g4"></div>
                        <div class="board-square black-square h4"></div>
                    </div>
                    <div class="board-row">
                        <div class="board-square black-square a3"></div>
                        <div class="board-square white-square b3"></div>
                        <div class="board-square black-square c3"></div>
                        <div class="board-square white-square d3"></div>
                        <div class="board-square black-square e3"></div>
                        <div class="board-square white-square f3"></div>
                        <div class="board-square black-square g3"></div>
                        <div class="board-square white-square h3"></div>
                    </div>
                    <div class="board-row">
                        <div class="board-square white-square a2">
                        </div>
                        <div class="board-square black-square b2">
                        </div>
                        <div class="board-square white-square c2">
                        </div>
                        <div class="board-square black-square d2">
                        </div>
                        <div class="board-square white-square e2">
                        </div>
                        <div class="board-square black-square f2">
                        </div>
                        <div class="board-square white-square g2">
                        </div>
                        <div class="board-square black-square h2">
                        </div>
                    </div>
                    <div class="board-row">
                        <div class="board-square black-square a1">
                        </div>
                        <div class="board-square white-square b1">
                        </div>
                        <div class="board-square black-square c1">
                        </div>
                        <div class="board-square white-square d1">
                        </div>
                        <div class="board-square black-square e1">
                        </div>
                        <div class="board-square white-square f1">
                        </div>
                        <div class="board-square black-square g1">
                        </div>
                        <div class="board-square white-square h1">
                        </div>
                    </div>
                </div>

            </div>
            
            <div class="board-controls">
                <button class="Btn Btn-primary Btn-icon" onclick="FlipBoard()" type="button"><i class="fa-solid fa-arrows-rotate"></i></button>
                <button class="Btn Btn-primary Btn-icon" id="ResignModalBtn" type="button" data-bs-toggle="modal" data-bs-target="#ResignModal"><i class="fa-solid fa-flag"></i></button>
                <asp:Linkbutton runat="server" ID="GoHomeBtn" OnClick="GoHomeBtn_Click" type="button" class="Btn Btn-primary Btn-icon Btn-home d-none">
                    <p class="home-text">Go Home</p>
                    <%--<i class="fa-solid fa-home home-icon"></i>--%>
                </asp:Linkbutton>
                <asp:Linkbutton runat="server" ID="PlayAgainBtn" OnClick="PlayAgainBtn_Click" type="button" class="Btn Btn-secondary Btn-icon Btn-play d-none">
                    <p class="play-text">Play Again</p>
                    <%--<i class="fa-solid fa-play play-icon"></i>--%>
                </asp:Linkbutton>
            </div>
        </div>
        <div class="game-details">
            <div class="players">
                <div id="playerOnePieces" class="player">
                    <div class="piece wk"></div>
                    <div class="piece"></div>
                    <div class="piece"></div>
                    <div class="piece"></div>
                    <div class="piece"></div>
                    <div class="piece"></div>
                    <div class="piece"></div>
                    <div class="piece"></div>
                    <div class="piece"></div>
                    <div class="piece"></div>
                    <div class="piece"></div>
                    <div class="piece"></div>
                    <div class="piece"></div>
                    <div class="piece"></div>
                    <div class="piece"></div>
                    <div class="piece"></div>
                    <div class="piece"></div>
                    <div class="piece"></div>
                    <div class="piece"></div>
                    <div class="piece"></div>
                    <div class="piece"></div>
                </div>
                <div id="playerTwoPieces" class="player">
                    <div class="piece bk"></div>
                     <div class="piece"></div>
                    <div class="piece"></div>
                    <div class="piece"></div>
                    <div class="piece"></div>
                    <div class="piece"></div>
                    <div class="piece"></div>
                    <div class="piece"></div>
                    <div class="piece"></div>
                    <div class="piece"></div>
                    <div class="piece"></div>
                    <div class="piece"></div>
                    <div class="piece"></div>
                    <div class="piece"></div>
                    <div class="piece"></div>
                    <div class="piece"></div>
                    <div class="piece"></div>
                    <div class="piece"></div>
                    <div class="piece"></div>
                    <div class="piece"></div>
                    <div class="piece"></div>
                </div>
            </div>
            <div class="move-history">
                <div class="turn-moves">
                    <p class="turn">1.</p>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="ResignModal" tabindex="-1" aria-labelledby="ResignModal" aria-hidden="true">
        <div class="modal-dialog  modal-fullscreen">
            <div class="modal-content">
                <div class="modal-head">
                    <i class="fa-solid fa-warning modal-icon my-auto"></i>
                    <h1 class="modal-title">Resign
                    </h1>
                    <button type="button" class="Btn Btn-secondary modal-close pe-0" data-bs-dismiss="modal"><i class="fa-solid fa-xmark"></i></button>
                </div>
                <hr />
                <div class="modal-body my-auto gap-2">
                    <span class="modal-icon fa fa-warning"></span>
                    <h1 class="modal-heading">DO YOU WISH TO RESIGN?</h1>
                    <h2 class="modal-subheading">Resignation cannot be undone</h2>
                </div>
                <hr />
                <div class="modal-footer">
                    <button type="button" class="Btn Btn-secondary ps-0" data-bs-dismiss="modal">Cancle</button>
                    <button ID="ResignBtn" type="button" onclick="Resign()" class="Btn Btn-primary ms-auto">Resign</button>
                </div>
            </div>
        </div>
    </div>
    <script>
        const pieces = document.querySelectorAll('.piece');
        const boardSquares = document.querySelectorAll('.board-square');
        const chessboard = document.querySelector('.board');
        let chessboardData = chessboardDataJson;
        let playerData = playerDataJson;
        let currentValidMoves = currentValidMovesJson;
        let turnHandler = turnHandlerJson;
        let currentGameState = currentGameStateJson;
        let moveHistory = moveHistoryJson;
        chessboardDataJson = null;
        playerDataJson = null;
        currentValidMovesJson = null;
        turnHandlerJson = null;
        currentGameStateJson = null;
        moveHistoryJson = null;
        let currentHighlightedSquares = [];
        let currentPlayerColor = turnHandler.CurrentColorTurn;
        let currentColorTurn = turnHandler.CurrentColorTurn;
        let selectedSquare = null;
        let selectedPiece = null;
        let moveType = "normal";
        let lastMove = null;
        let lastPieceCaptured = null;
        let isPawnPromoting = false;
        let isKingCaptured = false;
        var markeeElement = document.querySelector(".markee");
        var statusMsg = markeeElement.querySelector("h1");

        console.table(chessboardData);

        function Resign() {
            // update markee
            let playerWhoWon = (currentPlayerColor == 0 ? "Black" : "White");
            let playerWhoResigned = (currentPlayerColor == 0 ? "White" : "Black");
            statusMsg.innerHTML = playerWhoResigned + " resigned! " + playerWhoWon + " Wins!";

            // send resign request to server ajax
            $.ajax({
                type: "POST",
                url: "GamePage.aspx/Resign",
                data: JSON.stringify({ markee: statusMsg.textContent }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    // hide resign modal
                    $('#ResignModal').modal('hide');
                    Gameover();
                },
                error: function (response) {
                }
            });
        };


        // add event handler for each piece 
        boardSquares.forEach((square) => {
            square.addEventListener("click", SquareClick);
        });

        // add event handler for maximize button
        //document.getElementById("maximizeBoardBtn").addEventListener("click", MaximizeBoard);
        window.onresize = function () {
            MaximizeBoard();
            MaximizeBoard();
        };

        // Call MaximizeBoard initially to set the dimensions when the page loads
        MaximizeBoard();

        // on page load read chessboardData and set the board
        window.onload = function () {
            // set the board
            SetBoard();
            // set the markee
            SetMarkee();
            // set move history
            SetMoveHistory();
            console.log("current game state is: " + currentGameState);
            if (currentGameState)
            {
                Gameover();
            }
        }

        function SetMoveHistory() {
            // go into moveHistory and for each move
            let moveHistoryContainer = document.querySelector('.move-history');
            let lastChild = moveHistoryContainer.children[0];
            for (let i = 0; i < moveHistory.Moves.length; i++)
            {
                let notation = moveHistory.Moves[i].Notation;
                // check if move is black or white
                // if white
                if (moveHistory.Moves[i].Color == 0) {
                    // create p with move
                    let whiteMoveParagraph = document.createElement('p');
                    whiteMoveParagraph.className = 'white-move';
                    whiteMoveParagraph.textContent = moveHistory.Moves[i].Notation;
                    
                    if (notation.includes('x'))
                    {
                        let indexOfX = notation.indexOf('x');
                        let pieceCaptured = (notation.charAt(indexOfX + 1)).toLowerCase();
                        // add piece captured to whites captured pieces
                        AddCapturedPieceToCapturedPieces(pieceCaptured, 0);
                    }

                    // add p to the last child of moveHistoryContainer
                    lastChild.appendChild(whiteMoveParagraph);
                }
                // if black
                else if (moveHistory.Moves[i].Color == 1) {
                    // create p with move
                    let blackMoveParagraph = document.createElement('p');
                    blackMoveParagraph.className = 'black-move';
                    blackMoveParagraph.textContent = moveHistory.Moves[i].Notation;

                    if (notation.includes('x')) {
                        let indexOfX = notation.indexOf('x');
                        let pieceCaptured = (notation.charAt(indexOfX + 1)).toLowerCase();
                        // add piece captured to whites captured pieces
                        AddCapturedPieceToCapturedPieces(pieceCaptured, 1);
                    }

                    // add p to the last child of moveHistoryContainer
                    lastChild.appendChild(blackMoveParagraph);

                    // Code to create a new row for the next turn
                    let newTurnMovesContainer = document.createElement('div');
                    newTurnMovesContainer.className = 'turn-moves';
                    let turnNumber = document.createElement('p');
                    turnNumber.className = 'turn';
                    turnNumber.textContent = (2 + (Math.floor(i / 2))) + ".";
                    newTurnMovesContainer.appendChild(turnNumber);

                    // Append the new container to the move history
                    moveHistoryContainer.appendChild(newTurnMovesContainer);
                    lastChild = moveHistoryContainer.children[1+(Math.floor(i / 2))];
                }
            }
        }

        function FlipBoard()
        {
            let board = document.querySelector(".board");

            if (board.style.flexDirection == "column") {
                board.style.flexDirection = "column-reverse";
            }
            else
            {
                board.style.flexDirection = "column";
            }
        }

        function showGoHomeAndPlayAgain() {
            // Hide the resign button
            document.querySelector('#ResignModalBtn').style.display = 'none';

            // Show the go home and play again buttons
            document.querySelector('#<%= GoHomeBtn.ClientID %>').classList.remove('d-none');
            document.querySelector('#<%= PlayAgainBtn.ClientID %>').classList.remove('d-none');
        }
        

        function Gameover()
        {
            // remove click event for each square
            document.querySelector('.GamePage > .chessboard > .board-container > .board').style.cursor = "not-allowed";
            boardSquares.forEach((square) => {
                square.removeEventListener("click", SquareClick);
            });
            // make resign btn invisible
            // display go home and play again btns
            showGoHomeAndPlayAgain();

        }

        // 0 is white, 1 is black
        function AddCapturedPieceToCapturedPieces(pieceCaptured, color)
        {
            let isWhite = color == 0 ? true : false;
            if (isWhite)
            {
                // go into playerOnePieces and find
                let playerOneElements = document.getElementById("playerOnePieces").children;
                for (var i = 0; i < playerOneElements.length; i++) {
                    if (playerOneElements[i].classList.length == 2) {
                        // Skip elements with only one class
                    } else {
                        playerOneElements[i].classList.add("b" + pieceCaptured);
                        break;
                    }
                }
            }
            else
            {
                let playerTwoElements = document.getElementById("playerTwoPieces").children;

                for (var i = 0; i < playerTwoElements.length; i++) {
                    if (playerTwoElements[i].classList.length == 2) {
                        // Skip elements with only one class
                    } else {
                        playerTwoElements[i].classList.add("w" + pieceCaptured);
                        break;
                    }
                }
            }
        }

        function SetMarkee()
        {
            statusMsg.textContent = turnHandler.Markee;
        }

        function MaximizeBoard()
        {
            // get hight and width of chessboard
            let board = document.getElementsByClassName('board')[0];

            // get hight and width of board container
            let boardContainer = document.getElementsByClassName('chessboard')[0]; 
            let boardContainerHeight = boardContainer.offsetHeight;
            let boardContainerWidth = boardContainer.offsetWidth;

            // now we need to subtract the markee height and the board controls height from the chessboard height
            let newBoardContainerHeight = boardContainerHeight - document.getElementsByClassName('markee')[0].offsetHeight - document.getElementsByClassName('board-controls')[0].offsetHeight;

            // now we need to determine if the board-container height or width is larger
            let boardContainerHeightIsLargetThanWidth = newBoardContainerHeight > boardContainerWidth;

            if (boardContainerHeightIsLargetThanWidth)
            {
                // if the board-container height is larger than the width than we need to set the height of the board to the width of the board container
                // and the width of the board to the width of the board container
                // set the height of the board to the width of the board container
                board.style.height = `${boardContainerWidth}px`;
                // set the width of the board to the width of the board container
                board.style.width = `${boardContainerWidth}px`;
            }
            else
            {
                // if the board-container width is larger than the height than we need to set the height of the board to the height of the board container
                // and the width of the board to the height of the board container
                // set the height of the board to the height of the board container
                board.style.height = `${newBoardContainerHeight}px`;
                // set the width of the board to the height of the board container
                board.style.width = `${newBoardContainerHeight}px`;
            }

        }

        // Set the board based on the chessboardData
        function SetBoard() {
            // loop through chessboardData.Board column
            for (let i = 0; i < chessboardData.Board.length; i++) {
                // loop through each row
                for (let j = 0; j < chessboardData.Board[i].length; j++) {
                    // check to see if there is a piece at the current location
                    if (chessboardData.Board[i][j].Piece != null) {
                        // there is a piece at the current location
                        // get the piece
                        let piece = chessboardData.Board[i][j].Piece;
                        // get the row anc column of the piece
                        let row = CovertIndexToRowNumber(i);
                        let column = ConvertIndexToColumnCharacter(j)

                        // select the board.square class that matches the row and column
                        let square = document.querySelector(`.${column}${row}`);
                        // create a new div element with the class of piece and type of the piece
                        let newPiece = document.createElement("div");
                        newPiece.classList.add("piece");
                        newPiece.classList.add(ConvertPieceTypeAndColorToAbreviation(piece.Color, piece.Type));
                        // append the new piece to the square
                        square.appendChild(newPiece);
                    }
                }
            }
            updateBoardDirection();
        }

        function updateBoardDirection() {
            let board = document.querySelector(".board");

            switch (currentPlayerColor) {
                case 0:
                    board.style.flexDirection = "column";
                    break;
                case 1:
                    board.style.flexDirection = "column-reverse";
                    break;
                default:
                    break;
            }
        }

        function ConvertNumberToColor(number) {
            return (number ? "Black" : "White");
        }

        function ConvertStringRowCharacterToStringRowWord(stringRowCharacter) {
            switch (stringRowCharacter) {
                case '1':
                    result = "One";
                    break;
                case '2':
                    result = "Two";
                    break;
                case '3':
                    result = "Three";
                    break;
                case '4':
                    result = "Four";
                    break;
                case '5':
                    result = "Five";
                    break;
                case '6':
                    result = "Six";
                    break;
                case '7':
                    result = "Seven";
                    break;
                case '8':
                    result = "Eight";
                    break;
                default:
                    result = "Invalid input";
                    break;
            }
            return result;
        }

        function ConvertIndexToColumnCharacter(index) {
            switch (index) {
                case 0:
                    return "a";
                case 1:
                    return "b";
                case 2:
                    return "c";
                case 3:
                    return "d";
                case 4:
                    return "e";
                case 5:
                    return "f";
                case 6:
                    return "g";
                case 7:
                    return "h";
            }
        }

        function ConvertColumnCharacterToIndex(character) {
            switch (character.toLowerCase()) {
                case 'a':
                    return 0;
                case 'b':
                    return 1;
                case 'c':
                    return 2;
                case 'd':
                    return 3;
                case 'e':
                    return 4;
                case 'f':
                    return 5;
                case 'g':
                    return 6;
                case 'h':
                    return 7;
                default:
                    throw new Error('Invalid column character');
            }
        }

        function CovertIndexToRowNumber(index) {
            switch (index) {
                case 0:
                    return 1;
                case 1:
                    return 2;
                case 2:
                    return 3;
                case 3:
                    return 4;
                case 4:
                    return 5;
                case 5:
                    return 6;
                case 6:
                    return 7;
                case 7:
                    return 8;
            }
        }

        function ConvertRowNumberCharacterToIndex(rowNumber) {
            switch (rowNumber) {
                case '1':
                    return 0;
                case '2':
                    return 1;
                case '3':
                    return 2;
                case '4':
                    return 3;
                case '5':
                    return 4;
                case '6':
                    return 5;
                case '7':
                    return 6;
                case '8':
                    return 7;
                default:
                    throw new Error("Invalid row number");
            }
        }

        function ConvertPieceTypeAndColorToAbreviation(pieceColor, pieceType) {
            if (pieceColor == 0) {
                switch (pieceType) {
                    case 0:
                        return "wp";
                    case 1:
                        return "wr";
                    case 2:
                        return "wn";
                    case 3:
                        return "wb";
                    case 4:
                        return "wq";
                    case 5:
                        return "wk";
                }
            }
            else if (pieceColor == 1) {
                switch (pieceType) {
                    case 0:
                        return "bp";
                    case 1:
                        return "br";
                    case 2:
                        return "bn";
                    case 3:
                        return "bb";
                    case 4:
                        return "bq";
                    case 5:
                        return "bk";
                }
            }
        }

        function SquareClick(event) {

            // Check if a square is already selected
            if (selectedSquare) {
                if (selectedPiece) {
                    // A piece is currently selected
                    if (IsMoveValid(selectedPiece, event.target)) {
                        MovePieceToTarget(selectedPiece, event.target);
                        // Unselect the piece and square regardless of move validity
                        UnselectSquareAndPiece();
                        RemoveHighlightSquares();
                    } else {
                        // move not valid
                        RemoveHighlightSquares();
                        HandlePieceSelection(event);
                    }
                }
            } else {
                // No square is selected
                HandlePieceSelection(event);
            }
        }

        function HandlePieceSelection(event) {
            // target is a piece
            if (IsTargetAPiece(event.target)) {
                if ((event.target.classList[1])[0] == ConvertNumberToColor(currentPlayerColor)[0].toLowerCase())
                    SelectPiece(event.target);
            }
            else {
                // target is not a piece
                UnselectSquareAndPiece();
            }
        }

        function SelectPiece(piece) {
            selectedPiece = piece;
            selectedSquare = piece.parentElement;
            HighlightSquare(selectedSquare);
            HighlightValidMoves(selectedPiece);
        }

        function UnselectSquareAndPiece() {
            selectedPiece = null;
            selectedSquare = null;
        }

        function HighlightValidMoves(selectedPiece) {
            let validMovesForPiece = GetValidMovesForPiece(selectedPiece);
            let validMoveRow = null;
            let validMoveCol = null;
            let validCoordinate = null;
            let square = null;
            if (validMovesForPiece.length > 0) {
                // piece has valid moves
                for (let i = 0; i < validMovesForPiece.length; i++) {
                    validMoveRow = CovertIndexToRowNumber(validMovesForPiece[i].Row);
                    validMoveCol = ConvertIndexToColumnCharacter(validMovesForPiece[i].Column);
                    validCoordinate = "." + validMoveCol.toString() + validMoveRow.toString();
                    square = document.querySelector(validCoordinate);
                    HighlightSquare(square);
                }
            }
            else {
                // piece has no valid moves
            }
        }

        function HighlightSquare(square) {
            square.classList.add("highlighted-square");
            currentHighlightedSquares.push(square);
        }

        function RemoveHighlightSquares() {
            currentHighlightedSquares.forEach(square => {
                square.classList.remove("highlighted-square");
            });
            currentHighlightedSquares = [];
        }

        function GetValidMovesForPiece(selectedPieceElement) {

            let validMoves = []; // Create an empty array to store valid move coordinates

            // Get the coordinates of the selected piece
            let coordinatesOfSelectedPiece = GetCoordinates(selectedPieceElement);

            // Get row and column of the piece
            let pieceColumn = ConvertColumnCharacterToIndex(coordinatesOfSelectedPiece[0]);
            let pieceRow = ConvertRowNumberCharacterToIndex(coordinatesOfSelectedPiece[1]);

            // Check if the piece has any valid moves in currentValidMoves
            for (let i = 0; i < currentValidMoves.length; i++) {
                let moveRow = currentValidMoves[i].PieceCoordinates.Row;    // Access the row
                let moveColumn = currentValidMoves[i].PieceCoordinates.Column; // Access the column
                if (moveRow === pieceRow && moveColumn === pieceColumn) {
                    // Loop through each PossibleMoveCoordinates and add them to validMoves
                    for (let j = 0; j < currentValidMoves[i].PossibleMoveCoordinates.length; j++) {
                        let possibleMove = currentValidMoves[i].PossibleMoveCoordinates[j];
                        validMoves.push(possibleMove);
                    }
                    return validMoves;
                }
            }

            return validMoves;
        }

        function MovePieceToTarget(piece, target) {

            // get row and column of piece square
            let coordinatesOfInitialSquare = GetCoordinates(piece.parentElement);
            let coordinatesOfTargetSquare = null;
            let isTargetAPiece = IsTargetAPiece(target);

            // special move!
            // if the piece is a pawn and the target square is on the 1st or 8th row
            isPawnPromoting = false;
            if (selectedPiece.classList[1][1] == 'p') {
                let targetSquareCoordinates = GetCoordinates(event.target);
                if (targetSquareCoordinates[1] == '1') {
                    selectedPiece.classList = "piece bq";
                    moveType = "Pawn Promotion";
                    isPawnPromoting = true;
                }
                else if (targetSquareCoordinates[1] == '8') {
                    selectedPiece.classList = "piece wq";
                    moveType = "Pawn Promotion";
                    isPawnPromoting = true;
                }
                
            }

            if (isTargetAPiece) // target is a piece
            {
                // get row and column of target.partent square
                coordinatesOfTargetSquare = GetCoordinates(target.parentElement);

                // Get the second class of the target
                let targetClasses = target.classList;
                let secondClassOfTarget = targetClasses[1];
                lastPieceCaptured = (secondClassOfTarget[1] == 'p' ? 'p' : secondClassOfTarget[1].toUpperCase());

                // Get the second class of the 'piece' element
                let typeOfPiece = piece.classList[1];

                // so we have a playerOnePiece and a playerTwoPiece
                // if a player captures a piece, the captured piece is added to the captured pieces list of the player
                // ex if white caputes black, the black piece is added to the white player's captured pieces list
                // we want to add the value of typeOfPiece to the class list of the current players captured pieces list

                if (currentPlayerColor) {
                    // Black player Two
                    // Loop through playerTwoPieces and add the class to the first element without the class
                    let playerTwoElements = document.getElementById("playerTwoPieces").children;
                    for (var i = 0; i < playerTwoElements.length; i++) {
                        if (playerTwoElements[i].classList.length == 2) {
                            // Skip elements with only one class
                        } else {
                            playerTwoElements[i].classList.add(secondClassOfTarget);
                            break;
                        }
                    }
                } else {
                    // White player one
                    // Loop through playerOnePieces and add the class to the first element without the class
                    let playerOneElements = document.getElementById("playerOnePieces").children;
                    for (var i = 0; i < playerOneElements.length; i++) {
                        if (playerOneElements[i].classList.length == 2) {
                            // Skip elements with only one class
                        } else {
                            playerOneElements[i].classList.add(secondClassOfTarget);
                            break;
                        }
                    }
                }

                // if target is king
                if (target.classList[1][1] == "k")
                {
                    isKingCaptured = true;
                }

                // Remove the second class from the 'targetClasses' and remove piece element
                targetClasses.remove(secondClassOfTarget);
                piece.remove();

                // Set the second class of the target to the second class of the 'piece'
                targetClasses.add(typeOfPiece);

                // update the chessboard data
                PlayerMoveEvent(coordinatesOfInitialSquare, piece.classList[1], coordinatesOfTargetSquare, target);
            }
            else // target is a square
            {
                // get row and column of target square
                coordinatesOfTargetSquare = GetCoordinates(target);

                SpecialMoveProcessing(piece, coordinatesOfTargetSquare);
                //create new div
                let newPiece = document.createElement("div");
                newPiece.classList.add("piece");
                newPiece.classList.add(piece.classList[1]);

                // add new div to target
                target.appendChild(newPiece);

                // remove piece element
                piece.remove();

                // update the chessboard data
                PlayerMoveEvent(coordinatesOfInitialSquare, piece.classList[1], coordinatesOfTargetSquare, target);
            }
        }

        function SpecialMoveProcessing(piece, coordinatesOfTargetSquare) {
            let pieceType = piece.classList[1][1];
            let isWhite = piece.classList[1][0] == "w" ? true : false;
            // en passant and castling
            if (pieceType == 'p') {
                if (IsMoveEnPassent(coordinatesOfTargetSquare)) {
                    moveType = "En Passant";
                    // get column and row of targetSquare
                    let columnOfSquareBelowTarget = coordinatesOfTargetSquare[0];
                    let rowOfSquareBelowTarget = parseInt(coordinatesOfTargetSquare[1]);
                    let squareBelowTarget = null;

                    // check color of piece
                    if (isWhite) {
                        // get square below target
                        squareBelowTarget = document.querySelector("." + columnOfSquareBelowTarget + (rowOfSquareBelowTarget - 1).toString());
                    }
                    else {
                        // get square above target
                        squareBelowTarget = document.querySelector("." + columnOfSquareBelowTarget + (rowOfSquareBelowTarget + 1).toString());
                    }
                    squareBelowTarget.innerHTML = ''; // This clears all the child elements inside the div
                }
            }
            else if (pieceType == 'k') {
                let difference = parseInt(ConvertColumnCharacterToIndex(coordinatesOfTargetSquare[0])) - parseInt(ConvertColumnCharacterToIndex(GetCoordinates(piece)[0]));
                if (difference != 2 && difference != -2) {
                    return;
                }
                var rookSquare;
                var rookPiece;
                if (difference == 2) {
                    moveType = "Castles Kingside";
                    if (isWhite) {
                        // get h1 square and piece
                        rookSquare = document.querySelector(".h1")
                        rookPiece = rookSquare.children[0];

                        // get target square and add h1 piece
                        let targetSquare = document.querySelector(".f1")
                        targetSquare.append(rookPiece);

                        // remove rookPiece from rookSquare
                        rookSquare.innerHTML = '';
                    }
                    else {

                        // get h8 square and piece
                        rookSquare = document.querySelector(".h8")
                        rookPiece = rookSquare.children[0];

                        // get target square and add h8 piece
                        let targetSquare = document.querySelector(".f8")
                        targetSquare.append(rookPiece);

                        // remove rookPiece from rookSquare
                        rookSquare.innerHTML = '';
                    }
                }
                else {
                    moveType = "Castles Queenside";
                    if (isWhite) {
                        // get a1 square and piece
                        rookSquare = document.querySelector(".a1")
                        rookPiece = rookSquare.children[0];

                        // get target square and add a1 piece
                        let targetSquare = document.querySelector(".d1")
                        targetSquare.append(rookPiece);

                        // remove rookPiece from rookSquare
                        rookSquare.innerHTML = '';
                    }
                    else {
                        // get a8 square and piece
                        rookSquare = document.querySelector(".a8")
                        rookPiece = rookSquare.children[0];

                        // get target square and add d8 piece
                        let targetSquare = document.querySelector(".d8")
                        targetSquare.append(rookPiece);

                        // remove rookPiece from rookSquare
                        rookSquare.innerHTML = '';
                    }
                }
            }
            return;
        }

        function IsMoveEnPassent(coordinatesOfTargetSquare) {

            if (chessboardData.EnPassant != null) {
                let targetCoordinateString = coordinatesOfTargetSquare[0].toLowerCase() + ConvertStringRowCharacterToStringRowWord(coordinatesOfTargetSquare.slice(1));
                if (chessboardData.EnPassant.EnPassentCoordinates.CoordinateString.toLowerCase() == targetCoordinateString.toLowerCase()) {
                    return true;
                }
            }
            return false;
        }

        function PlayerMoveEvent(coordinatesOfInitialSquare, pieceAbreviationOnInitialSquare, coordinatesOfTargetSquare, target) {
            updateMoveHistory(coordinatesOfInitialSquare, pieceAbreviationOnInitialSquare, coordinatesOfTargetSquare, target);
            updateMarkee(target);
            // make ajax call to the server using
            $.ajax({
                type: "POST",
                url: "GamePage.aspx/PlayerMoveEvent",
                data: JSON.stringify({ coordinatesOfInitialSquare: coordinatesOfInitialSquare, pieceAbreviationOnInitialSquare: pieceAbreviationOnInitialSquare, coordinatesOfTargetSquare: coordinatesOfTargetSquare, markee: statusMsg.textContent, moveNotation: lastMove }),
                contentType: "application/json; charset=utf-8", // Set the correct content type
                dataType: "json", // Expect JSON as the response from the server
                async: false,
                success: function (response) {
                    // Parse the response JSON
                    var parsedResponse = response.d;

                    // Access the objects within the response
                    turnHandler = parsedResponse.TurnHandler;
                    chessboardData = parsedResponse.Chessboard;
                    currentValidMoves = parsedResponse.PossibleMoves;
                    currentGameState = parsedResponse.CurrentGameState;
                    moveHistory = parsedResponse.MoveHistory;
                    if (isKingCaptured) {
                        Gameover();
                    }
                    else
                    {
                        swapTurns();
                    }
                },
                error: function (data) {
                }
            });
        }

        function IsMoveValid(piece, destination) {
            // get coordinates of both piece and destination
            pieceCoordinates = GetCoordinates(piece);
            destinationCoordinates = GetCoordinates(destination);
            if (pieceCoordinates == destinationCoordinates) {
                return false;
            }
            // check if destination coordinates match a currentHighlightedSquare in currentHighlightedSquares
            for (let i = 0; i < currentHighlightedSquares.length; i++) {
                if (currentHighlightedSquares[i].classList[2] == destinationCoordinates) {
                    return true;
                }
            }
            return false;
        }

        function IsTargetAPiece(target) {
            if (target.classList[0] == "piece") // target is a piece
            {
                return true;
            }
            else // target is not a piece
            {
                return false;
            }
        }

        function GetCoordinates(target) {
            if (IsTargetAPiece(target)) {
                // target is a piece
                return (target.parentElement).classList[2];
            }
            else {
                // target is a square
                return target.classList[2];
            }
        }

        function IsCurrentPlayerTurn() {
            return (currentPlayerColor == turnHandler.CurrentColorTurn);
        }

        function swapTurns() {
            currentPlayerColor = turnHandler.CurrentColorTurn;
            updateBoardDirection();
        }

        function updateMoveHistory(coordinatesOfInitialSquare, pieceAbreviationOnInitialSquare, coordinatesOfTargetSquare, target) {
            let isWhite = pieceAbreviationOnInitialSquare[0] == "w" ? true : false;
            let move = "";
            // what piece moved 
            let pieceMoved = pieceAbreviationOnInitialSquare[1];

            // this is weird case because when pawn promotes its not a p anymore its a q
            if (isPawnPromoting)
                pieceMoved = "p"; 
            switch (pieceMoved)
            {
                case "p":
                    // check if target is a piece
                    if (IsTargetAPiece(target))
                    {
                        move += coordinatesOfInitialSquare[0] + "x" + lastPieceCaptured + coordinatesOfTargetSquare;
                        if (moveType == "Pawn Promotion")
                        {
                            move += "=Q";
                        }
                    }
                    else
                    {
                        if (moveType == "En Passant") {
                            // get column and row of targetSquare
                            let columnOfSquareBelowTarget = coordinatesOfTargetSquare[0];
                            let rowOfSquareBelowTarget = parseInt(coordinatesOfTargetSquare[1]);
                            let squareBelowTarget = null;

                            // check color of piece
                            if (isWhite) {
                                // get square below target
                                squareBelowTarget = document.querySelector("." + columnOfSquareBelowTarget + (rowOfSquareBelowTarget - 1).toString());
                            }
                            else {
                                // get square above target
                                squareBelowTarget = document.querySelector("." + columnOfSquareBelowTarget + (rowOfSquareBelowTarget + 1).toString());
                            }
                            move += coordinatesOfInitialSquare[0] + "x" + GetCoordinates(squareBelowTarget) + "ep";

                        }
                        else
                        {
                            move += coordinatesOfTargetSquare;
                            if (moveType == "Pawn Promotion")
                            {
                                move += "=Q";
                            }
                        }
                    }
                    break;
                case "n":
                case "b":
                case "r":
                case "q":
                case "k":
                    move += pieceMoved.toUpperCase();
                    if (IsTargetAPiece(target)) {
                        move += "x" + lastPieceCaptured + coordinatesOfTargetSquare;
                    }
                    else {
                        move += coordinatesOfTargetSquare;
                    }
                    break;
            }
            if (currentGameState == 1) {
                move += "#";
            }

            let moveHistoryContainer = document.querySelector('.move-history');
            let children = moveHistoryContainer.children;

            // Using a for loop to get the last child
            let lastChild;
            for (let i = 0; i < children.length; i++) {
                if (children[i].nodeType === 1) {
                    lastChild = children[i];
                }
            }

            if (isWhite)
            {
                // Code to add the move to the current row
                let whiteMoveParagraph = document.createElement('p');
                whiteMoveParagraph.className = 'white-move';
                whiteMoveParagraph.textContent = move;
                lastChild.appendChild(whiteMoveParagraph);
            }
            else
            {
                // Code to add the move to the current row
                let blackMoveParagraph = document.createElement('p');
                blackMoveParagraph.className = 'black-move';
                blackMoveParagraph.textContent = move;
                lastChild.appendChild(blackMoveParagraph);

                // Code to create a new row for the next turn
                let newTurnMovesContainer = document.createElement('div');
                newTurnMovesContainer.className = 'turn-moves';
                let turnNumber = document.createElement('p');
                turnNumber.className = 'turn';
                turnNumber.textContent = (turnHandler.CurrentTurn + 1) + ".";
                newTurnMovesContainer.appendChild(turnNumber);

                // Append the new container to the move history
                moveHistoryContainer.appendChild(newTurnMovesContainer);

            }
            lastMove = move;
        }

        function updateMarkee(target) {
            var markeeText = "";
            var currentColor = ConvertNumberToColor((turnHandler.CurrentColorTurn) ? 0 : 1);
            var priorColor = currentColor == "White" ? "Black" : "White";

            if (moveType == "normal") {}
            else if (moveType == "En Passant") {
                markeeText += priorColor + " captures en passant! ";
            }
            else if (moveType == "Castles Kingside") {
                markeeText += priorColor + " castles kingside! ";
            }
            else if (moveType == "Castles Queenside") {
                markeeText += priorColor + " castles queenside! ";
            }
            else if (moveType == "Pawn Promotion") {
                markeeText += priorColor + " pawn promotes! ";
            }

            // check if target is a piece
            if (IsTargetAPiece(target) && moveType != "En Passant") {
                if (moveType == "Pawn Promotion") {
                    markeeText = priorColor + " Captures! " + markeeText;
                }
                else 
                markeeText += priorColor + " Captures! ";
            }

            if (isKingCaptured) {
                markeeText += " Checkmate! " + priorColor + " wins! ";
            }
            else
            {
                markeeText += currentColor + " to move. ";
            }

            statusMsg.innerHTML = markeeText;
            moveType = "normal";
        }
    </script>
</asp:Content>

