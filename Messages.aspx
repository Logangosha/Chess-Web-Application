<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Messages.aspx.cs" Inherits="Chess_App.Messages" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid h-100">
        <div class="row p-0 justify-content-center h-100 MainCard overflow-scroll hidden-scroll-bar">
            <div class="d-flex flex-column gap-2 col-auto py-4 p-0 text-center justify-content-center my-auto align-items-center">
                <asp:LinkButton runat="server" ID="goHomeBtn" OnClick="goHomeBtn_Click" class="Btn Btn-secondary Btn-link">
                    <i class="Btn-link-icon fa-solid fa-arrow-left"></i>
                    Go Home
                </asp:LinkButton>
                <h1 class=" h1-landing">MESSAGES</h1>
                <hr class="w-100 m-0" />
                <button type="button" class="Btn Btn-link" data-bs-toggle="modal" data-bs-target="#NewMessageModal">
                    <i class="Btn-link-icon fa-solid fa-envelope"></i>
                    New Message
                        <i class="fa-solid fa-arrow-right Btn-link-arrow"></i>
                </button>
                <hr class="w-100 m-0" />
                <div class="search-bar">
                    <input id="SearchMessagesInp" class="search-bar-input" autofocus="autofocus" type="text" placeholder="Search Messages" />
                    <button id="SearchMessagesBtn" class="Btn Btn-primary search-bar-Btn">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
                <div id="messageBoardDiv" class="message-board">
                </div>
            </div>
        </div>
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
                    <div id="messageDialogeDivParent" class="row p-0 justify-content-center h-100 MainCard overflow-scroll hidden-scroll-bar">
                        <div class="d-flex flex-column py-0 p-0 justify-content-center align-items-center">
                            <div id="messageDialogeDiv" class="message-dialoge">
                                <!-- messages go here -->
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
            // SearchFriendsInp and SearchFriendsBtn event handler on keyup and click respectively
            $("#SearchMessagesInp").on("keyup", searchMessages);
            $("#SearchMessagesBtn").on("click", searchMessages);
        });

        

        function searchMessages() {
            var messageBoardDiv = $("#messageBoardDiv");
            var searchText = $("#SearchMessagesInp").val();

            console.log("Search Text:", searchText);

            messageBoardDiv.children().each(function () {
                var messageProfile = $(this); // Store the reference to the current element

                var messageName = messageProfile.data('username');
                console.log("Message Name:", messageName);

                if (messageName.toLowerCase().includes(searchText.toLowerCase())) {
                    console.log("Showing:", messageName);
                    messageProfile.show(); // Use the stored reference to show the element
                } else {
                    console.log("Hiding:", messageName);
                    messageProfile.hide(); // Use the stored reference to hide the element
                }
            });
        }

        // Gets All Accounts You Have Messages With
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
                            timestampTxt.text(account.MessageData[3]);
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
                            messageProfile.append(messageProfileImg, messageProfileBody);
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

        // Function that runs when X button is pressed in modal
        function DissmisMessageDialogeModal() {
            var messageDialogeDiv = $("#messageDialogeDiv");
            messageDialogeDiv.empty();
            RetrieveAccountMessages();
        }

        // AJAX call to server passing the current user id and retreiving all unique conversations
        function handleMessageProfileClick(event) {
            event.preventDefault();
            var recipientId = $(event.currentTarget).data('recipient-id');
            var username = $(event.currentTarget).data('username');
            var profilePictureString = $(event.currentTarget).data('profile-picture');

            $("#MessageDialogeModalHeading").text(username);
            $("#MessageDialogeModalHeading").data('recipient-id', recipientId);
            getMessagesBetweenUsers(recipientId, profilePictureString);
            // Scroll to the bottom of the messageDialogeDiv
            setTimeout(function () {
                let messageContainer = document.getElementById("messageDialogeDivParent");
                scrollToBottom(messageContainer);
            }, 200);
            $("#MessageDialogeModal").modal("show");
        }

        function handleTileClick(event) {
            event.preventDefault(); // Prevent the default button behavior
            $("#NewMessageModal").modal("hide");

            var username = $(event.currentTarget).data('username'); // Retrieve the username from the data attribute of the clicked tile
            var recipientId = $(event.currentTarget).data('recipient-id'); // Retrieve the recipientId from the data attribute of the clicked tile

            $("#MessageDialogeModalHeading").text(username); // Set the modal heading to the username of the clicked tile
            $("#MessageDialogeModalHeading").data('recipient-id', recipientId); // Store the recipientId as a data attribute in the heading element

            $("#MessageDialogeModal").modal("show"); // Show the modal after setting the recipientId
        }

        // Gets All Individual Messages Between Users
        function getMessagesBetweenUsers(recipientId, recipientProfilePictureString) {
            $.ajax({
                type: "POST",
                url: "Messages.aspx/GetMessagesBetweenUsers",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ recipientId: recipientId }), // Pass the recipientId as data in the request
                dataType: "json",
                success: function (response) {
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
                            messageDiv.data("messageId", message.MessageId);
                            var profileImage = $("<img>", {
                                src: profilePictureString,
                                style: "width: 4rem; height: 4rem; object-fit: cover; border-radius: 4px;",
                            });

                            var messageText;

                            // content of message based on message type
                            switch (message.MessageType) {
                                case 0:
                                    // text message
                                    messageText = $("<p>", {
                                        class: "message-text",
                                    });
                                    messageText.text(message.Content);
                                    break;
                                case 1:
                                    // friend request
                                    // sent friend request
                                    if (messageClass == "message sent") {
                                        messageText = $("<div>", {
                                            class: "friend-request",
                                        });
                                        var friendRequestHeader = $("<div>", {
                                            class: "friend-request-header",
                                        });
                                        var friendRequestHeaderMessageText = $("<p>", {
                                            class: "message-text",
                                        });
                                        var friendRequestIcon = $("<span>", {
                                            class: "icon fa-solid fa-user-group", // This class will be used to display the icon
                                        });
                                        friendRequestHeaderMessageText.append(friendRequestIcon); // Append the icon
                                        friendRequestHeaderMessageText.append("Friend Request Sent To"); // Append the text
                                        var friendRequestHeaderUsername = $("<p>", {
                                            class: "username",
                                        });
                                        friendRequestHeaderUsername.text($("#MessageDialogeModalHeading").text());
                                        var friendRequestHeaderStatus = $("<p>", {
                                            class: "status",
                                        });
                                        var friendRequestStatusIcon = $("<span>", {});
                                        switch (message.IsAccepted) {
                                            case null:
                                                friendRequestStatusIcon.addClass("status-icon fa-regular fa-clock");
                                                friendRequestHeaderStatus.append("Pending"); // Append the text after the icon
                                                friendRequestHeaderStatus.append(friendRequestStatusIcon); // Add the icon first
                                                break;
                                            case false:
                                                friendRequestStatusIcon.addClass("status-icon fa-solid fa-xmark");
                                                friendRequestHeaderStatus.append("Declined"); // Append the text after the icon
                                                friendRequestHeaderStatus.append(friendRequestStatusIcon); // Add the icon first
                                                break;
                                            case true:
                                                friendRequestStatusIcon.addClass("status-icon fa-solid fa-check");
                                                friendRequestHeaderStatus.append("Accepted"); // Append the text after the icon
                                                friendRequestHeaderStatus.append(friendRequestStatusIcon); // Add the icon first
                                                break;
                                        }
                                        friendRequestHeader.append(friendRequestHeaderMessageText, friendRequestHeaderUsername, friendRequestHeaderStatus);
                                        messageText.append(friendRequestHeader);
                                    }
                                    // recived friend request
                                    else {
                                        messageText = $("<div>", {
                                            class: "friend-request",
                                        });
                                        var friendRequestHeader = $("<div>", {
                                            class: "friend-request-header",
                                        });
                                        var friendRequestHeaderMessageText = $("<p>", {
                                            class: "message-text",
                                        });
                                        var friendRequestIcon = $("<span>", {
                                            class: "icon fa-solid fa-user-group", // This class will be used to display the icon
                                        });
                                        friendRequestHeaderMessageText.append(friendRequestIcon)
                                        friendRequestHeaderMessageText.append("Friend Request From");
                                        var friendRequestHeaderUsername = $("<p>", {
                                            class: "username",
                                        });
                                        var friendRequestHeaderHr = $("<hr/>");
                                        friendRequestHeaderUsername.text($("#MessageDialogeModalHeading").text());
                                        var friendRequestBtnDiv = $("<div>", {
                                            class: "friend-request-btn-div",
                                        });
                                        friendRequestHeader.append(friendRequestHeaderMessageText, friendRequestHeaderUsername);
                                        messageText.append(friendRequestHeader, friendRequestHeaderHr, friendRequestBtnDiv);

                                        switch (message.IsAccepted) {
                                            case null:
                                                // pending so display buttons
                                                var friendRequestDeclineBtn = $("<button>", {
                                                    type: "button",
                                                    class: "Btn Btn-secondary",
                                                });
                                                friendRequestDeclineBtn.text("decline");
                                                var friendRequestAcceptBtn = $("<button>", {
                                                    type: "button",
                                                    class: "Btn Btn-primary",
                                                });
                                                friendRequestAcceptBtn.text("accept");
                                                friendRequestBtnDiv.append(friendRequestDeclineBtn, friendRequestAcceptBtn);

                                                // Add event handlers to the buttons
                                                friendRequestDeclineBtn.on("click", function () {
                                                    handleFriendRequest(recipientId, 0, message.MessageId, messageText);

                                                });

                                                friendRequestAcceptBtn.on("click", function () {
                                                    handleFriendRequest(recipientId, 1, message.MessageId, messageText);
                                                });

                                                break;
                                            case false:
                                                var friendRequestHeaderStatus = $("<p>", {
                                                    class: "status",
                                                });
                                                var friendRequestStatusIcon = $("<span>", {});
                                                friendRequestStatusIcon.addClass("status-icon fa-solid fa-xmark");
                                                friendRequestHeaderStatus.append("Declined"); // Append the text after the icon
                                                friendRequestHeaderStatus.append(friendRequestStatusIcon); // Add the icon first
                                                // Append the status to friendRequestHeader instead of friendRequestBtnDiv
                                                friendRequestHeader.append(friendRequestHeaderStatus);
                                                // Remove the <hr> element and friendRequestBtnDiv
                                                friendRequestHeader.next("hr").remove();
                                                friendRequestBtnDiv.remove();
                                                break;
                                            case true:
                                                var friendRequestHeaderStatus = $("<p>", {
                                                    class: "status",
                                                });
                                                var friendRequestStatusIcon = $("<span>", {});
                                                friendRequestStatusIcon.addClass("status-icon fa-solid fa-check");
                                                friendRequestHeaderStatus.append("Accepted"); // Append the text after the icon
                                                friendRequestHeaderStatus.append(friendRequestStatusIcon); // Add the icon first
                                                // Append the status to friendRequestHeader instead of friendRequestBtnDiv
                                                friendRequestHeader.append(friendRequestHeaderStatus);
                                                // Remove the <hr> element and friendRequestBtnDiv
                                                friendRequestHeader.next("hr").remove();
                                                friendRequestBtnDiv.remove();
                                                break;
                                        }
                                    }
                                    break;
                                    if (false) {
                                        //case 2:
                                        //    // game invite
                                        //    // sent game invite
                                        //    if (messageClass == "message sent") {
                                        //        messageText = $("<div>", {
                                        //            class: "game-invite",
                                        //        });
                                        //        var gameInviteHeader = $("<div>", {
                                        //            class: "game-invite-header",
                                        //        });
                                        //        var gameInviteHeaderMessageText = $("<p>", {
                                        //            class: "message-text",
                                        //        });
                                        //        gameInviteHeaderMessageText.text("Game Invite Sent To");
                                        //        var gameInviteHeaderUsername = $("<p>", {
                                        //            class: "username",
                                        //        });
                                        //        gameInviteHeaderUsername.text($("#MessageDialogeModalHeading").text());
                                        //        var gameInviteHeaderStatus = $("<p>", {
                                        //            class: "status",
                                        //        });
                                        //        switch (message.IsAccepted) {
                                        //            case null:
                                        //                gameInviteHeaderStatus.text("Pending");
                                        //                break;
                                        //            case 0:
                                        //                gameInviteHeaderStatus.text("Declined");
                                        //                break;
                                        //            case 1:
                                        //                gameInviteHeaderStatus.text("Accepted");
                                        //                break;
                                        //        }
                                        //        gameInviteHeader.append(gameInviteHeaderMessageText, gameInviteHeaderUsername, gameInviteHeaderStatus);
                                        //        messageText.append(gameInviteHeader);
                                        //    }
                                        //    // recived game invite
                                        //    else {
                                        //        messageText = $("<div>", {
                                        //            class: "game-invite",
                                        //        });
                                        //        var gameInviteHeader = $("<div>", {
                                        //            class: "game-invite-header",
                                        //        });
                                        //        var gameInviteHeaderMessageText = $("<p>", {
                                        //            class: "message-text",
                                        //        });
                                        //        gameInviteHeaderMessageText.text("Game Invite Sent To");
                                        //        var gameInviteHeaderUsername = $("<p>", {
                                        //            class: "username",
                                        //        });
                                        //        var gameInviteBtnDiv = $("<div>", {
                                        //            class: "game-invite-btn-div",
                                        //        });
                                        //        switch (message.IsAccepted) {
                                        //            case null:
                                        //                // pending so display buttons
                                        //                var gameInviteDeclineBtn = $("<button>", {
                                        //                    class: "Btn Btn-secondary",
                                        //                });
                                        //                gameInviteDeclineBtn.text("decline");
                                        //                var gameInviteAcceptBtn = $("<button>", {
                                        //                    class: "Btn Btn-primary",
                                        //                });
                                        //                gameInviteAcceptBtn.text("accept");
                                        //                gameInviteBtnDiv.append(gameInviteDeclineBtn, gameInviteAcceptBtn);
                                        //                break;
                                        //            case 0:
                                        //                // declined so display declined
                                        //                var gameInviteStatus = $("<p>", {
                                        //                    class: "status",
                                        //                });
                                        //                gameInviteStatus.text("declined");
                                        //                gameInviteBtnDiv.append(gameInviteStatus)
                                        //                break;
                                        //            case 1:
                                        //                // accepted so display accepted
                                        //                var gameInviteStatus = $("<p>", {
                                        //                    class: "status",
                                        //                });
                                        //                gameInviteStatus.text("accepted");
                                        //                gameInviteBtnDiv.append(gameInviteStatus)
                                        //                break;
                                        //        }
                                        //        gameInviteHeader.append(gameInviteHeaderMessageText, gameInviteHeaderUsername, gameInviteBtnDiv);
                                        //        messageText.append(gameInviteHeader);
                                        //    }
                                        //    break;
                                    }
                            }


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
                        scrollToBottom();

                    } else {
                        console.log("No messages found between users.");
                    }
                },
                error: function (error) {
                    console.log("Error retrieving messages between users: " + error);
                }
            });
        }

        // Scroll to the bottom of the messageDialogeDivParent
        function scrollToBottom() {
            var messageContainer = document.getElementById("messageDialogeDivParent");
            messageContainer.scrollTop = messageContainer.scrollHeight - messageContainer.clientHeight;
        }

        // Create a mutationObserver to watch for changes in the messageDialogeDiv
        var messageContainer = document.getElementById("messageDialogeDivParent");
        var observer = new MutationObserver(scrollToBottom);

        // Configuration of the observer:
        var config = { childList: true, subtree: true };

        // Start observing the target node for configured mutations
        observer.observe(messageContainer, config);
        observer.disconnect();

        // event handler for when a user clicks a button on the friend request
        function handleFriendRequest(recipientId, isAccepted, messageId, messageText) {
            $.ajax({
                type: "POST",
                url: "Messages.aspx/HandleFriendRequest",
                data: JSON.stringify({ recipientId: recipientId, isAccepted: isAccepted, messageId: messageId }), // Pass recipientId and decision to the server
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (isAccepted === 1) {
                        console.log("Friend request accepted successfully.");
                        // You can perform additional actions here after the friend request is accepted
                        messageText.find("hr").remove();
                        messageText.find(".friend-request-btn-div").remove();


                        // Add the status to friendRequestHeader
                        var friendRequestHeader = messageText.find(".friend-request-header");
                        var friendRequestHeaderStatus = $("<p>", {
                            class: "status",
                        });
                        var friendRequestStatusIcon = $("<span>", {});
                        friendRequestStatusIcon.addClass("status-icon fa-solid fa-check");
                        friendRequestHeaderStatus.append("Accepted"); // Append the text after the icon
                        friendRequestHeaderStatus.append(friendRequestStatusIcon); // Add the icon first
                        // Append the status to friendRequestHeader instead of friendRequestBtnDiv
                        friendRequestHeader.append(friendRequestHeaderStatus);

                    } else if (isAccepted === 0) {
                        console.log("Friend request declined successfully.");
                        // You can perform additional actions here after the friend request is declined
                        messageText.find("hr").remove();
                        messageText.find(".friend-request-btn-div").remove();


                        // Add the status to friendRequestHeader
                        var friendRequestHeader = messageText.find(".friend-request-header");
                        var friendRequestHeaderStatus = $("<p>", {
                            class: "status",
                        });
                        var friendRequestStatusIcon = $("<span>", {});
                        friendRequestStatusIcon.addClass("status-icon fa-solid fa-xmark");
                        friendRequestHeaderStatus.append("Declined"); // Append the text after the icon
                        friendRequestHeaderStatus.append(friendRequestStatusIcon); // Add the icon first
                        // Append the status to friendRequestHeader instead of friendRequestBtnDiv
                        friendRequestHeader.append(friendRequestHeaderStatus);
                    }
                },
                error: function (error) {
                    console.log("Error handling friend request: " + error);
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
            $.ajax({
                type: "POST",
                url: "Messages.aspx/SearchUsers",
                data: JSON.stringify({ searchText: searchText }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {

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
                                class: "Btn friend",
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
                    console.log("Error: " + errorThrown);
                }
            });
        }

        // Function to handle tile click event

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
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var newMessage = '<div class="message sent">' +
                '<img src="<%=((Chess_App.PlayerAccount)Session["AccountInfo"]).ProfilePictureString%>" style="width: 4rem; height: 4rem; object-fit: cover; border-radius: 4px;"/>' +
                        '<p class="message-text">' + message + '</p>' +
                '<p class="message-time"><b><%=((Chess_App.PlayerAccount)Session["AccountInfo"]).Username%> </b>' + getCurrentTimeFormatted() + '</p>' +
                        '</div>';
                    $('.message-dialoge').append(newMessage);
                    // Get the container element
                    var messageContainer = document.getElementById("messageDialogeDivParent");

                    // Check if the user is near the bottom before scrolling
                    if (isUserNearBottom(messageContainer)) {
                        console.log('User is near the bottom. Scrolling to bottom...');
                        scrollToBottom(messageContainer);

                        // Create the MutationObserver if it doesn't exist
                        if (!messageContainer.observer) {
                            var observer = new MutationObserver(scrollToBottom);

                            // Configuration of the observer:
                            var config = { childList: true, subtree: true };

                            // Start observing the target node for configured mutations
                            observer.observe(messageContainer, config);

                            // Store the observer as a property of the messageContainer
                            messageContainer.observer = observer;
                        }
                    } else {
                        console.log('User is not near the bottom.');
                        // If the user is not near the bottom, disconnect the observer if it's connected
                        if (messageContainer.observer) {
                            messageContainer.observer.disconnect();
                            messageContainer.observer = null;
                            console.log('Observer disconnected.');
                        }
                    }
                },
                error: function (error) {
                    console.error('Error sending the message:', error);
                }
            });

            // Optionally, you can clear the message input after sending the message
            $("#messagePromptInp").val("");
        }

        function isUserNearBottom(container) {
            var buffer = 600; // Adjust this value as needed, it represents how close to the bottom the user should be considered "near"
            var isNearBottom = container.scrollHeight - container.clientHeight - container.scrollTop <= buffer;

            console.log("isNearBottom:", isNearBottom); // Log the value to the console for debugging

            return isNearBottom;
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
