<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Chess_App._Default" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row p-0 hidden-scroll-bar overflow-auto MainCard" style="height: 100vh;">
         <!-- img -->
        <div id="LoginDiv" class="col p-0 d-lg-flex d-flex">
            <%--<div id="LogInImg" class="logInBorder col-lg-6 p-0 LogInImgContainter">
                <div class="h-100 w-100 d-flex flex-column justify-content-end align-items-center LogInImg">
                </div>
            </div>--%>
            <!-- Login Form -->
            <div id="LoginForm" runat="server" class="logInBorder d-block col-12 p-0">
                <div id="" class="h-100 w-100 d-flex flex-column logInForm pt-0 px-4 pt-lg-0 justify-content-around  align-items-center ">
                    <div class="d-grid text-center flex-column gap-3 overflow-auto">
                        <h1 class="h1-landing text-center">CHESS</h1>
                        <h2 class="mb-4">Free Online Chess With Friends</h2>
                        <asp:LinkButton runat="server" ID="LoginBtn" OnClick="LoginBtn_Click" CssClass="Btn Btn-primary">Login&nbsp;<span class="fa fa-sign-in"></span></asp:LinkButton>
                        <asp:LinkButton runat="server" ID="PlayAsGuestBtn" OnClick="PlayAsGuestBtn_Click" CssClass="Btn Btn-secondary">Play as Guest</asp:LinkButton>
                        <hr class="m-0" />
                        <asp:LinkButton runat="server" ID="NeedAnAccountBtn" OnClick="NeedAnAccountBtn_Click" CssClass="Btn Btn-secondary">Need an Account?</asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
