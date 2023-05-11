<%@ Page Language="C#" MasterPageFile="~/Site.Master" Title="Game Page" AutoEventWireup="true" CodeBehind="GameSetup.aspx.cs" Inherits="Chess_App.GamePage" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
        <div class="row p-0  h-100 MainCard">
        <div class="col d-flex flex-column align-items-center justify-content-center overflow-auto pt-5">
                 <% if ("Default" == Request.QueryString["type"])
                     {%>
                <div class="d-flex flex-column gap-4 justify-content-center">
                   <h1 class="h1-landing align-self-center">Play Chess!</h1>
                    <asp:LinkButton runat="server" id="PlayOnlineBtn" CommandArgument="Online"      OnCommand="GameSetup_Command" CssClass="Btn Btn-primary user-control-pannel-body-btn-text w-100"><span class="user-control-pannel-body-btn-icon fa fa-globe"></span>&nbsp;Play Online</asp:LinkButton>
                    <asp:LinkButton runat="server" id="PlayComputereBtn" CommandArgument="Computer" OnCommand="GameSetup_Command" CssClass="Btn Btn-primary user-control-pannel-body-btn-text w-100"><span class="user-control-pannel-body-btn-icon fa fa-computer"></span>&nbsp;Play Computer</asp:LinkButton>
                    <asp:LinkButton runat="server" id="PlayFriendBtn" CommandArgument="Friends"     OnCommand="GameSetup_Command" CssClass="Btn Btn-primary user-control-pannel-body-btn-text w-100"><span class="user-control-pannel-body-btn-icon fa fa-user"></span>&nbsp;Play Friends</asp:LinkButton>
                </div>
                <%}
                    else
                    {%>
                <div class="d-grid text-center flex-column">
                    <h1 class="h1-landing">SETUP</h1>
                </div>
                <div class="d-grid text-center flex-column gap-3 mb-5 ">
                    <h2>Complete to continue</h2>
                    <% if ("Friends" == Request.QueryString["type"])
                        {%>
                    <div class="dropdown w-100">
                      <button type="button" onclick="ShowDropdown('SelectFriendDiv')" id="SelectFriendBtn" class="Btn-dropdown Btn Btn-primary w-100">Select Friend</button>
                      <div id="SelectFriendDiv" class="dropdown-content">
                          <a>Myke1122</a>
                          <a>Choblo</a>
                          <a>!_A_!</a>
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
                          <a><i class="fa fa-chess-knight pe-2"></i>Easy</a>
                          <a><i class="fa-solid fa-sliders pe-2"></i>Medium</a>
                          <a><i class="fa-solid fa-shuffle pe-2"></i>Hard</a>
                      </div>
                    </div>
                    <%}
                        else
                        { %>
                <div class="dropdown w-100">
                  <button type="button" onclick="ShowDropdown('TimeDiv')" id="TimeBtn" class="Btn-dropdown Btn Btn-primary w-100">Timer Settings</button>
                  <div id="TimeDiv" class="dropdown-content">
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
                
                <asp:Button runat="server" ID="PlayChessBtn" disabled CssClass="Btn Btn-primary Btn-toggle mb-3 Btn-disabled" Text="Play Chess" />
                    <%} %>
            </div>
        </div>
           
                
                
                
        <script>
            <%if ("Default" == Request.QueryString["type"]) { }
              
            else {%>
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

            <%if ("Computer" != Request.QueryString["type"]){%>
                var TimeChildren = document.getElementById("TimeDiv").children;
                var TimeBtn = document.getElementById("TimeBtn");
                for (var i = 0; TimeChildren[i]; i++) {
                    TimeChildren[i].onclick = function () {
                        TimeBtn.innerHTML = this.text;
                        CheckValidation();
                    }
                }
            <%}
            else {%> 
                var DifficultyChildren = document.getElementById("DifficultyDiv").children;
                var DifficultyBtn = document.getElementById("DifficultyBtn");
                for (var i = 0; DifficultyChildren[i]; i++) {
                    DifficultyChildren[i].onclick = function () {
                        DifficultyBtn.innerHTML = this.text;
                        CheckValidation();
                    }
                }
            <%}%>
            
            <%if ("Friends" == Request.QueryString["type"]){%>
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
                        if (TimeBtn.textContent != "Timer Settings")
                        {
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
               
                //if (GameModeBtn.textContent == "Game Mode" || TimeBtn.innerHTML == "Timer Settings" || ChooseColorBtn.innerHTML == "Select Color") {
                //    PlayChessBtn.classList.add('Btn-disabled')
                //    PlayChessBtn.disabled = true;
                //}
                //else {
                //    PlayChessBtn.classList.remove('Btn-disabled')
                //    PlayChessBtn.disabled = false;
                //}
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
        </script>
</div>
</asp:Content>


