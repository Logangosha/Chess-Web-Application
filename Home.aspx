<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Chess_App.Home" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="user-content overflow-scroll ">
        <div class="user-control-pannel">
            <%
                if (UsingAccount)
                {
                    
                    %>

            <asp:LinkButton runat="server" ID="AccountBtn" OnClick="AccountBtn_Click" type="button" class="Btn Btn-icon Btn-primary">
                <img src="<%=(HttpContext.Current.Session["AccountInfo"] as Chess_App.PlayerAccount).ProfilePictureString %>" class="profile-img" /></asp:LinkButton>
            <%}%>
            <%
                if (UsingAccount)
                {%><asp:LinkButton runat="server" ID="FriendsBtn" OnClick="FriendsBtn_Click" type="button" class="Btn Btn-icon Btn-primary"><i class="fa fa-users"></i></asp:LinkButton><% }
                                                                                                                                                                                            else
                                                                                                                                                                                            {%>
            <button text="Modal" type="button" class="Btn Btn-icon Btn-primary d-lg-inline-block" data-bs-toggle="modal" data-bs-target="#AccountsOnlyModal"><i class="fa fa-users"></i></button>
            <% }
            %>

            <%
                if (UsingAccount)
                {%><asp:LinkButton runat="server" ID="MessageBtn" OnClick="MessageBtn_Click" type="button" class="Btn Btn-icon Btn-primary"><i class="fa fa-message"></i></asp:LinkButton><% }
                                                                                                                                                                                              else
                                                                                                                                                                                              {%>
            <button text="Modal" type="button" class="Btn Btn-icon Btn-primary" data-bs-toggle="modal" data-bs-target="#AccountsOnlyModal"><i class="fa fa-message"></i></button>
            <% }
            %>
            <asp:LinkButton runat="server" ID="GameSetupBtn" CommandArgument="Default" OnCommand="GameSetup_Command" type="button" class="Btn Btn-icon Btn-primary d-inline-block"><i class="fa-solid fa-chess-board"></i></asp:LinkButton>

        </div>

        <div class="user-content-pannel">
             <%--<div id="GoToGamePageSection" class="section">
                <div id="GoToGamePageBackground" class="section-background"></div>
                <div class="section-content">
                    <asp:Linkbutton runat="server" type="button" ID="GoToGamePageBtn" class="Btn Btn-link" OnClick="GoToGamePageBtn_Click">
                    <i class="Btn-link-icon fa-solid fa-chess-board"></i>
                    <p class="Btn-link-text">Go To Game Page</p>
                        <i class="fa-solid fa-arrow-right Btn-link-arrow"></i>
                </asp:Linkbutton>
                </div>
            </div>--%>
            <div id="WelcomeSection" class="section">
                <div id="WelcomeSectionBackground" class="section-background"></div>
                <div class="section-content">
                    <button type="button" onclick="CloseWelcomeSection()" class="Btn Btn-notification">
                        <i class="Btn-notification-icon fa-regular fa-face-smile-beam"></i>
                        <%if (UsingAccount)
                            {%>
                        <p class="Btn-notification-text">Welcome <%= (HttpContext.Current.Session["AccountInfo"] as Chess_App.PlayerAccount).Username %>!</p>
                        <%}
                            else
                            {%>
                        <p class="Btn-notification-text">Welcome Guest!</p>
                        <%} %>
                        <i class="fa-solid fa-xmark Btn-notification-close"></i>
                    </button>
                </div>
            </div>
            <div id="PlayChessSection" class="section">
                <div id="PlayChessSectionBackground" class="section-background"></div>
                <div class="section-content button-content">
                    <asp:LinkButton runat="server" CssClass="Btn Btn-square-icon disabled" Enabled="false" OnCommand="GameSetup_Command" CommandArgument="Online">
                        <i class="fa-solid fa-globe"></i>                        
                        <p>Play Online</p>
                    </asp:LinkButton>
                    <asp:LinkButton runat="server" CssClass="Btn Btn-square-icon disabled" Enabled="false" OnCommand="GameSetup_Command" CommandArgument="Computer">
                        <i class="fa-solid fa-desktop"></i>                        
                        <p>Play Computer</p>
                    </asp:LinkButton>
                    <asp:LinkButton runat="server" CssClass="Btn Btn-square-icon" OnCommand="GameSetup_Command" CommandArgument="Default">
                        <i class="fa-solid fa-user-group"></i>                        
                        <p>Play Local</p>
                    </asp:LinkButton>
                    
                </div>
            </div>
            <%if (UsingAccount)
                {%>
            <div id="AccountButtonsSections" class="section">
                <div class="section-background"></div>
                <div class="section-content button-content">
                    <asp:LinkButton runat="server" CssClass="Btn Btn-square-icon" OnClick="AccountBtn_Click">
                        <i class="fa-regular fa-id-card"></i>                        
                        <p>Edit Account</p>
                    </asp:LinkButton>
                    <asp:LinkButton runat="server" CssClass="Btn Btn-square-icon" OnClick="MessageBtn_Click">
                        <i class="fa-solid fa-envelope"></i>                        
                        <p>Send Message</p>
                    </asp:LinkButton>
                    <asp:LinkButton runat="server" CssClass="Btn Btn-square-icon" OnClick="FriendsBtn_Click">
                        <i class="fa-solid fa-users"></i>                        
                        <p>View Friends</p>
                    </asp:LinkButton>
                </div>
            </div>
            <!-- Inside the "FriendsSection" -->
            <div id="FriendsSection" class="section">
                <!-- ... Your existing code ... -->
                <div class="section-content">
                    <div class="friends-table">
                        <div class="table-row header-row">
                            <div class="table-cell">Friend Name</div>
                            <div class="table-cell">Status</div>
                            <!-- Add more headers as needed -->
                        </div>
                        <!-- Add initial table rows and data as needed -->
                        <!-- Add more rows as needed -->
                    </div>
                </div>
            </div>
            <!-- Inside the "MessagesSection" -->
            <!-- Inside the "MessagesSection" -->
            <div id="MessagesSection" class="section">
                <!-- ... Your existing code ... -->
                <div class="section-content">
                    <div class="messages-table">
                        <div class="table-row header-row">
                            <div class="table-cell">Sender</div>
                            <div class="table-cell">Message</div>
                            <!-- Add more headers as needed -->
                        </div>
                        <!-- Add initial table rows and data as needed -->
                        <!-- Add more rows as needed -->
                    </div>
                </div>
            </div>
            <%--<div id="UserAccountSection" class="section">
                <div id="UserAccountSectionBackground" class="section-background"></div>
                <div class="section-content">
                </div>
            </div>
            <div id="ChangeThemeSection" class="section">
                <div id="ChangeThemeSectionBackground" class="section-background"></div>
                <div class="section-content">
                    <div class="change-theme">
                    </div>
                </div>
            </div>--%>
            <%}

                else
                {%>
            <div id="CreateAccountSection" class="section">
                <div id="CreateAccountSectionBackground" class="section-background"></div>
                <div class="section-content">
                    <asp:Linkbutton runat="server" type="button" ID="CreateAccountBtn" class="Btn Btn-link" OnClick="CreateAccountBtn_Click">
                    <i class="Btn-link-icon fa-solid fa-circle-exclamation"></i>
                    <p class="Btn-link-text">Create an Account!</p>
                        <i class="fa-solid fa-arrow-right Btn-link-arrow"></i>
                </asp:Linkbutton>
                </div>
            </div>
            <div id="LoginSection" class="section">
                <div id="LoginSectionBackground" class="section-background"></div>
                <div class="section-content">
                     <asp:Linkbutton runat="server" ID="SignInBtn" type="button" class="Btn Btn-link" OnClick="SignInBtn_Click">
                    <i class="Btn-link-icon fa-regular fa-circle-question"></i>
                    <p class="Btn-link-text">Have an account?</p>
                        <i class="fa-solid fa-arrow-right Btn-link-arrow"></i>
                </asp:Linkbutton>
                </div>
            </div>
           <%-- <div id="AccountsOnlySection" class="section">
                <div id="AccountsOnlySectionBackground" class="section-background"></div>
                <div class="section-content">
                  <button class="Btn Btn-primary overlay-button">
                      <b>CREATE ACCOUNT</b> OR <b>LOGIN</b><br />TO ACCESS
                  </button>
                    <img src="Images/accountsonly.gif" class="blurred-image"/>
                </div>

            </div>--%>
            <%}%>

        </div>

    </div>
    <div class="modal fade" id="AccountsOnlyModal" tabindex="-1" aria-labelledby="AccountsOnlyModal" aria-hidden="true">
        <div class="modal-dialog  modal-fullscreen">
            <div class="modal-content">
                <div class="modal-head">
                    <i class="fa-solid fa-warning modal-icon my-auto"></i>
                    <h1 class="modal-title">Account Needed
                    </h1>
                    <button type="button" class="Btn Btn-secondary modal-close pe-0" data-bs-dismiss="modal"><i class="fa-solid fa-xmark"></i></button>
                </div>
                <hr />
                <div class="modal-body my-auto gap-2">
                    <span class="modal-icon fa fa-warning"></span>
                    <h1 class="modal-heading">LOGIN</h1>
                    <h2 class="modal-subheading">To continue you will need to<b> Login</b></h2>
                </div>
                <hr />
                <div class="modal-footer">
                    <button type="button" class="Btn Btn-secondary ps-0" data-bs-dismiss="modal">Cancle</button>
                    <asp:Button runat="server" ID="ModalLoginBtn" OnClick="ModalLoginBtn_Click" type="button" class="Btn Btn-primary ms-auto" Text="Login"></asp:Button>
                </div>
            </div>
        </div>
    </div>
    <script>
        function CloseWelcomeSection() {
            $("#WelcomeSection").hide();
        }
        let friendsSection = $("#FriendsSection");
        let messagesSection = $("#MessagesSection");
        var messagesTable = $(".messages-table");
        var friendsTable = $(".friends-table");

        // load messages
        FillMessagesTable();
        // load friends
        FillFriendsTable();
        function FillFriendsTable() {
            $.ajax({
                type: "POST",
                url: "Home.aspx/GetFriends", // The name of the web method in the page
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function (response) {
                    if (response && response.d && Array.isArray(response.d) && response.d.length > 0) {
                        //console.log("Friends data received:", response.d);


                        // Loop through the received data and add rows
                        response.d.forEach(function (friend) {
                            var row = $("<div class='table-row'></div>");

                            // Create cells for friend name and status
                            var nameCell = $("<div class='table-cell'></div>").text(friend.Username);
                            var statusCell = $("<div class='table-cell'></div>").text(friend.OnlineStatus ? "Online" : "Offline");

                            // Append cells to the row
                            row.append(nameCell);
                            row.append(statusCell);

                            // Append row to the table
                            friendsTable.append(row);
                        });
                        friendsSection.removeClass("d-none");
                        friendsTable.show();


                    } else {
                        console.log("No friends data received.");
                        friendsSection.addClass("d-none");
                        friendsTable.hide();

                    }
                },
                error: function (xhr, textStatus, errorThrown) {
                    console.log("AJAX error. Status:", textStatus);
                    console.log("Error: " + errorThrown);
                }
            });
        }

        
        function FillMessagesTable() {
            $.ajax({
                type: "POST",
                url: "Home.aspx/RetrieveLastAccountMessagesWithUserInfo",
                contentType: "application/json; charset=utf-8", // Set the correct content type
                dataType: "json", // Expect JSON as the response from the server
                async: false,
                success: function (response) {
                    messagesTable.hide();
                    //add message-profiles to message-board
                    if (response && response.d && Array.isArray(response.d) && response.d.length > 0) {
                        //console.log("Messages data received:", response.d);

                       

                        // Loop through the received data and add rows
                        response.d.forEach(function (message) {
                            var row = $("<div class='table-row'></div>");

                            // Create cells for sender and message
                            var senderCell = $("<div class='table-cell'></div>").text(message.Username);
                            var messageText = message.MessageData[2];
                            var displayedText = messageText.length > 20 ? messageText.substring(0, 20) + "..." : messageText;
                            var messageCell = $("<div class='table-cell'></div>").text(displayedText);


                            // Append cells to the row
                            row.append(senderCell);
                            row.append(messageCell);

                            // Append row to the table
                            messagesTable.append(row);
                        });
                        messagesTable.show();
                        
                    } else {
                        console.log("No search results found.");
                        
                    }
                },
                error: function (error) {
                    console.log("RetrieveAccountMessages Response:", error);
                    messagesTable.hide();
                }
            });
        }
    </script>
</asp:Content>


