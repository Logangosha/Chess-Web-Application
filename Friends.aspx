<%@ Page Language="C#" Title="Friends" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Friends.aspx.cs" Inherits="Chess_App.Friends" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid h-100">
         <div class="row p-0 justify-content-center h-100 MainCard overflow-scroll hidden-scroll-bar">
                        <div class="d-flex flex-column gap-2 col-auto py-4 p-0 text-center justify-content-center my-auto align-items-center">
                            
                <h1 class=" h1-landing">FRIENDS</h1>
                <hr class="w-100" />
                <div class="search-bar">
                    <input class="search-bar-input" autofocus="autofocus" type="text" placeholder="Search" />
                    <button class="Btn Btn-primary search-bar-Btn">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
                <%--<asp:PlaceHolder runat="server" ID="FriendTilesPlaceholder"></asp:PlaceHolder>--%>
                <div class="Btn friend-tile">
                    <img src="Images/whitehandmovingchesspiece.jpg" />
                    <p>Friend 1</p>
                    <span class="status-indicator offline"></span>
                </div>
                <div class="Btn friend-tile">
                    <img src="Images/twomenplayingchessdarkroom.jpg" />
                    <p>Friend 2</p>
                    <span class="status-indicator"></span>
                </div>
                <div class="Btn friend-tile offline">
                    <img src="Images/unclewiggly.png" />
                    <p>Friend 3</p>
                    <span class="status-indicator"></span>
                </div>
                <div class="Btn friend-tile">
                    <img src="Images/untitled.png" />
                    <p>Friend 4</p>
                    <span class="status-indicator"></span>
                </div>
                <div class="Btn friend-tile">
                    <img src="Images/whitehandmovingchesspiece.jpg" />
                    <p>Friend 1</p>
                    <span class="status-indicator"></span>
                </div>
                <div class="Btn friend-tile">
                    <img src="Images/twomenplayingchessdarkroom.jpg" />
                    <p>Friend 2</p>
                    <span class="status-indicator"></span>
                </div>
                <div class="Btn friend-tile">
                    <img src="Images/unclewiggly.png" />
                    <p>Friend 3</p>
                    <span class="status-indicator"></span>
                </div>
                <div class="mt-5"></div>

                            
            </div>
        </div>
    </div>
</asp:Content>
