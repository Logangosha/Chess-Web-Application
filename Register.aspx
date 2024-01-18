<%@ Page Language="C#" Title="Register" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Chess_App.Register" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row p-0 overflow-auto hidden-scroll-bar h-100 MainCard">
        <div class="col d-flex flex-column align-items-center justify-content-center overflow-auto pt-5">
            <div class="d-grid text-center flex-column">
            <h1 class="h1-landing-sm">REGISTER</h1>
            </div>
            <div class="register-form d-grid text-center flex-column gap-3">
                <h2>Complete to continue</h2>
                <p id="ErrorLbl" class="m-0 d-none" style="color:red;"></p>
                <div class="bordered-icon-textbox">
                    <asp:TextBox runat="server" ID="UnameTbx" oninput="UnameTbxOnInput()" CssClass="textbox" placeholder="Username" TextMode="SingleLine"></asp:TextBox>
                    <i id="UnameTbxIcon" class="icon fa-regular fa-square-check"></i>
                </div>
                <div class="bordered-icon-textbox">
                    <asp:TextBox runat="server" ID="EmailTbx" oninput="EmailTbxOnInput()" CssClass="textbox" placeholder="Email" TextMode="SingleLine"></asp:TextBox>
                    <i id="EmailTbxIcon" class="icon fa-regular fa-square-check"></i>
                </div>
                <div class="bordered-icon-textbox">
                    <asp:TextBox runat="server" ID="PasswordTbx" oninput="PasswordTbxOnInput()" CssClass="textbox" placeholder="Password" TextMode="Password"></asp:TextBox>
                    <i id="PasswordTbxIcon" class="icon fa-regular fa-square-check"></i>
                </div>
                <div class="bordered-icon-textbox">
                    <asp:TextBox runat="server" ID="ConfirmPasswordTbx" oninput="ConfirmPasswordTbxOnInput()" CssClass="textbox" placeholder="Confirm Password" TextMode="Password"></asp:TextBox>
                    <i id="ConfirmPasswordTbxIcon" class="icon fa-regular fa-square-check"></i>
                </div>
                <%--<asp:CompareValidator runat="server" ID="ErrorLbl" ControlToCompare="ConfirmPasswordTbx" ControlToValidate="PasswordTbx" CssClass="align-items-start" ErrorMessage="Passwords do not match." ForeColor="Red" Display="Dynamic"></asp:CompareValidator>--%>
                <asp:Button runat="server" ID="CreateAccountBtn" OnClick="CreateAccountBtn_Click" disabled CssClass="Btn Btn-primary Btn-toggle my-3 Btn-disabled" Text="Create Account" />
            </div>
        </div>
    </div>
    <script type="text/javascript">
        const UnameTbx = document.getElementById('<%=UnameTbx.ClientID%>')
        const EmailTbx = document.getElementById('<%=EmailTbx.ClientID%>');
        const PasswordTbx = document.getElementById('<%=PasswordTbx.ClientID%>');
        const ConfirmPasswordTbx = document.getElementById('<%=ConfirmPasswordTbx.ClientID%>');
        const CreateAccountBtn = document.getElementById('<%=CreateAccountBtn.ClientID%>');
        let isUsernameValid = false;
        let isEmailValid = false;
        let isPasswordValid = false;
        let isConfirmPasswordValid = false;

        async function UnameTbxOnInput() {
            //alert("UnameTbxOnInput()")
            try {
                await checkUsernameAsync();
                // Code here will execute after the username check is complete
            } catch (error) {
                // Handle errors here
                console.error(error);
            }
            myScript();
        }

        async function EmailTbxOnInput() {
            try {
                await checkEmailAsync();
                // Code here will execute after the email check is complete
            } catch (error) {
                // Handle errors here
                console.error(error);
            }
            myScript();
        }

        function PasswordTbxOnInput() {
            checkPassword();
            myScript();
        }

        function ConfirmPasswordTbxOnInput() {
            checkConfirmPassword();
            myScript();
        }

        function DisplayError(error) {
            /*alert("DisplayError()")*/
            ErrorLbl.classList.remove('d-none');
            ErrorLbl.innerHTML = error;
        }

        function RemoveError() {
            /*alert("RemoveError()")*/
            ErrorLbl.classList.add('d-none');
            ErrorLbl.innerHTML = "";
        }

        function myScript() {
            console.log("myScript Validation");
            console.log("isUsernameValid " + isUsernameValid);
            console.log("isEmailValid " + isEmailValid);
            console.log("isPassword Valid" + isPasswordValid);
            console.log("isConfirmPasswordValid " + isConfirmPasswordValid);
            if (isUsernameValid && isEmailValid && isPasswordValid && isConfirmPasswordValid) {
                CreateAccountBtn.classList.remove('Btn-disabled')
                CreateAccountBtn.disabled = false;
            }
            else {
                CreateAccountBtn.classList.add('Btn-disabled')
                CreateAccountBtn.disabled = true;
            }
        }

        function checkPassword() {
            isPasswordValid = false;
            PasswordTbxIcon.classList.remove("fa-solid");
            PasswordTbxIcon.classList.add("fa-regular");
            if (PasswordTbx.value.length == 0) {
                DisplayError("Password must be at least 1 character long.")
                checkConfirmPassword();
            }
            else {
                isPasswordValid = true;
                RemoveError();
                PasswordTbxIcon.classList.add("fa-solid");
                PasswordTbxIcon.classList.remove("fa-regular");
                checkConfirmPassword();
            }
        }

        function checkConfirmPassword() {
            isConfirmPasswordValid = false;
            ConfirmPasswordTbxIcon.classList.remove("fa-solid");
            ConfirmPasswordTbxIcon.classList.add("fa-regular");
            if (PasswordTbx.value != ConfirmPasswordTbx.value) {
                DisplayError("Passwords do not match.")
            }
            else if (ConfirmPasswordTbx.value.length == 0) {
                DisplayError("Confirm Password must be at least 1 character long.")
            }
            else {
                RemoveError();
                isConfirmPasswordValid = true;
                ConfirmPasswordTbxIcon.classList.add("fa-solid");
                ConfirmPasswordTbxIcon.classList.remove("fa-regular");
            }
        }

        // ajax call to check if username is taken
        function checkUsernameAsync() {
            return new Promise(function (resolve, reject) {
                console.log("running CheckUsername()");
                isUsernameValid = false;
                UnameTbxIcon.classList.add("fa-regular");
                UnameTbxIcon.classList.remove("fa-solid");

                if (UnameTbx.value.length == 0) {
                    DisplayError("Username must be at least 1 character long.")
                    reject("Username must be at least 1 character long.");
                } else {
                    $.ajax({
                        type: "POST",
                        url: "Register.aspx/CheckUsername",
                        data: JSON.stringify({ username: UnameTbx.value }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            if (response.d == true) {
                                DisplayError("Username Is taken.")
                                reject("Username Is taken.");
                            } else {
                                console.log("setting isUsernameValid to true");
                                isUsernameValid = true;
                                UnameTbxIcon.classList.add("fa-solid");
                                UnameTbxIcon.classList.remove("fa-regular");
                                RemoveError();
                                resolve();
                            }
                        },
                        error: function (response) {
                            reject("Error occurred during username check.");
                        }
                    });
                }
            });
        }

        function validateEmail(email) {
            // Regular expression for a basic email validation
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

            return emailRegex.test(email);
        }

        // ajax call to check if email is taken
        function checkEmailAsync() {
            return new Promise(function (resolve, reject) {
                isEmailValid = false;
                EmailTbxIcon.classList.add("fa-regular");
                EmailTbxIcon.classList.remove("fa-solid");

                if (validateEmail(EmailTbx.value) && EmailTbx.value.length > 3) {
                    $.ajax({
                        type: "POST",
                        url: "Register.aspx/CheckEmail",
                        data: JSON.stringify({ email: EmailTbx.value }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            console.table(response)
                            if (response.d == true) {
                                DisplayError("Email Is taken.")
                                reject("Email Is taken.");
                            } else {
                                isEmailValid = true;
                                EmailTbxIcon.classList.add("fa-solid");
                                EmailTbxIcon.classList.remove("fa-regular");
                                RemoveError();
                                resolve();
                            }
                        },
                        error: function (response) {
                            reject("Error occurred during email check.");
                        }
                    });
                } else {
                    DisplayError("Email is not valid");
                    reject("Email is not valid");
                }
            });
        }
    </script>
</asp:Content>
