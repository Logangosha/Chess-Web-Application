<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Messages.aspx.cs" Inherits="Chess_App.Messages" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid h-100">
        <div class="row p-0 justify-content-center h-100 MainCard overflow-scroll hidden-scroll-bar">
            <div class="d-flex flex-column gap-2 col-auto py-4 p-0 text-center justify-content-center my-auto align-items-center">
                <h1 class=" h1-landing">MESSAGES</h1>
                <hr class="w-100 m-0" />
                <button type="button" class="Btn Btn-link" data-bs-toggle="modal" data-bs-target="#NewMessageModal">
                    <i class="Btn-link-icon fa-solid fa-envelope"></i>
                    New Message
                        <i class="fa-solid fa-arrow-right Btn-link-arrow"></i>
                </button>
                <hr class="w-100 m-0" />
                <div class="search-bar">
                    <input class="search-bar-input" autofocus="autofocus" type="text" placeholder="Search Messages" />
                    <button class="Btn Btn-primary search-bar-Btn">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
                <div id="messageBoardDiv" class="message-board">
                </div>
            </div>
        </div>
        <script>
</script>

    </div>
    <%-- New Message Modal --%>
    <div class="modal fade" id="NewMessageModal" tabindex="-1" aria-labelledby="NewMessageModal" aria-hidden="true">
        <div class="modal-dialog modal-fullscreen">
            <div class="modal-content">
                <div class="modal-head">
                    <i class="fa-solid fa-envelope modal-icon my-auto"></i>
                    <h1 class="modal-title">New Message
                    </h1>
                    <button type="button" onclick="CancleChangeTheme()" class="Btn Btn-secondary modal-close pe-0" data-bs-dismiss="modal"><i class="fa-solid fa-xmark"></i></button>
                </div>
                <hr />
                <div class="modal-body gap-2">
                    <div class="row p-0 justify-content-center h-100 MainCard overflow-scroll hidden-scroll-bar">
                        <div class="col-auto py-4 p-0 justify-content-center align-items-center">
                            <h1 class=" h1-landing mb-2">SEARCH</h1>
                            <hr />
                            <div class="search-bar">
                                <input class="search-bar-input" id="SearchUsers" autofocus="autofocus" type="text" placeholder="Search User" />
                                <button type="button" class="Btn Btn-primary search-bar-Btn">
                                    <i class="fas fa-search"></i>
                                </button>
                            </div>
                            <div id="UserTilesPlaceholder" class="d-flex flex-column gap-2 mt-2">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%-- Message Dialoge Modal --%>
    <div class="modal fade" id="MessageDialogeModal" tabindex="-1" aria-labelledby="MessageDialogeModal" aria-hidden="true">
        <div class="modal-dialog modal-fullscreen">
            <div class="modal-content">
                <div class="modal-head extra-spacing">
                    <i class="fa-solid fa-user modal-icon my-auto"></i>
                    <h1 id="MessageDialogeModalHeading" class="modal-title"></h1>
                    <button type="button" onclick="DissmisMessageDialogeModal()" class="Btn Btn-secondary modal-close pe-0" data-bs-dismiss="modal"><i class="fa-solid fa-xmark"></i></button>
                </div>
                <hr class="w-100 m-0" />
                <div class="modal-body mh-100 p-0">
                    <div class="row p-0 justify-content-center h-100 MainCard overflow-scroll hidden-scroll-bar">
                        <div class="d-flex flex-column py-0 p-0 justify-content-center align-items-center">
                            <div id="messageDialogeDiv" class="message-dialoge">
                                <!-- Recieved Friend Request -->
                                <div class="message recieved">
                                    <img src="Images/whitehandmovingchesspiece.jpg" style="width: 4rem; height: 4rem; object-fit: cover; border-radius: 4px;" />
                                    <div class="friend-request">
                                        <div class="friend-request-header">
                                            <p class="message-text"><span class="icon fa-solid fa-user-group"></span>Friend Request From</p>
                                            <p class="username"><b>Choblo</b></p>
                                        </div>
                                        <hr />
                                        <div class="friend-request-btn-div">
                                            <button class="Btn Btn-secondary">decline</button>
                                            <button class="Btn Btn-primary">accept</button>
                                        </div>
                                    </div>
                                    <p class="message-time"><b>test</b> 12:13 AM</p>
                                </div>
                                <!-- Sent Friend Request -->
                                <div class="message sent">
                                    <img src="Images/whitehandmovingchesspiece.jpg" style="width: 4rem; height: 4rem; object-fit: cover; border-radius: 4px;" />
                                    <div class="friend-request">
                                        <div class="friend-request-header">
                                            <p class="message-text"><span class="icon fa-solid fa-user-group"></span>Friend Request Sent To</p>
                                            <p class="username"><b>Choblo</b></p>
                                            <p class="status">Status:<span class="status-icon fa-regular fa-clock"></span><b>Pending</b></p>
                                        </div>
                                    </div>
                                    <p class="message-time"><b>test</b> 12:13 AM</p>
                                </div>
                                <!-- Recieved Game Invite -->
                                <div class="message recieved">
                                    <img src="Images/whitehandmovingchesspiece.jpg" style="width: 4rem; height: 4rem; object-fit: cover; border-radius: 4px;" />
                                    <div class="game-invite">
                                        <!-- Using the new class 'game-invite' -->
                                        <div class="game-invite-header">
                                            <!-- Using the same structure as friend-request-header -->
                                            <p class="message-text"><span class="icon fa-solid fa-chess-board"></span>Game Invite From</p>
                                            <p class="username"><b>Choblo</b></p>
                                        </div>
                                        <div class="game-invite-btn-div">
                                            <!-- Using the same structure as friend-request-btn-div -->
                                            <button class="Btn Btn-secondary">decline</button>
                                            <button class="Btn Btn-primary">accept</button>
                                        </div>
                                    </div>
                                    <p class="message-time"><b>test</b> 12:13 AM</p>
                                </div>
                                <!-- Sent Game Invite -->
                                <div class="message sent">
                                    <img src="Images/whitehandmovingchesspiece.jpg" style="width: 4rem; height: 4rem; object-fit: cover; border-radius: 4px;" />
                                    <div class="game-invite">
                                        <!-- Using the new class 'game-invite' -->
                                        <div class="game-invite-header">
                                            <!-- Using the same structure as friend-request-header -->
                                            <p class="message-text"><span class="icon fa-solid fa-user-group"></span>Game Invite To</p>
                                            <p class="username"><b>Choblo</b></p>
                                            <p class="status">Status:<span class="status-icon fa-regular fa-clock"></span><b>Pending</b></p>
                                        </div>
                                    </div>
                                    <p class="message-time"><b>test</b> 12:13 AM</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <hr />
                <div class="modal-footer extra-spacing">
                    <div class="message-prompt">
                        <input id="messagePromptInp" placeholder="Enter Message . . ." />
                        <button id="messagePromptBtn" type="button" class="Btn Btn-primary">
                            <i class="fas fa-message"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>

        $(document).ready(function () {
            RetrieveAccountMessages();
        });

        function DissmisMessageDialogeModal() {
            var messageDialogeDiv = $("#messageDialogeDiv");
            messageDialogeDiv.empty();
            RetrieveAccountMessages();
        }

        // AJAX call to server passing the current user id and retreiving all unique conversations
        function RetrieveAccountMessages() {
            // Make the AJAX request to send the message
            $.ajax({
                type: "POST",
                url: "Messages.aspx/RetrieveLastAccountMessagesWithUserInfo",
                contentType: "application/json; charset=utf-8", // Set the correct content type
                dataType: "json", // Expect JSON as the response from the server
                success: function (response) {
                    // add message-profiles to message-board
                    if (response && response.d && Array.isArray(response.d) && response.d.length > 0) {
                        var messageBoardDiv = $("#messageBoardDiv");
                        messageBoardDiv.empty(); // Clear the container

                        // Loop through the search results and create user tiles
                        for (var i = 0; i < response.d.length; i++) {
                            console.table(response.d[i]);
                            var account = response.d[i];
                            var tileStatusClass = account.OnlineStatus ? "online" : "offline";
                            var isNewMessage = account.MessageData[0] ? "new-message" : "";

                            var messageProfile = $("<button>", {
                                class: "message-profile",
                            });
                            var messageProfileBody = $("<div>", {
                                class: "message-profile-body",
                            });
                            var messageProfileHeading = $("<div>", {
                                class: "message-profile-heading",
                            });
                            var statusIndicator = $("<div>", {
                                class: "status-indicator " + tileStatusClass + "",
                            });
                            var username = $("<div>", {
                                class: "username",
                            });
                            var usernameTxt = $("<h4>", {});
                            usernameTxt.text(account.Username);
                            var timestamp = $("<div>", {
                                class: "timestamp",
                            });
                            var timestampTxt = $("<p>", {});
                            timestampTxt.text("12:34 AM");
                            var messageProfileMessage = $("<div>", {
                                class: "message-profile-message",
                            });
                            var messageProfileMessageTxt = $("<p>", {
                                class: "message-text " + isNewMessage + "",
                            });
                            messageProfileMessageTxt.text(account.MessageData[2]);
                            var messageProfileImg = $("<img>", {
                                src: account.ProfilePictureString,
                            });

                            //tile.data('username', account.Username); // Store the username as a data attribute in the tile button element
                            //tile.data('recipient-id', account.ID); // Store the recipientId as a data attribute in the tile button element
                            timestamp.append(timestampTxt);
                            username.append(usernameTxt);
                            messageProfileMessage.append(messageProfileMessageTxt);
                            messageProfileHeading.append(statusIndicator, username, timestamp);
                            messageProfileBody.append(messageProfileHeading, messageProfileMessage);
                            messageProfile.append(messageProfileBody, messageProfileImg);
                            messageBoardDiv.append(messageProfile);

                            messageProfile.data('username', account.Username); // Store the username as a data attribute in the tile button element
                            messageProfile.data('recipient-id', account.ID); // Store the recipientId as a data attribute in the tile button element
                            messageProfile.data("profile-picture", account.ProfilePictureString);
                            messageProfile.on("click", function (event) {
                                handleMessageProfileClick(event);
                            });
                        }
                    } else {
                        console.log("No search results found.");
                    }
                },
                error: function (error) {

                }
            });
        }
        function handleMessageProfileClick(event) {
            event.preventDefault();
            var recipientId = $(event.currentTarget).data('recipient-id');
            var username = $(event.currentTarget).data('username');
            var profilePictureString = $(event.currentTarget).data('profile-picture'); // Retrieve the profile picture URL

            $("#MessageDialogeModalHeading").text(username);
            $("#MessageDialogeModalHeading").data('recipient-id', recipientId);
            getMessagesBetweenUsers(recipientId, profilePictureString);
            $("#MessageDialogeModal").modal("show");
        }

        function getMessagesBetweenUsers(recipientId, recipientProfilePictureString) {
            $.ajax({
                type: "POST",
                url: "Messages.aspx/GetMessagesBetweenUsers",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ recipientId: recipientId }), // Pass the recipientId as data in the request
                dataType: "json",
                success: function (response) {
                    console.log('getMessagesBetweenUsers: ' + response);
                    // Handle the response containing messages between users
                    if (response && response.d && Array.isArray(response.d)) {
                        // add messages to messageDialogeDiv
                        var messageDialogeDiv = $("#messageDialogeDiv");
                        //messageDialogeDiv.empty(); // Clear the container

                        // Loop through the messages and add them to messageDialogeDiv
                        for (var i = 0; i < response.d.length; i++) {
                            var message = response.d[i];

                            // Determine the class for the message based on sender/receiver
                            var messageClass = message.SenderId === recipientId ? "message received" : "message sent";
                            profilePictureString = message.SenderId === recipientId ? recipientProfilePictureString : "<%=((Chess_App.PlayerAccount)Session["AccountInfo"]).ProfilePictureString%>";

                            // Create the message elements
                            var messageDiv = $("<div>", {
                                class: messageClass,
                            });

                            var profileImage = $("<img>", {
                                src: profilePictureString,
                                style: "width: 4rem; height: 4rem; object-fit: cover; border-radius: 4px;",
                            });

                            var messageText = $("<p>", {
                                class: "message-text",
                            });
                            messageText.text(message.Content);

                            var messageTime = $("<p>", {
                                class: "message-time",
                            });
                            var senderName = message.SenderId === recipientId ? "<b>" + $("#MessageDialogeModalHeading").text() + "</b>" : "<b>" + "<%=((Chess_App.PlayerAccount)Session["AccountInfo"]).Username%>" + "</b>";
                            messageTime.html(senderName + " " + message.FormattedTimestamp);

                            // Append the elements to the messageDiv
                            messageDiv.append(profileImage, messageText, messageTime);

                            // Append the messageDiv to messageDialogeDiv
                            messageDialogeDiv.append(messageDiv);
                        }
                    } else {
                        console.log("No messages found between users.");
                    }
                },
                error: function (error) {
                    console.log("Error retrieving messages between users: " + error);
                }
            });
        }





        var searchTimeout;

        // Function to handle user search
        function searchUsers() {
            clearTimeout(searchTimeout); // Clear the previous timeout

            var searchText = $("#SearchUsers").val(); // Get the current text from the search input

            // Set a new timeout to delay the AJAX request after a short interval (e.g., 500ms)
            searchTimeout = setTimeout(function () {
                performSearch(searchText);
            }, 500); // Adjust the delay interval as needed
        }

        // Function to perform user search using AJAX
        function performSearch(searchText) {
            console.log("Searching for: " + searchText);
            $.ajax({
                type: "POST",
                url: "Messages.aspx/SearchUsers",
                data: JSON.stringify({ searchText: searchText }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    console.log("AJAX success. Response:", response);

                    if (response && response.d && Array.isArray(response.d) && response.d.length > 0) {
                        var userTilesContainer = $("#UserTilesPlaceholder");
                        userTilesContainer.empty(); // Clear the container

                        // Loop through the search results and create user tiles
                        for (var i = 0; i < response.d.length; i++) {
                            console.table(response.d[i]);
                            var account = response.d[i];
                            var tileStatusClass = account.OnlineStatus ? "online" : "offline";

                            var tile = $("<button>", {
                                runat: "server",
                                class: "Btn user-tile",
                            });
                            var image = $("<img>", { src: account.ProfilePictureString });
                            var username = $("<p>").text(account.Username);
                            var statusIndicator = $("<span>", { class: "status-indicator " + tileStatusClass });
                            tile.data('username', account.Username); // Store the username as a data attribute in the tile button element
                            tile.data('recipient-id', account.ID); // Store the recipientId as a data attribute in the tile button element

                            tile.append(image, username, statusIndicator);
                            userTilesContainer.append(tile);

                            // Attach event handler to tile click event
                            tile.on("click", function (event) {
                                handleTileClick(event);
                            });
                        }
                    } else {
                        console.log("No search results found.");
                    }
                },
                error: function (textStatus, errorThrown) {
                    console.log("AJAX error. Status:", textStatus);
                    console.log("Error: " + errorThrown);
                }
            });
        }

        // Function to handle tile click event
        function handleTileClick(event) {
            event.preventDefault(); // Prevent the default button behavior
            $("#NewMessageModal").modal("hide");

            var username = $(event.currentTarget).data('username'); // Retrieve the username from the data attribute of the clicked tile
            var recipientId = $(event.currentTarget).data('recipient-id'); // Retrieve the recipientId from the data attribute of the clicked tile

            $("#MessageDialogeModalHeading").text(username); // Set the modal heading to the username of the clicked tile
            $("#MessageDialogeModalHeading").data('recipient-id', recipientId); // Store the recipientId as a data attribute in the heading element

            $("#MessageDialogeModal").modal("show"); // Show the modal after setting the recipientId
        }

        // Attach event handler to search button click
        $(".search-bar-Btn").on("click", function () {
            var searchText = $("#SearchUsers").val(); // Get the current text from the search input
            performSearch(searchText);
        });

        // Attach event handler to input field keyup event for real-time search
        $("#SearchUsers").on("keyup", function () {
            searchUsers();
        });
        // Attach event handler to message prompt button click and input keyup event


        // Attach event handler to "message-prompt" input for keydown
        $("#messagePromptInp").on("keydown", function (event) {
            if (event.keyCode === 13) { // Check if the key code is for the Enter key (key code 13)
                event.preventDefault();
                sendMessageIfValid();
            }
        });

        // Attach event handler to "message-prompt" button for click and keydown
        $("#messagePromptBtn").on("click keydown", function (event) {
            if (event.type === "click" || event.keyCode === 13) { // Check if it's a click event or Enter key press (key code 13)
                event.preventDefault();
                sendMessageIfValid();
            }
        });

        // Your custom function to be executed when the message prompt button is clicked or Enter key is pressed
        function sendMessageIfValid() {
            var message = $("#messagePromptInp").val().trim(); // Get the current text from the message prompt input and remove leading/trailing spaces
            var recipientId = $("#MessageDialogeModalHeading").data('recipient-id'); // Retrieve the recipientId from the data attribute of the heading

            if (message !== "") {
                SendMessage(message, recipientId, 0, null); // Send the message if it's not empty
            }
        }

        // Your custom function to be executed when the message prompt button is clicked
        function SendMessage(message, recipientId, messageType, isAccepted) {
            // Make the AJAX request to send the message
            $.ajax({
                type: "POST",
                url: "Messages.aspx/SendMessage",
                data: JSON.stringify({ message: message, recipientId: recipientId, messageType: messageType, isAccepted: isAccepted }),
                contentType: "application/json; charset=utf-8", // Set the correct content type
                dataType: "json", // Expect JSON as the response from the server
                success: function (response) {
                    var newMessage = '<div class="message sent">' +
                        '<img src="<%=((Chess_App.PlayerAccount)Session["AccountInfo"]).ProfilePictureString%>" style="width: 4rem; height: 4rem; object-fit: cover; border-radius: 4px;"/>' +
                        '<p class="message-text">' + message + '</p>' +
                        '<p class="message-time"><b><%=((Chess_App.PlayerAccount)Session["AccountInfo"]).Username%> </b>' + getCurrentTimeFormatted() + '</p>' +
                        '</div>';
                    $('.message-dialoge').append(newMessage);
                },
                error: function (error) {
                    // Handle the error response here
                    console.error('Error sending the message:', error);

                    // Optionally, display an error message to the user
                    // For example, you could create a <div> element with an error message and append it to the message-dialoge div
                    //var errorMessage = '<div class="error-message">Error sending the message.</div>';
                    //$('.message-dialoge').append(errorMessage);
                }
            });

            // Optionally, you can clear the message input after sending the message
            $("#messagePromptInp").val("");
        }

        function getCurrentTimeFormatted() {
            var currentDate = new Date();

            var hours = currentDate.getHours();
            var minutes = currentDate.getMinutes();
            var meridiem = hours >= 12 ? 'PM' : 'AM';

            // Convert to 12-hour format
            hours = hours % 12;
            hours = hours ? hours : 12; // If hours is 0, set it to 12

            // Remove leading zeros if needed
            hours = String(hours).replace(/^0+/, ''); // Remove leading zeros from hours
            minutes = String(minutes).padStart(2, '0');

            // Concatenate the time in the desired format
            var currentTimeFormatted = hours + ':' + minutes + ' ' + meridiem;

            return currentTimeFormatted;
        }
    </script>
</asp:Content>
