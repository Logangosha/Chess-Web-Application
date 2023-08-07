<%@ Page Language="C#" MasterPageFile="~/Site.Master" Title="Game Setup" AutoEventWireup="true" CodeBehind="GameSetup.aspx.cs" Inherits="Chess_App.GameSetup" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row p-0  h-100 MainCard">
        <div class="col d-flex flex-column align-items-center justify-content-center overflow-auto pt-5">
            <% if ("Default" == Request.QueryString["type"])
                {%>
            <div class="d-flex flex-column gap-4 justify-content-center">
                 <asp:LinkButton runat="server" ID="GoHomeBtn" OnClick="GoHomeBtn_Click" class="Btn Btn-secondary Btn-link">
                    <i class="Btn-link-icon fa-solid fa-arrow-left"></i>
                    Go Home
                </asp:LinkButton>
                <h1 class="h1-landing align-self-center">PLAY CHESS</h1>
                <hr />
                 <asp:LinkButton runat="server" ID="PlayOnlineBtn" CommandArgument="Online" OnCommand="GameSetup_Command" class="Btn Btn-link">
                    <i class="Btn-link-icon fa fa-globe"></i>
                    <p class="Btn-link-text">Play Online</p>
                        <i class="fa-solid fa-arrow-right Btn-link-arrow"></i>
                </asp:LinkButton>
                <asp:LinkButton runat="server" ID="PlayComputereBtn" CommandArgument="Computer" OnCommand="GameSetup_Command" class="Btn Btn-link">
                    <i class="Btn-link-icon fa fa-computer"></i>
                    <p class="Btn-link-text">Play Computer</p>
                        <i class="fa-solid fa-arrow-right Btn-link-arrow"></i>
                </asp:LinkButton>
                 <asp:LinkButton runat="server" ID="PlayFriendBtn" CommandArgument="Friends" OnCommand="GameSetup_Command" class="Btn Btn-link">
                    <i class="Btn-link-icon fa fa-user"></i>
                    <p class="Btn-link-text">Play Friends</p>
                        <i class="fa-solid fa-arrow-right Btn-link-arrow"></i>
                </asp:LinkButton>
                <%--<asp:LinkButton runat="server" ID="PlayOnlineBtn" CommandArgument="Online" OnCommand="GameSetup_Command" CssClass="Btn Btn-primary Btn-link"><span class=" fa fa-globe"></span>&nbsp;Play Online</asp:LinkButton>--%>
                <%--<asp:LinkButton runat="server" ID="PlayComputereBtn" CommandArgument="Computer" OnCommand="GameSetup_Command" CssClass="Btn Btn-primary Btn-link"><span class="fa fa-computer"></span>&nbsp;Play Computer</asp:LinkButton>--%>
                <%--<asp:LinkButton runat="server" ID="PlayFriendBtn" CommandArgument="Friends" OnCommand="GameSetup_Command" CssClass="Btn Btn-primary Btn-link"><span class="fa fa-user"></span>&nbsp;Play Friends</asp:LinkButton>--%>
            </div>
            <%}
                else
                {%>
            <div class="d-grid text-center flex-column gap-3 mb-5 ">
                <button runat="server" onserverclick="GoBackBtn_Click" type="button" class="Btn Btn-link">
                    <i class="Btn-link-icon fa-solid fa-arrow-left"></i>
                    Go Back
                </button>
                <h1 class="h1-landing">SETUP</h1>
                <h2>Complete to continue</h2>
                <% if ("Friends" == Request.QueryString["type"])
                    {%>
                <div class="dropdown w-100">
                    <button type="button" onclick="ShowDropdown('SelectFriendDiv')" id="SelectFriendBtn" class="Btn-dropdown Btn Btn-primary w-100">Select Friend</button>
                    <div id="SelectFriendDiv" class="dropdown-content">
                        <a class="dropdown-content-friend">
                        <img src="Images/twomenplayingchessdarkroom.jpg" class="dropdown-content-friend-img"/>
                        <span class="dropdown-content-friend-name">Myke1122</span>
                        </a>
                    </div>
                </div>
                <%} %>
                <div class="dropdown w-100">
                    <button type="button" onclick="ShowDropdown('GameModeDiv')" id="GameModeBtn" class="Btn-dropdown Btn Btn-primary w-100">Game Mode</button>
                    <div id="GameModeDiv" class="dropdown-content">
                        <a><i class="fa fa-chess-knight pe-2"></i>Standard</a>
                        <a><i class="fa-solid fa-sliders pe-2"></i>Custom</a>
                        <a><i class="fa-solid fa-shuffle pe-2"></i>Random</a>
                    </div>
                </div>
                <% if ("Computer" == Request.QueryString["type"])
                    {%>
                <div class="dropdown w-100">
                    <button type="button" onclick="ShowDropdown('DifficultyDiv')" id="DifficultyBtn" class="Btn-dropdown Btn Btn-primary w-100">Difficulty</button>
                    <div id="DifficultyDiv" class="dropdown-content">
                        <a><i class="fa fa- pe-2"></i>Easy</a>
                        <a><i class="fa-solid fa-face-meh pe-2"></i>Medium</a>
                        <a><i class="fa-solid fa-skull pe-2"></i>Hard</a>
                    </div>
                </div>
                <%}
                    else
                    { %>
                <div class="dropdown w-100">
                    <button type="button" onclick="ShowDropdown('TimeDiv')" id="TimeBtn" class="Btn-dropdown Btn Btn-primary w-100">Timer Settings</button>
                    <div id="TimeDiv" class="dropdown-content">
                        <a>No Timer</a>
                        <a>1 Minute</a>
                        <a>5 Minute</a>
                        <a>10 Minute</a>
                    </div>
                </div>
                <%} %>
                <div class="dropdown w-100">
                    <button type="button" onclick="ShowDropdown('ChooseColorDiv')" id="ChooseColorBtn" class="Btn-dropdown Btn Btn-primary w-100">Select Color</button>
                    <div id="ChooseColorDiv" class="dropdown-content">
                        <a>White</a>
                        <a>Black</a>
                        <a>Random</a>
                    </div>
                </div>

                <asp:Button runat="server" ID="PlayChessBtn" OnClick="PlayChessBtn_Click" CssClass="Btn Btn-primary Btn-toggle mb-3 Btn-disabled" Text="Play Chess" />
                <%} %>
            </div>
        </div>




        <script>
            <%if ("Default" == Request.QueryString["type"]) { }

            else
            {%>
            var GameModeChildren = document.getElementById("GameModeDiv").children;
            var GameModeBtn = document.getElementById("GameModeBtn")
            for (var i = 0; GameModeChildren[i]; i++) {
                GameModeChildren[i].onclick = function () {
                    GameModeBtn.innerHTML = this.childNodes[0].outerHTML + this.text;
                    CheckValidation();
                }
            }

            var ChooseColorChildren = document.getElementById("ChooseColorDiv").children;
            var ChooseColorBtn = document.getElementById("ChooseColorBtn")
            for (var i = 0; ChooseColorChildren[i]; i++) {
                ChooseColorChildren[i].onclick = function () {
                    ChooseColorBtn.innerHTML = this.text;
                    CheckValidation();
                }
            }

            <%if ("Computer" != Request.QueryString["type"])
            {%>
            var TimeChildren = document.getElementById("TimeDiv").children;
            var TimeBtn = document.getElementById("TimeBtn");
            for (var i = 0; TimeChildren[i]; i++) {
                TimeChildren[i].onclick = function () {
                    TimeBtn.innerHTML = this.text;
                    CheckValidation();
                }
            }
            <%}
            else
            {%> 
            var DifficultyChildren = document.getElementById("DifficultyDiv").children;
            var DifficultyBtn = document.getElementById("DifficultyBtn");
            for (var i = 0; DifficultyChildren[i]; i++) {
                DifficultyChildren[i].onclick = function () {
                    DifficultyBtn.innerHTML = this.text;
                    CheckValidation();
                }
            }
            <%}%>

            <%if ("Friends" == Request.QueryString["type"])
            {%>
            GetFriends();
            var SelectFriendChildren = document.getElementById("SelectFriendDiv").children;
            var SelectFriendBtn = document.getElementById("SelectFriendBtn");
            for (var i = 0; SelectFriendChildren[i]; i++) {
                SelectFriendChildren[i].onclick = function () {
                    SelectFriendBtn.innerHTML = this.text;
                    CheckValidation();
                }
            }
            <%}%>

            const PlayChessBtn = document.getElementById('<%=PlayChessBtn.ClientID%>');
            function CheckValidation() {

                DisablePlayChessBtn();
                var setupType = "<%=Request.QueryString["type"]%>";
                if (GameModeBtn.textContent != "Game Mode" && ChooseColorBtn.textContent != "Select Color") {
                    if (setupType == "Online" || setupType == "Friends") {
                        if (TimeBtn.textContent != "Timer Settings") {
                            if (setupType == "Friends") {
                                if (SelectFriendBtn.textContent != "Select Friend") {
                                    EnablePlayChessBtn();
                                }
                            }
                            else {
                                EnablePlayChessBtn();
                            }
                        }

                    }
                    else if (setupType == "Computer") {
                        if (DifficultyBtn.textContent != "Difficulty") {
                            EnablePlayChessBtn();
                        }
                    }
                }

            }
            // ajax get friends
            function GetFriends() {
                $.ajax({
                    type: "POST",
                    url: "GameSetup.aspx/GetFriends",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        if (response && response.d && Array.isArray(response.d)) {
                            console.log("Friends data received:", response.d);

                            // Clear the friendBoardDiv before updating with new data
                            $("#SelectFriendDiv").empty();

                            // Loop through each friend in the response
                            response.d.forEach(function (friend) {
                                // Create the elements for each friend
                                var friendDiv = $("<div>", { class: "dropdown-content-friend" });
                                var friendImg = $("<img>", { src: friend.ProfilePictureString, class: "dropdown-content-friend-img" });
                                var friendName = $("<span>", { class: "dropdown-content-friend-name", text: friend.Username });

                                // Append the elements to the friendDiv
                                friendDiv.append(friendImg, friendName);

                                // Add an onclick event to each friend to update "SelectFriendBtn" and call "CheckValidation()"
                                friendDiv.on("click", function () {
                                    $("#SelectFriendBtn").text(friend.Username);
                                    CheckValidation();
                                });

                                // Append the friendDiv to the "SelectFriendDiv"
                                $("#SelectFriendDiv").append(friendDiv);
                            });

                        } else {
                            console.log("No friends data received.");
                        }
                    },
                    error: function (xhr, textStatus, errorThrown) {
                        console.log("AJAX error. Status:", textStatus);
                        console.log("Error: " + errorThrown);
                    }
                });
            }

            function DisablePlayChessBtn() {
                PlayChessBtn.classList.add('Btn-disabled')
                PlayChessBtn.disabled = true;
            }

            function EnablePlayChessBtn() {
                PlayChessBtn.classList.remove('Btn-disabled')
                PlayChessBtn.disabled = false;
            }

            /* When the user clicks on the button, 
            toggle between hiding and showing the dropdown content */
            function ShowDropdown(id) {
                ClearDropdowns();
                document.getElementById(id).classList.toggle("show");
            }

            function ClearDropdowns() {
                var dropdowns = document.getElementsByClassName("dropdown-content");
                for (var i = 0; i < dropdowns.length; i++) {
                    var openDropdown = dropdowns[i];
                    if (openDropdown.classList.contains('show')) {
                        openDropdown.classList.remove('show');
                    }
                }
            }

            // Close the dropdown if the user clicks outside of it
            window.onclick = function (event) {
                // if the user does not click on a drop down button 
                if (!event.target.matches('.Btn-dropdown')) {
                    ClearDropdowns();
                }
            }
            <%}%>    

            // Function to clear all dropdowns and hide them
            function ClearDropdowns() {
                var dropdowns = document.getElementsByClassName("dropdown-content");
                for (var i = 0; i < dropdowns.length; i++) {
                    var openDropdown = dropdowns[i];
                    if (openDropdown.classList.contains('show')) {
                        openDropdown.classList.remove('show');
                    }
                }
            }

            // Close the dropdown if the user clicks outside of it
            window.onclick = function (event) {
                // If the user does not click on a drop-down button, close any open dropdowns
                if (!event.target.matches('.Btn-dropdown')) {
                    ClearDropdowns();
                }
            }
        </script>


    </div>
</asp:Content>


