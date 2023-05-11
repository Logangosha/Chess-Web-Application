<%@ Page Language="C#"  MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Chess_App.Sign_In" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row p-0 overflow-auto hidden-scroll-bar h-100 MainCard">
        <div class="col d-flex gap-3 py-4 flex-column align-items-center justify-content-center overflow-auto">
            <h1 class="h1-landing">LOGIN</h1>
            <div class="d-grid text-center flex-column gap-3 overflow-auto">
                <h2>Complete to Continue</h2>
                <asp:TextBox runat="server" ID="UsernameTbx" CssClass="" placeholder="Username"></asp:TextBox>
                <asp:TextBox runat="server" ID="PasswordTbx" CssClass="" placeholder="Password" TextMode="Password"></asp:TextBox>
                <asp:Button runat="server" ID="FrogotPasswordBtn" OnClick="FrogotPasswordBtn_Click" CssClass="Btn Btn-secondary" Text="Frogot Password?"/>
                <asp:Button runat="server" ID="LoginBtn" OnClick="BtnLogin_Click" disabled CssClass="Btn Btn-primary Btn-toggle Btn-disabled" Text="Login" />
                <asp:Button runat="server" ID="AccountBtn" OnClick="AccountBtn_Click" CssClass="Btn Btn-secondary" Text="Need an Account?"/>
            </div>
        </div>
    </div>
    <script type="text/javascript">
       const UsernameTbx = document.getElementById('<%=UsernameTbx.ClientID%>');
        const PasswordTbx = document.getElementById('<%=PasswordTbx.ClientID%>');
        const LoginBtn = document.getElementById('<%=LoginBtn.ClientID%>');
        UsernameTbx.addEventListener("keyup", myScript);
        PasswordTbx.addEventListener("keyup", myScript);
        function myScript() {
            if (UsernameTbx.value != "" && PasswordTbx.value != "") {
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
