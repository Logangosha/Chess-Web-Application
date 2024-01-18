<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Account.aspx.cs" Inherits="Chess_App.Account" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row p-0 justify-content-center h-100 MainCard overflow-scroll hidden-scroll-bar">
        <div class="col-auto col-lg-7 col-xl-5 py-4 p-0 justify-content-center my-auto align-items-center">
            <div class="profile-body p-0 px-4 d-flex flex-column">
                <div>
                    <div class="profile-img-container">
                        <img runat="server" id="profileImg" class="profile-img" />
                    </div>
                    <h1 class="mt-3 h1-landing-sm text-break"><%=((Chess_App.PlayerAccount)Session["AccountInfo"]).Username %></h1>
                </div>
                <hr />
                <button type="button" class="Btn Btn-link" data-bs-toggle="modal" data-bs-target="#ChangeThemeModal">
                    <i class="Btn-link-icon fa-solid fa-palette"></i>
                    <p class="Btn-link-text">Change Theme</p>
                        <i class="fa-solid fa-arrow-right Btn-link-arrow"></i>
                </button>
                <button type="button" class="Btn Btn-link" data-bs-toggle="modal" data-bs-target="#EditAccountModal">
                    <i class="Btn-link-icon fa-solid fa-pen"></i>
                    <p class="Btn-link-text">Edit Account</p>
                        <i class="fa-solid fa-arrow-right Btn-link-arrow"></i>
                </button>
                <button type="button" class="Btn Btn-link" data-bs-toggle="modal" data-bs-target="#ChangePasswordModal">
                    <i class="Btn-link-icon fa-solid fa-lock"></i>
                    <p class="Btn-link-text">Change Password</p>
                        <i class="fa-solid fa-arrow-right Btn-link-arrow"></i>
                </button>
                <button text="Modal" type="button" class="Btn Btn-link" data-bs-toggle="modal" data-bs-target="#DeleteAccountModal">
                    <i class="Btn-link-icon fa-solid fa-trash"></i>
                    <p class="Btn-link-text">Delete Account</p>
                        <i class="fa-solid fa-arrow-right Btn-link-arrow"></i>
                </button>
                <button runat="server" id="signOutBtn" onserverclick="SignOutBtn_Click" type="button"  class="Btn Btn-link">
                    <i class="Btn-link-icon fa fa-sign-out"></i>
                    <p class="Btn-link-text">Sign Out</p>
                        <i class="fa-solid fa-arrow-right Btn-link-arrow"></i>
                </button>
                <asp:LinkButton runat="server" ID="goHomeBtn" OnClick="goHomeBtn_Click" CssClass="Btn Btn-primary Btn-large mt-2">
                    <span class="pe-2 fa-solid fa-house"></span>
                    Go Home
                </asp:LinkButton>
            </div>
        </div>
    </div>
    <!-- Modals -->
    <!-- ChangeTheme -->
    <div class="modal fade" id="ChangeThemeModal" tabindex="-1" aria-labelledby="ChangeThemeModal" aria-hidden="true">
        <div class="modal-dialog modal-fullscreen">
            <div class="modal-content">
                <div class="modal-head">
                    <i class="fa-solid fa-palette modal-icon my-auto"></i>
                    <h1 class="modal-title">Change Theme
                    </h1>
                    <button type="button" onclick="CancleChangeTheme()" class="Btn Btn-secondary modal-close pe-0" data-bs-dismiss="modal"><i class="fa-solid fa-xmark"></i></button>
                </div>
                <hr />
                <div class="modal-body my-auto gap-2">
                    <div class="row p-0 justify-content-center h-100 MainCard overflow-scroll hidden-scroll-bar">
                        <div class="col-auto py-4 p-0 justify-content-center my-auto align-items-center">
                            <div class="mb-4">
                                <h1 class="h1-landing">Select Colors</h1>
                            </div>
                            <div>
                                <p class="p-bg my-2 d-block">Primary Color</p>
                                <div class="d-flex justify-content-center align-items-center">
                                    <i class="primary-color-picker-icon color-picker-icon fa-solid fa-paintbrush"></i>
                                    <input runat="server" id="primaryColor" type="color" class="color-picker">
                                </div>
                            </div>
                            <div>
                                <p class="p-bg my-2 d-block">Background Color</p>
                                <div class="d-flex justify-content-center align-items-center">
                                    <i class="background-color-picker-icon  color-picker-icon fa-solid fa-paintbrush"></i>
                                    <input runat="server" id="backgroundColor" type="color" class="color-picker" />
                                </div>
                            </div>
                            <div>
                                <p class="p-bg my-2 d-block">Status Color</p>
                                <div class="d-flex justify-content-center align-items-center">
                                    <i class="background-color-picker-icon  color-picker-icon fa-solid fa-paintbrush"></i>
                                    <input runat="server" id="statusColor" type="color" class="color-picker" />
                                </div>
                            </div>
                            <div class="d-flex justify-content-center">
                                <button class="Btn Btn-secondary"><i class="fa-solid fa-book"></i></></button>
                                <button type="button" class="Btn Btn-secondary ps-0" onclick="generateRandomTheme()">
                                    Randomize <i class="fa-solid fa-shuffle"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <hr />
                <div class="modal-footer">
                    <button type="button" onclick="CancleChangeTheme()" class="Btn Btn-secondary ps-0" data-bs-dismiss="modal">
                        Cancle
                    </button>
                    <asp:Button runat="server" OnClick="ChangeThemeSaveBtn_Click" ID="ChangeThemeSaveBtn" type="button" class="Btn Btn-primary ms-auto" Text="Save"></asp:Button>
                    <script defer>
                        console.log("<%=((Chess_App.PlayerAccount)HttpContext.Current.Session["AccountInfo"]).ProfilePictureString%>");
                        const accountPrimaryColor = "<%=((Chess_App.PlayerAccount)Session["AccountInfo"]).Theme.PrimaryColor%>";
                        const accountBackgroundColor = "<%=((Chess_App.PlayerAccount)Session["AccountInfo"]).Theme.BackgroundColor%>";
                        const accountStatusColor = "<%=((Chess_App.PlayerAccount)Session["AccountInfo"]).Theme.StatusColor%>";
                        const primaryColorPicker = document.getElementById("<%=primaryColor.ClientID%>");
                        const backgroundColorPicker = document.getElementById("<%=backgroundColor.ClientID%>");
                        const statusColorPicker = document.getElementById("<%=statusColor.ClientID%>");
                    </script>
                </div>
            </div>
        </div>
    </div>
    <!--/ChangeTheme-->
    <!-- EditAccount -->
    <div class="modal fade" id="EditAccountModal" tabindex="-1" aria-labelledby="EditAccountModal" aria-hidden="true">
        <div class="modal-dialog modal-fullscreen">
            <div class="modal-content">
                <div class="modal-head">
                    <i class="fa-solid fa-pen modal-icon my-auto"></i>
                    <h1 class="modal-title">Edit Account
                    </h1>
                    <button type="button" class="Btn Btn-secondary modal-close pe-0" data-bs-dismiss="modal"><i class="fa-solid fa-xmark"></i></button>
                </div>
                <hr />
                <div class="modal-body my-auto gap-2">
                    <div class="row p-0 justify-content-center h-100 MainCard overflow-scroll hidden-scroll-bar">
                        <div class="col-auto py-4 p-0 justify-content-center my-auto align-items-center">
                            <div class="mb-4">
                                <h1 class="h1-landing">Account Info</h1>
                            </div>
                            <div class="d-flex flex-column gap-2">
                                <div class="icon-textbox">
                                    <input runat="server" type="file" class="file-input" title="Choose Profile Picture" id="fileInput">
                                    <i class="icon fa-regular fa-file-image"></i>
                                </div>
                                <div class="icon-textbox mb-2">
                                    <input runat="server" id="usernameTbx" class="textbox" placeholder="Username" />
                                    <i id="usernameIcon" class="icon fa-solid fa-user-large-slash"></i>
                                </div>
                                <div class="icon-textbox">
                                    <input runat="server" id="emailTbx" class="textbox" placeholder="Email" />
                                    <i id="emailIcon" class="icon fa-regular fa-envelope"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <hr />
                <div class="modal-footer">
                    <button type="button" class="Btn Btn-secondary ps-0" data-bs-dismiss="modal">
                        Cancle
                    </button>
                    <asp:Button runat="server" ID="EditAccountInfoSaveBtn" OnClick="EditAccountInfoSaveBtn_Click" type="button" class="Btn Btn-disabled Btn-primary ms-auto" Text="Save"></asp:Button>
                    <script defer>
                        const saveBtn = document.getElementById("<%=EditAccountInfoSaveBtn.ClientID%>");
                        const _usernameIcon = document.getElementById("usernameIcon");
                        const _emailIcon = document.getElementById("emailIcon");
                        const _usernameTbx = document.getElementById("<%=usernameTbx.ClientID%>");
                        const emailTbx = document.getElementById("<%=emailTbx.ClientID%>");
                        const fileInput = document.getElementById("<%=fileInput.ClientID%>");
                        saveBtn.disabled = true;
                        var usernameStatus = false;
                        var emailStatus = false;
                        var profilePictureStatus = false;


                        _usernameTbx.addEventListener("keyup", function () { isUsernameValid(_usernameTbx.value) });
                        emailTbx.addEventListener("keyup", function () { isEmailValid(emailTbx.value) });
                        fileInput.addEventListener("change", isProfilePictureValid);

                        // Check the overall validation status and enable/disable the save button
                        function checkEditAccountValidation() {
                            console.log("checking validation");
                            saveBtn.classList.remove("Btn-disabled");
                            if (!usernameStatus && !emailStatus && !profilePictureStatus) {
                                saveBtn.disabled = true; // Disable the button
                                saveBtn.classList.add("Btn-disabled");
                            } else {
                                saveBtn.disabled = false; // Enable the button
                            }
                        }

                        // Check if the Profile Picture is valid
                        function isProfilePictureValid() {
                            const file = fileInput.files[0];
                            const fileType = file['type'];
                            const validImageTypes = ['image/gif', 'image/jpeg', 'image/png', 'image/jpg'];
                            const maxSize = 200 * 1024; // 200KB in bytes

                            if (validImageTypes.includes(fileType) && file.size <= maxSize) {
                                profilePictureStatus = true;
                            }
                            else {
                                profilePictureStatus = false;
                                fileInput.value = '';
                                alert('Please upload a valid image file (jpeg, jpg, png, or gif) under 200KB.');
                            }

                            checkEditAccountValidation();
                        }

                        // Check if the username is valid
                        async function isUsernameValid(username) {
                            console.log("Username is " + username);
                            let startingUsername = (username == "<%=((Chess_App.PlayerAccount)Session["AccountInfo"]).Username%>")
                            console.log('test1');
                            const isValid = (username !== '' && await isUsernameTaken(username) == false && startingUsername == false);
                            console.log('test2');
                            _usernameIcon.classList.toggle("fa-user", isValid);
                            console.log('test3');
                            _usernameIcon.classList.toggle("fa-user-large-slash", !isValid);
                            console.log('test4');
                            console.log("Username is valid: " + isValid);
                            console.log('test5');
                            usernameStatus = isValid;
                            console.log('test6');
                            checkEditAccountValidation();
                        }

                        // Check if the email is valid 
                        async function isEmailValid(email) {
                            const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                            let startingEmail = (email == "<%=((Chess_App.PlayerAccount)Session["AccountInfo"]).Email%>")
                            const isValid = (emailPattern.test(email) && await isEmailTaken(email) == false && startingEmail == false);
                            _emailIcon.classList.toggle("fa-solid", isValid);
                            _emailIcon.classList.toggle("fa-regular", !isValid);
                            console.log("Email is valid: " + isValid);
                            emailStatus = isValid;
                            checkEditAccountValidation();
                        }


                        // Function to check the availability of a username
                        function isUsernameTaken(username) {
                            return new Promise((resolve, reject) => {
                                $.ajax({
                                    type: "POST",
                                    url: "Account.aspx/IsUsernameTaken",
                                    data: JSON.stringify({ username: username }),
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: function (response) {
                                        console.log("response.d " + response.d);
                                        console.log("Username is", response.d ? "already taken" : "available");
                                        resolve(response.d);
                                    },
                                    error: function (xhr, status, error) {
                                        console.log(error);
                                        reject(error);
                                    }
                                });
                            });
                        }

                        // Function to check the availability of an email
                        function isEmailTaken(email) {
                            return new Promise((resolve, reject) => {
                                $.ajax({
                                    type: "POST",
                                    url: "Account.aspx/IsEmailTaken",
                                    data: JSON.stringify({ email: email }),
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: function (response) {
                                        console.log("Email is", response.d ? "already taken" : "available");
                                        resolve(response.d);
                                    },
                                    error: function (xhr, status, error) {
                                        console.log(error);
                                        reject(error);
                                    }
                                });
                            });
                        }

                    </script>
                </div>
            </div>
        </div>
    </div>
    <!--/EditAccount-->
    <!-- ChangePassword -->
    <div class="modal fade" id="ChangePasswordModal" tabindex="-1" aria-labelledby="ChangePasswordModal" aria-hidden="true">
        <div class="modal-dialog modal-fullscreen">
            <div class="modal-content">
                <div class="modal-head">
                    <i class="fa-solid fa-lock modal-icon my-auto"></i>
                    <h1 class="modal-title">Change Password
                    </h1>
                    <button type="button" class="Btn Btn-secondary modal-close pe-0" data-bs-dismiss="modal"><i class="fa-solid fa-xmark"></i></button>
                </div>
                <hr />
                <div class="modal-body my-auto gap-2">
                    <div class="row p-0 justify-content-center h-100 MainCard overflow-scroll hidden-scroll-bar">
                        <div class="col-auto py-4 p-0 justify-content-center my-auto align-items-center">
                            <div class="mb-4">
                                <h1 class="h1-landing mb-4">Change Password</h1>
                                <h2>Passwords Must Match</h2>
                            </div>
                            <div>
                                <div class="bordered-icon-textbox">
                                    <asp:TextBox runat="server" ID="oldPasswordTbx" CssClass="textbox" placeholder="Old Password" TextMode="Password"></asp:TextBox>
                                    <i id="oldPasswordIcon" class="icon fa-regular fa-square-check"></i>
                                </div>
                            </div>
                            <div>
                                <div class="bordered-icon-textbox">
                                    <asp:TextBox runat="server" ID="newPasswordTbx" CssClass="textbox" placeholder="New Password" TextMode="Password"></asp:TextBox>
                                    <i id="newPasswordIcon" class="icon fa-regular fa-square-check"></i>

                                </div>
                            </div>
                            <div>
                                <div class="bordered-icon-textbox">
                                    <asp:TextBox runat="server" ID="confirmPasswordTbx" CssClass="textbox" placeholder="Confirm Password" TextMode="Password"></asp:TextBox>
                                    <i id="confirmPasswordIcon" class="icon fa-regular fa-square-check"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <hr />
                <div class="modal-footer">
                    <button type="button" class="Btn Btn-secondary ps-0" data-bs-dismiss="modal">
                        Cancle
                    </button>
                    <asp:Button runat="server" ID="changePasswordSaveBtn" OnClick="changePasswordSaveBtn_Click" type="button" class="Btn Btn-disabled Btn-primary ms-auto" Text="Save"></asp:Button>
                    <script defer>
                        const oldPasswordTbx = document.getElementById("<%=oldPasswordTbx.ClientID%>");
                        const oldPasswordIcon = document.getElementById("oldPasswordIcon");
                        const newPasswordTbx = document.getElementById("<%=newPasswordTbx.ClientID%>");
                        const newPasswordIcon = document.getElementById("newPasswordIcon");
                        const confirmPasswordTbx = document.getElementById("<%=confirmPasswordTbx.ClientID%>");
                        const confirmPasswordIcon = document.getElementById("confirmPasswordIcon");
                        const changePasswordSaveBtn = document.getElementById("<%=changePasswordSaveBtn.ClientID%>");
                        const passwordStatus = {
                            old: false,
                            new: false,
                            confirm: false
                        }

                        oldPasswordTbx.addEventListener("keyup", function () {
                            validatePasswords("old", oldPasswordTbx.value);
                        });
                        newPasswordTbx.addEventListener("keyup", function () {
                            validatePasswords("new", newPasswordTbx.value);
                            checkConfirmPassword();
                        });
                        confirmPasswordTbx.addEventListener("keyup", function () {
                            validatePasswords("confirm", confirmPasswordTbx.value);
                        });

                        function isOldPasswordCorrect() {
                            return new Promise((resolve, reject) => {
                                $.ajax({
                                    type: "POST",
                                    url: "Account.aspx/IsOldPasswordCorrect",
                                    data: JSON.stringify({ username: "<%=((Chess_App.PlayerAccount)Session["AccountInfo"]).Username%>", password: oldPasswordTbx.value }),
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: function (response) {
                                        resolve(response.d);
                                    },
                                    failure: function (response) {
                                        reject(response.d);
                                    },
                                    error: function (error) {
                                        reject(error);
                                    }
                                });
                            });
                        }

                        function checkChangePasswordValidation() {
                            changePasswordSaveBtn.classList.remove("Btn-disabled");
                            if (!passwordStatus.old && !passwordStatus.new && !passwordStatus.confirm) {
                                changePasswordSaveBtn.classList.add("Btn-disabled");
                            }
                        }


                        function checkConfirmPassword() {
                            if (newPasswordTbx.value !== confirmPasswordTbx.value) {
                                confirmPasswordIcon.classList.add("fa-regular");
                                confirmPasswordIcon.classList.remove("fa-solid");
                                passwordStatus.confirm = false;
                            } else {
                                confirmPasswordIcon.classList.add("fa-solid");
                                confirmPasswordIcon.classList.remove("fa-regular");
                                passwordStatus.confirm = true;
                            }
                            checkChangePasswordValidation();
                        }

                        async function validatePasswords(feild, value) {
                            switch (feild) {
                                case "old":
                                    let _isOldPasswordCorrect = await isOldPasswordCorrect(value);
                                    if (value === "" || _isOldPasswordCorrect === false) {
                                        oldPasswordIcon.classList.add("fa-regular");
                                        oldPasswordIcon.classList.remove("fa-solid");
                                        passwordStatus.old = false;
                                    }
                                    else {
                                        oldPasswordIcon.classList.add("fa-solid");
                                        oldPasswordIcon.classList.remove("fa-regular");
                                        passwordStatus.old = true;
                                    };
                                    break;
                                case "new":
                                    if (value === "" || value === oldPasswordTbx.value) {
                                        newPasswordIcon.classList.add("fa-regular");
                                        newPasswordIcon.classList.remove("fa-solid");
                                        passwordStatus.new = false;
                                    }
                                    else {
                                        newPasswordIcon.classList.add("fa-solid");
                                        newPasswordIcon.classList.remove("fa-regular");
                                        passwordStatus.new = true;
                                    };
                                    break;
                                case "confirm":
                                    if (value === "" || value != newPasswordTbx.value) {
                                        confirmPasswordIcon.classList.add("fa-regular");
                                        confirmPasswordIcon.classList.remove("fa-solid");
                                        passwordStatus.confirm = false;
                                    }
                                    else {
                                        confirmPasswordIcon.classList.add("fa-solid");
                                        confirmPasswordIcon.classList.remove("fa-regular");
                                        passwordStatus.confirm = true;
                                    }
                                    break;
                                default:
                                    break;
                            }
                            checkChangePasswordValidation();
                        }
                    </script>
                </div>
            </div>
        </div>
    </div>
    <!--/ChangePassword-->
    <!-- DeleteAccount -->
    <div class="modal fade" id="DeleteAccountModal" tabindex="-1" aria-labelledby="DeleteAccountModal" aria-hidden="true">
        <div class="modal-dialog modal-fullscreen">
            <div class="modal-content">
                <div class="modal-head">
                    <i class="fa-solid fa-trash modal-icon my-auto"></i>
                    <h1 class="modal-title">Delete Account
                    </h1>
                    <button type="button" class="Btn Btn-secondary modal-close pe-0" data-bs-dismiss="modal"><i class="fa-solid fa-xmark"></i></button>
                </div>
                <hr />
                <div class="modal-body my-auto gap-2">
                    <span class="modal-icon fa fa-warning"></span>
                    <h1 class="modal-heading">DELETE</h1>
                    <h2 class="modal-subheading">Are you sure you want to <b>Delete your account</b>?<br />
                        Press <b>Delete</b> to delete your account.</h2>
                </div>
                <hr />
                <div class="modal-footer">
                    <button type="button" class="Btn Btn-secondary ps-0" data-bs-dismiss="modal">
                        Cancle
                    </button>
                    <asp:Button runat="server" OnClick="DeleteAccountModalBtn_Click" ID="DeleteAccountModalBtn" type="button" class="Btn Btn-primary ms-auto" Text="Delete"></asp:Button>
                    <script defer>

</script>
                </div>
            </div>
        </div>
    </div>
    <!--/DeleteAccount -->
</asp:Content>
