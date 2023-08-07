<%@ Page Title="GamePage" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GamePage.aspx.cs" Inherits="Chess_App.GamePage" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="GamePage">
        <div class="chessboard">
            <div class="board-navbar">
                <%--<img class="profile-img" src="Images/twomenplayingchessdarkroom.jpg" />--%>
                <div class="status-container">
                    <%--<h1 class="status">Choblo's Turn</h1>
                    <img class="status-gif d-none" src="Images/loading.gif" />--%>
                </div>
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
                <button class="Btn Btn-secondary Btn-icon"><i class="fa-solid fa-chevron-left"></i></button>
                <button class="Btn Btn-secondary Btn-icon"><i class="fa-solid fa-handshake"></i></button>
                <button class="Btn Btn-secondary Btn-icon"><i class="fa-solid fa-flag"></i></button>
                <button class="Btn Btn-secondary Btn-icon"><i class="fa-solid fa-chevron-right"></i></button>
            </div>
        </div>
        <div class="game-details">
            <div class="players">
                <div class="player">
                    <img runat="server" id="PlayerOneImg" class="profile-img" src="Images/twomenplayingchessdarkroom.jpg" />
                </div>
                <div class="player">
                    <img runat="server" id="PlayerTwoImg" class="profile-img" src="Images/whitehandmovingchesspiece.jpg" />
                </div>
            </div>
            <div class="move-history">
                <div class="turn-moves">
                    <p class="turn">1</p>
                    <p class="white-move">a1</p>
                    <p class="black-move">b2</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">2</p>
                    <p class="white-move">a4</p>
                    <p class="black-move">b5</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">3</p>
                    <p class="white-move">a6</p>
                    <p class="black-move">b6</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">1</p>
                    <p class="white-move">a1</p>
                    <p class="black-move">b2</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">2</p>
                    <p class="white-move">a4</p>
                    <p class="black-move">b5</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">3</p>
                    <p class="white-move">a6</p>
                    <p class="black-move">b6</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">1</p>
                    <p class="white-move">a1</p>
                    <p class="black-move">b2</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">2</p>
                    <p class="white-move">a4</p>
                    <p class="black-move">b5</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">3</p>
                    <p class="white-move">a6</p>
                    <p class="black-move">b6</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">1</p>
                    <p class="white-move">a1</p>
                    <p class="black-move">b2</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">2</p>
                    <p class="white-move">a4</p>
                    <p class="black-move">b5</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">3</p>
                    <p class="white-move">a6</p>
                    <p class="black-move">b6</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">1</p>
                    <p class="white-move">a1</p>
                    <p class="black-move">b2</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">2</p>
                    <p class="white-move">a4</p>
                    <p class="black-move">b5</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">3</p>
                    <p class="white-move">a6</p>
                    <p class="black-move">b6</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">1</p>
                    <p class="white-move">a1</p>
                    <p class="black-move">b2</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">2</p>
                    <p class="white-move">a4</p>
                    <p class="black-move">b5</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">3</p>
                    <p class="white-move">a6</p>
                    <p class="black-move">b6</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">1</p>
                    <p class="white-move">a1</p>
                    <p class="black-move">b2</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">2</p>
                    <p class="white-move">a4</p>
                    <p class="black-move">b5</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">3</p>
                    <p class="white-move">a6</p>
                    <p class="black-move">b6</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">1</p>
                    <p class="white-move">a1</p>
                    <p class="black-move">b2</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">2</p>
                    <p class="white-move">a4</p>
                    <p class="black-move">b5</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">3</p>
                    <p class="white-move">a6</p>
                    <p class="black-move">b6</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">1</p>
                    <p class="white-move">a1</p>
                    <p class="black-move">b2</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">2</p>
                    <p class="white-move">a4</p>
                    <p class="black-move">b5</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">3</p>
                    <p class="white-move">a6</p>
                    <p class="black-move">b6</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">1</p>
                    <p class="white-move">a1</p>
                    <p class="black-move">b2</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">2</p>
                    <p class="white-move">a4</p>
                    <p class="black-move">b5</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">3</p>
                    <p class="white-move">a6</p>
                    <p class="black-move">b6</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">1</p>
                    <p class="white-move">a1</p>
                    <p class="black-move">b2</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">2</p>
                    <p class="white-move">a4</p>
                    <p class="black-move">b5</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">3</p>
                    <p class="white-move">a6</p>
                    <p class="black-move">b6</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">1</p>
                    <p class="white-move">a1</p>
                    <p class="black-move">b2</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">2</p>
                    <p class="white-move">a4</p>
                    <p class="black-move">b5</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">3</p>
                    <p class="white-move">a6</p>
                    <p class="black-move">b6</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">1</p>
                    <p class="white-move">a1</p>
                    <p class="black-move">b2</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">2</p>
                    <p class="white-move">a4</p>
                    <p class="black-move">b5</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">3</p>
                    <p class="white-move">a6</p>
                    <p class="black-move">b6</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">1</p>
                    <p class="white-move">a1</p>
                    <p class="black-move">b2</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">2</p>
                    <p class="white-move">a4</p>
                    <p class="black-move">b5</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">3</p>
                    <p class="white-move">a6</p>
                    <p class="black-move">b6</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">1</p>
                    <p class="white-move">a1</p>
                    <p class="black-move">b2</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">2</p>
                    <p class="white-move">a4</p>
                    <p class="black-move">b5</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">3</p>
                    <p class="white-move">a6</p>
                    <p class="black-move">b6</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">1</p>
                    <p class="white-move">a1</p>
                    <p class="black-move">b2</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">2</p>
                    <p class="white-move">a4</p>
                    <p class="black-move">b5</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">3</p>
                    <p class="white-move">a6</p>
                    <p class="black-move">b6</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">1</p>
                    <p class="white-move">a1</p>
                    <p class="black-move">b2</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">2</p>
                    <p class="white-move">a4</p>
                    <p class="black-move">b5</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">3</p>
                    <p class="white-move">a6</p>
                    <p class="black-move">b6</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">1</p>
                    <p class="white-move">a1</p>
                    <p class="black-move">b2</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">2</p>
                    <p class="white-move">a4</p>
                    <p class="black-move">b5</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">3</p>
                    <p class="white-move">a6</p>
                    <p class="black-move">b6</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">1</p>
                    <p class="white-move">a1</p>
                    <p class="black-move">b2</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">2</p>
                    <p class="white-move">a4</p>
                    <p class="black-move">b5</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">3</p>
                    <p class="white-move">a6</p>
                    <p class="black-move">b6</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">1</p>
                    <p class="white-move">a1</p>
                    <p class="black-move">b2</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">2</p>
                    <p class="white-move">a4</p>
                    <p class="black-move">b5</p>
                </div>
                <div class="turn-moves">
                    <p class="turn">3</p>
                    <p class="white-move">a6</p>
                    <p class="black-move">b6</p>
                </div>
            </div>
        </div>
    </div>
    <script>
        const pieces = document.querySelectorAll('.piece');
        const boardSquares = document.querySelectorAll('.board-square');
        const chessboard = document.querySelector('.board');
        let chessboardData = chessboardDataJson;
        let selectedSquare = null;
        let selectedPiece = null;

        // add event handler for each piece 
        boardSquares.forEach((square) => {
            square.addEventListener("click", SquareClick);
        });

        // on page load read chessboardData and set the board
        window.onload = function () {
            SetBoard();
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

        function ConvertPieceTypeAndColorToAbreviation(pieceColor, pieceType) {
            if (pieceColor == 0) 
            {
                switch (pieceType) 
                {
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
            else if (pieceColor == 1) 
            {
                switch (pieceType) 
                {
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

            // check to see if there is currently a selectedSquare
            if (selectedSquare != null) {
                // reguardless of whether the square is the same as the selected square, unhighlight the selected square
                selectedSquare.classList.toggle("highlighted-square");

                // check to see if there is currently a selectedPiece
                if (selectedPiece != null) // a piece is currently selected
                {
                    // check to see if move is valid
                    validMove = IsMoveValid(selectedPiece, event.target)
                    if (validMove) {
                        // move piece to the new square
                        MovePieceToTarget(selectedPiece, event.target);
                    }
                    else {

                    }

                    // clear the selectedPiece and selectedSquare var
                    selectedPiece = null;
                    selectedSquare = null;

                }
                else {
                    // a piece is not currently selected
                    if (IsTargetAPiece(event.target)) {
                        // target is a piece
                        // hightlight the square the piece is on
                        (event.target.parentElement).classList.toggle("highlighted-square");
                        selectedPiece = event.target;
                        selectedSquare = event.target.parentElement;
                    }
                    else {
                        // target is a square

                        if (GetCoordinates(event.target) != GetCoordinates(selectedSquare)) {
                            // reasign the selectedSquare to the new selectedSquare
                            selectedSquare = event.target;

                            // hightlight the new square
                            selectedSquare.classList.toggle("highlighted-square");

                            // since the target is a not a piece set selectedPiece equal to null
                            selectedPiece = null;
                        }
                        else {
                            //selectedSquare.classList.toggle("highlighted-square");
                            selectedPiece = null;
                            selectedSquare = null;
                        }
                    }
                }
            }

            else {
                // a square is not currently selected // this will be the logic for highlighting a square / piece
                // check to see if the event.target is a square with a piece or an empty square
                if (IsTargetAPiece(event.target)) // target is a piece
                {
                    selectedPiece = event.target;
                    selectedSquare = event.target.parentElement;
                    selectedSquare.classList.toggle("highlighted-square");
                }
                else {
                    // target is not a piece
                    selectedSquare = event.target;
                    selectedSquare.classList.toggle("highlighted-square");
                }
            }
        }

        function MovePieceToTarget(piece, target) {

            // get row and column of piece square
            let coordinatesOfInitialSquare = GetCoordinates(piece.parentElement);
            let coordinatesOfTargetSquare = null;

            if (IsTargetAPiece(target)) // target is a piece
            {
                // get row and column of target.partent square
                coordinatesOfTargetSquare = GetCoordinates(target.parentElement);

                // Get the second class of the target
                let targetClasses = target.classList;
                let secondClassOfTarget = targetClasses[1];

                // Get the second class of the 'piece' element
                let typeOfPiece = piece.classList[1];

                // Remove the second class from the 'targetClasses' and remove piece element
                targetClasses.remove(secondClassOfTarget);
                piece.remove();

                // Set the second class of the target to the second class of the 'piece'
                targetClasses.add(typeOfPiece);

            }
            else // target is a square
            {
                // get row and column of target square
                coordinatesOfTargetSquare = GetCoordinates(target);

                //create new div
                let newPiece = document.createElement("div");
                newPiece.classList.add("piece");
                newPiece.classList.add(piece.classList[1]);

                // add new div to target
                target.appendChild(newPiece);

                // remove piece element
                piece.remove();
            }
            // update the chessboard data
            UpdateChessboardData(coordinatesOfInitialSquare, piece.classList[1], coordinatesOfTargetSquare);
        }

        function UpdateChessboardData(coordinatesOfInitialSquare, pieceAbreviationOnInitialSquare, coordinatesOfTargetSquare) {
            // make ajax call to the server using
            console.log("coordinatesOfInitialSquare " + coordinatesOfInitialSquare);
            console.log("pieceAbreviationOnInitialSquare " + pieceAbreviationOnInitialSquare);
            console.log("coordinatesOfTargetSquare " + coordinatesOfTargetSquare);
            $.ajax({
                type: "POST",
                url: "GamePage.aspx/UpdateChessboardData",
                data: JSON.stringify({ coordinatesOfInitialSquare: coordinatesOfInitialSquare, pieceAbreviationOnInitialSquare: pieceAbreviationOnInitialSquare, coordinatesOfTargetSquare: coordinatesOfTargetSquare }),
                contentType: "application/json; charset=utf-8", // Set the correct content type
                dataType: "json", // Expect JSON as the response from the server
                success: function (response) {
                    console.log("successs");
                },
                error: function (data) {
                    console.log("error");
                }
            });
        }

        function IsMoveValid(piece, destination) {
            // get coordinates of piece
            let pieceCoordinates = GetCoordinates(piece);

            // get coordinates of destination
            let destinationCoordinates = GetCoordinates(destination);

            console.log("selected piece coordinates are " + pieceCoordinates);
            console.log("the destination coordinates are " + destinationCoordinates);

            if (pieceCoordinates == destinationCoordinates) {
                console.log("move is not valid");
                return false;
            }
            else {
                console.log("move is valid");
                return true;
            }
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

    </script>
</asp:Content>

