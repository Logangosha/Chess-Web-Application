<%@ Page Language="C#" Title="Register" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Chess_App.Register" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row p-0 overflow-auto hidden-scroll-bar h-100 MainCard">
        <div class="col d-flex flex-column align-items-center justify-content-center overflow-auto pt-5">
            <div class="d-grid text-center flex-column">
            <h1 class="h1-landing">REGISTER</h1>
            </div>
            <div class="d-grid text-center flex-column gap-3">
                <h2>Complete to continue</h2>
                <asp:TextBox runat="server" ID="FnameTbx" CssClass="" placeholder="First Name"></asp:TextBox>
                <asp:TextBox runat="server" ID="LnameTbx" CssClass="" placeholder="Last Name"></asp:TextBox>
                <asp:TextBox runat="server" ID="EmailTbx" CssClass="" TextMode="Email" placeholder="Email"></asp:TextBox> 
                <asp:TextBox runat="server" ID="PasswordTbx" CssClass="" placeholder="Password" TextMode="Password"></asp:TextBox>
                <asp:TextBox runat="server" ID="ConfirmPasswordTbx" CssClass="" placeholder="Confirm Password" TextMode="Password"></asp:TextBox>
                <asp:CompareValidator runat="server" ControlToCompare="ConfirmPasswordTbx" ControlToValidate="PasswordTbx" CssClass="align-items-start" ErrorMessage="Passwords do not match." ForeColor="Red" Display="Dynamic"></asp:CompareValidator>
                <asp:Button runat="server" ID="LoginBtn" disabled CssClass="Btn Btn-primary Btn-toggle my-3 Btn-disabled" Text="Create Account" />
            </div>
        </div>
    </div>
    <script type="text/javascript">
        const FnameTbx = document.getElementById('<%=FnameTbx.ClientID%>');
        const LnameTbx = document.getElementById('<%=LnameTbx.ClientID%>');
        const EmailTbx = document.getElementById('<%=EmailTbx.ClientID%>');
        const PasswordTbx = document.getElementById('<%=PasswordTbx.ClientID%>');
        const ConfirmPasswordTbx = document.getElementById('<%=ConfirmPasswordTbx.ClientID%>');

        const LoginBtn = document.getElementById('<%=LoginBtn.ClientID%>');
        FnameTbx.addEventListener("keyup", myScript);
        LnameTbx.addEventListener("keyup", myScript);
        EmailTbx.addEventListener("keyup", myScript);
        PasswordTbx.addEventListener("keyup", myScript);
        ConfirmPasswordTbx.addEventListener("keyup", myScript);
        function myScript() {
            if (FnameTbx.value != "" && LnameTbx.value != "" && EmailTbx.value != "" && PasswordTbx.value != "" && ConfirmPasswordTbx.value != "") {
                LoginBtn.classList.remove('Btn-disabled')
                LoginBtn.disabled = false;
            }
            else {
                LoginBtn.classList.add('Btn-disabled')
                LoginBtn.disabled = true;
            }
        }
    </script>
</asp:Content>
