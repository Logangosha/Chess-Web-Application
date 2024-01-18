<%@ Page Language="C#" Title="Recover Account" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Recover.aspx.cs" Inherits="Chess_App.Recover" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row p-0 hidden-scroll-bar overflow-auto MainCard" style="height: 100vh;">
         <div class="col d-flex gap-3 flex-column align-items-center justify-content-center overflow-auto">
            <div id="RecoverForm" class="d-none text-center flex-column gap-3 overflow-auto">
                <h1 class="h1-landing-sm">RECOVER</h1>
                <h2 id="subheading">Enter account email<br></h2>
                <p id="email" class="p-bg d-none"><b><i>...</i></b></p>
                <asp:TextBox runat="server" TextMode="Email" ID="RecoverEmailTbx" oninput="emailTextChanged()" CssClass="w-100" placeholder="Enter Email"></asp:TextBox>
                <button id="ContinueBtn" type="button" OnClick="ValidateBeforeContinue()" class="Btn Btn-primary Btn-toggle Btn-disabled my-3">Continue</button>
            </div>
             <div id="ChangePasswordForm" class=" my-auto gap-2">
                    <div class="row p-0 justify-content-center h-100 MainCard overflow-scroll hidden-scroll-bar">
                        <div class="d-grid text-center flex-column gap-3 overflow-auto">
                            <div class="mb-4">
                                <h1 class="h1-landing-sm mb-4">Change Password</h1>
                                <h2>Passwords Must Match</h2>
                            </div>
                         <div>
                            <div class="bordered-icon-textbox">
                                <asp:TextBox runat="server" ID="newPasswordTbx" oninput="NewPasswordTbxOnInput()" CssClass="textbox" placeholder="New Password" TextMode="Password"></asp:TextBox>
                                <i id="newPasswordIcon" class="icon fa-regular fa-square-check"></i>

                            </div>
                            </div>
                            <div>
                                <div class="bordered-icon-textbox">
                                    <asp:TextBox runat="server" ID="confirmPasswordTbx" oninput="ConfirmPasswordTbxOnInput()" CssClass="textbox" placeholder="Confirm Password" TextMode="Password"></asp:TextBox>
                                    <i id="confirmPasswordIcon" class="icon fa-regular fa-square-check"></i>
                                </div>
                            </div>
                            <button ID="changePasswordSaveBtn"  OnClick="ChangePasswordBtnClick()" type="button" class="Btn Btn-disabled Btn-primary">Change Password</button>
                        </div>
                    </div>
                </div>
                    <script defer>
                        
                        //const oldPasswordIcon = document.getElementById("oldPasswordIcon");
                        const newPasswordTbx = document.getElementById("<%=newPasswordTbx.ClientID%>");
                        const newPasswordIcon = document.getElementById("newPasswordIcon");
                        const confirmPasswordTbx = document.getElementById("<%=confirmPasswordTbx.ClientID%>");
                        const confirmPasswordIcon = document.getElementById("confirmPasswordIcon");
                        const changePasswordSaveBtn = document.getElementById("changePasswordSaveBtn");
                        const passwordStatus = {
                            new: false,
                            confirm: false
                        }

                        function NewPasswordTbxOnInput() {
                            validatePasswords("new", newPasswordTbx.value);
                            checkConfirmPassword();
                        }

                        function ConfirmPasswordTbxOnInput()
                        {
                            validatePasswords("confirm", confirmPasswordTbx.value);

                        }


                        function checkChangePasswordValidation() {
                            console.log("passwordStatus.new && passwordStatus.confirm = " + passwordStatus.new + " and " + passwordStatus.confirm);
                            changePasswordSaveBtn.classList.remove("Btn-disabled");
                            if (!passwordStatus.new || !passwordStatus.confirm) {
                                changePasswordSaveBtn.classList.add("Btn-disabled");
                            }
                        }


                        function checkConfirmPassword() {
                            console.log("tvalue = " + (newPasswordTbx.value !== confirmPasswordTbx.value || confirmPasswordTbx.value === ""));
                            if (newPasswordTbx.value !== confirmPasswordTbx.value || confirmPasswordTbx.value === "") {
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
                            console.log("value = " +value);
                            switch (feild) {
                                case "new":
                                    if (value === "") {
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

                        function ChangePasswordBtnClick()
                        {
                            // ajax call to update password
                            $.ajax({
                                type: "POST",
                                url: "Recover.aspx/ChangePassword",
                                data: JSON.stringify({ password: newPasswordTbx.value, email: email }),
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (response) {
                                    alert("Password Changed Successfuly!");
                                    // take user to login page
                                    window.location.href = "Login.aspx";
                                },
                                error: function (response) {
                                }
                            });
                        }

                    </script>
        </div>
        </div>
    <script type="text/javascript">
        const RecoverForm = document.getElementById('RecoverForm');
        const ChangePasswordForm = document.getElementById('ChangePasswordForm');
        const RecoverEmailTbx = document.getElementById('<%=RecoverEmailTbx.ClientID%>');
        const ContinueBtn = document.getElementById('ContinueBtn');
        let email = null;
        let isCodeSent = false;
        let code = null;

        function emailTextChanged() {
            // This function will be called when the text in the email textbox changes
            if (isCodeSent) {
                if (RecoverEmailTbx.value.length > 0) {
                    ContinueBtn.classList.remove('Btn-disabled')
                    ContinueBtn.disabled = false;
                }
                else {
                    ContinueBtn.classList.add('Btn-disabled')
                    ContinueBtn.disabled = true;
                }
            }
            else {
                console.log("emailTextChanged");
                email = RecoverEmailTbx.value.toLowerCase();
                

                // Add your validation or other actions here
                let emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                let isValidEmail = emailRegex.test(email);

                if (isValidEmail) {
                    // remove the disabled class from the button
                    ContinueBtn.classList.remove('Btn-disabled')
                }
                else {
                    // add the disabled class to the button
                    ContinueBtn.classList.add('Btn-disabled')
                }
            }

        }

        function ValidateBeforeContinue() {
            if (isCodeSent) {
                VerifyRecoveryCode();
            }
            else {
                // the email is valid
                // change the subheading
                document.getElementById('subheading').innerHTML = 'A code has been sent to';
                // change the email paragraph
                document.getElementById('email').innerHTML = '<b><i>' + RecoverEmailTbx.value + '</i></b>';
                // show the email paragraph
                document.getElementById('email').classList.remove('d-none');
                // clear the email textbox
                RecoverEmailTbx.value = '';
                // change the placeholder of the email textbox
                RecoverEmailTbx.placeholder = 'Enter Code';
                // disable the continue button and change its text
                ContinueBtn.classList.add('Btn-disabled');
                ContinueBtn.textContent = "Submit Code";
                SendCode();
            }
            return true;
        }

        function SendCode()
        {
            isCodeSent = true;
            $.ajax({
                type: "POST",
                url: "Recover.aspx/SendRecoveryEmail",
                data: JSON.stringify({ email: email }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                },
                error: function (response) {
                }
            });
        }

        function VerifyRecoveryCode() {
            $.ajax({
                type: "POST",
                url: "Recover.aspx/VerifyRecoveryCode",
                data: JSON.stringify({ email: email, code: RecoverEmailTbx.value }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d)
                    {
                        // show the password reset form
                        ChangePasswordForm.classList.remove('d-none');
                        // hide recovery form
                        RecoverForm.classList.remove('d-grid');
                        RecoverForm.classList.add('d-none');
                    }
                    else
                    {
                        alert("code is incorrect!");
                    }
                },
                error: function (response) {
                    alert("Error")
                }
            });
        }
    </script>
</asp:Content>
