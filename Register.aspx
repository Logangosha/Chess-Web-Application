<%@ Page Language="C#" Title="Register" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Chess_App.Register" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row p-0 overflow-auto hidden-scroll-bar h-100 MainCard">
        <div class="col d-flex flex-column align-items-center justify-content-center overflow-auto pt-5">
            <div class="d-grid text-center flex-column">
            <h1 class="h1-landing">REGISTER</h1>
            </div>
            <div class="d-grid text-center flex-column gap-3">
                <h2>Complete to continue</h2>
                <asp:TextBox runat="server" ID="UnameTbx" placeholder="Username"></asp:TextBox>
                <asp:TextBox runat="server" ID="EmailTbx" CssClass="" TextMode="Email" placeholder="Email"></asp:TextBox> 
                <asp:TextBox runat="server" ID="PasswordTbx" CssClass="" placeholder="Password" TextMode="Password"></asp:TextBox>
                <asp:TextBox runat="server" ID="ConfirmPasswordTbx" CssClass="" placeholder="Confirm Password" TextMode="Password"></asp:TextBox>
                <asp:CompareValidator runat="server" ID="ErrorLbl" ControlToCompare="ConfirmPasswordTbx" ControlToValidate="PasswordTbx" CssClass="align-items-start" ErrorMessage="Passwords do not match." ForeColor="Red" Display="Dynamic"></asp:CompareValidator>
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
        EmailTbx.addEventListener("keyup", myScript);
        PasswordTbx.addEventListener("keyup", myScript);
        ConfirmPasswordTbx.addEventListener("keyup", myScript);
        function myScript() {
            if (UnameTbx.value !="" && EmailTbx.value != "" && PasswordTbx.value != "" && ConfirmPasswordTbx.value != "") {
                CreateAccountBtn.classList.remove('Btn-disabled')
                CreateAccountBtn.disabled = false;
            }
            else {
                CreateAccountBtn.classList.add('Btn-disabled')
                CreateAccountBtn.disabled = true;
            }
        }
    </script>
</asp:Content>
