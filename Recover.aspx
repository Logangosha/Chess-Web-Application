<%@ Page Language="C#" Title="Recover Account" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Recover.aspx.cs" Inherits="Chess_App.Recover" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row p-0 hidden-scroll-bar overflow-auto MainCard" style="height: 100vh;">
         <div class="col d-flex gap-3 flex-column align-items-center justify-content-center overflow-auto">
            <h1 class="h1-landing">RECOVER</h1>
            <div class="d-grid text-center flex-column gap-3 overflow-auto">
                <h2>A code has been sent to<br></h2>
                <p class="p-bg"><b><i><%= ViewState["RecoverEmail"]%></i></b></p>
                <asp:TextBox runat="server" ID="RecoverEmailTbx" CssClass="" placeholder="Enter Code"></asp:TextBox>
                <asp:Button runat="server" ID="ContinueBtn" OnClick="ContinueBtn_Click" disabled CssClass="Btn Btn-primary Btn-toggle Btn-disabled my-3" Text="Continue" />
            </div>
        </div>
        </div>
    <script type="text/javascript">
        const RecoverEmailTbx = document.getElementById('<%=RecoverEmailTbx.ClientID%>');
        const ContinueBtn = document.getElementById('<%=ContinueBtn.ClientID%>');
       
        RecoverEmailTbx.addEventListener("keyup", myScript);
        function myScript() {
            if (RecoverEmailTbx.value.length == 6) {
                ContinueBtn.classList.remove('Btn-disabled')
                ContinueBtn.disabled = false;
            }
            else {
                ContinueBtn.classList.add('Btn-disabled')
                ContinueBtn.disabled = true;
            }
        }
    </script>
</asp:Content>
