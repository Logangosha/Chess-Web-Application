<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Account.aspx.cs" Inherits="Chess_App.Account" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
     <div class="row p-0 justify-content-center h-100 MainCard overflow-scroll hidden-scroll-bar">
         <div class="col-auto col-lg-7 col-xl-5 py-4 p-0 justify-content-center my-auto align-items-center">
            <div class="profile-body p-0 px-4 d-flex flex-column">
                <div>
                    <div class="profile-img-container">
                        <img class="profile-img" src="\Images\unclewiggly.png" />
                    </div>
                     <h1 class="mt-3 h1-landing-sm text-break">SecularTalk34</h1>
                    <h2 class="text-break">Logan Gauchat</h2>
                </div>
              <hr/>
                <button type="button" class="Btn Btn-link"  data-bs-toggle="modal" data-bs-target="#ChangeThemeModal">
                        <i class="Btn-link-icon fa-solid fa-palette"></i>
                        Change Theme
                        <i class="fa-solid fa-arrow-right Btn-link-arrow"></i>
                </button>
                <button type="button" class="Btn Btn-link"  data-bs-toggle="modal" data-bs-target="#EditAccountModal">
                        <i class="Btn-link-icon fa-solid fa-pen"></i>
                        Edit Account
                        <i class="fa-solid fa-arrow-right Btn-link-arrow" ></i>
                </button>
                <button type="button" class="Btn Btn-link"  data-bs-toggle="modal" data-bs-target="#ChangePasswordModal">
                        <i class="Btn-link-icon fa-solid fa-lock"></i>
                        Change Password
                        <i class="fa-solid fa-arrow-right Btn-link-arrow"></i>
                </button>
                <button text="Modal" type="button" class="Btn Btn-link" data-bs-toggle="modal" data-bs-target="#DeleteAccountModal">
                        <i class="Btn-link-icon fa-solid fa-trash"></i>
                        Delete Account
                        <i class="fa-solid fa-arrow-right Btn-link-arrow"></i>
                </button>
               <asp:LinkButton runat="server"  CssClass="Btn Btn-primary Btn-large mt-2"><span class="user-control-pannel-body-btn-icon fa fa-sign-in"></span>&nbsp;Sign Out</asp:LinkButton>
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
         <h1 class="modal-title">
             Change Theme
         </h1>
         <button type="button" class="Btn Btn-secondary modal-close pe-0" data-bs-dismiss="modal"><i class="fa-solid fa-xmark"></i></button>
          </div>
          <hr />
          <div class="modal-body my-auto gap-2">
              <div class="pb-2">
                  <h1 class="h1-landing">Select Colors</h1>
              </div>
            <div>
                <p class="p-bg my-2 d-block">Primary Color</p>
                 <div class="d-flex justify-content-center align-items-center">
                    <i class="primary-color-picker-icon color-picker-icon fa-solid fa-paintbrush"></i><input runat="server" id="primaryColor" type="color" class="color-picker"/>
                </div>
            </div>
            <div>
                <p class="p-bg my-2 d-block">Background Color</p>
                <div class="d-flex justify-content-center align-items-center">
                    <i class="background-color-picker-icon  color-picker-icon fa-solid fa-paintbrush"></i><input runat="server" id="backgroundColor" type="color" class="color-picker"/>
                </div>
            </div>
          </div>
          <hr />
        <div class="modal-footer">
            <button type="button" class="Btn Btn-secondary ps-0" data-bs-dismiss="modal">
                Cancle
            </button>
            <asp:Button runat="server" OnClick="ChangeThemeSaveBtn_Click" ID="ChangeThemeSaveBtn" type="button" class="Btn Btn-primary ms-auto" text="Save"></asp:Button>
            <script defer>
                const primaryColorPicker = document.getElementById("<%=primaryColor.ClientID%>");
                const backgroundColorPicker = document.getElementById("<%=backgroundColor.ClientID%>");
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
         <h1 class="modal-title">
             Edit Account
         </h1>
         <button type="button" class="Btn Btn-secondary modal-close pe-0" data-bs-dismiss="modal"><i class="fa-solid fa-xmark"></i></button>
          </div>
          <hr />
          <div class="modal-body my-auto gap-2">
              <div class="pb-2">
                  <h1 class="h1-landing">Select Colors</h1>
              </div>
            <div>
                <p class="p-bg my-2 d-block">Primary Color</p>
                 <div class="d-flex justify-content-center align-items-center">
                    <i class="primary-color-picker-icon color-picker-icon fa-solid fa-paintbrush"></i><input runat="server" id="Color5" type="color" class="color-picker"/>
                </div>
            </div>
            <div>
                <p class="p-bg my-2 d-block">Background Color</p>
                <div class="d-flex justify-content-center align-items-center">
                    <i class="background-color-picker-icon  color-picker-icon fa-solid fa-paintbrush"></i><input runat="server" id="Color6" type="color" class="color-picker"/>
                </div>
            </div>
          </div>
          <hr />
        <div class="modal-footer">
            <button type="button" class="Btn Btn-secondary ps-0" data-bs-dismiss="modal">
                Cancle
            </button>
<%--            <asp:Button runat="server" OnClick="SaveBtn_Click" ID="Button3" type="button" class="Btn Btn-primary ms-auto" text="Save"></asp:Button>--%>
            <script defer>
                const primaryColorPicker = document.getElementById("<%=primaryColor.ClientID%>");
                const backgroundColorPicker = document.getElementById("<%=backgroundColor.ClientID%>");
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
         <h1 class="modal-title">
             Change Password
         </h1>
         <button type="button" class="Btn Btn-secondary modal-close pe-0" data-bs-dismiss="modal"><i class="fa-solid fa-xmark"></i></button>
          </div>
          <hr />
          <div class="modal-body my-auto gap-2">
              <div class="pb-2">
                  <h1 class="h1-landing">Select Colors</h1>
              </div>
            <div>
                <p class="p-bg my-2 d-block">Primary Color</p>
                 <div class="d-flex justify-content-center align-items-center">
                    <i class="primary-color-picker-icon color-picker-icon fa-solid fa-paintbrush"></i><input runat="server" id="Color3" type="color" class="color-picker"/>
                </div>
            </div>
            <div>
                <p class="p-bg my-2 d-block">Background Color</p>
                <div class="d-flex justify-content-center align-items-center">
                    <i class="background-color-picker-icon  color-picker-icon fa-solid fa-paintbrush"></i><input runat="server" id="Color4" type="color" class="color-picker"/>
                </div>
            </div>
          </div>
          <hr />
        <div class="modal-footer">
            <button type="button" class="Btn Btn-secondary ps-0" data-bs-dismiss="modal">
                Cancle
            </button>
<%--            <asp:Button runat="server" OnClick="SaveBtn_Click" ID="Button2" type="button" class="Btn Btn-primary ms-auto" text="Save"></asp:Button>--%>
            <script defer>
                const primaryColorPicker = document.getElementById("<%=primaryColor.ClientID%>");
                const backgroundColorPicker = document.getElementById("<%=backgroundColor.ClientID%>");
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
         <h1 class="modal-title">
             Delete Account
         </h1>
         <button type="button" class="Btn Btn-secondary modal-close pe-0" data-bs-dismiss="modal"><i class="fa-solid fa-xmark"></i></button>
          </div>
          <hr />
          <div class="modal-body my-auto gap-2">
              <span class="modal-icon fa fa-warning"></span>
            <h1 class="modal-heading">DELETE</h1>
            <h2 class="modal-subheading">Are you sure you want to <b>Delete your account</b>?<br />Press <b>Delete</b> to delete your account.</h2>
          </div>
          <hr />
        <div class="modal-footer">
            <button type="button" class="Btn Btn-secondary ps-0" data-bs-dismiss="modal">
                Cancle
            </button>
            <asp:Button runat="server" OnClick="DeleteAccountModalBtn_Click" ID="DeleteAccountModalBtn" type="button" class="Btn Btn-primary ms-auto" text="Delete"></asp:Button>
            <script defer>
                const primaryColorPicker = document.getElementById("<%=primaryColor.ClientID%>");
                const backgroundColorPicker = document.getElementById("<%=backgroundColor.ClientID%>");
            </script>
          </div>
      </div>
    </div>
  </div>
    <!--/DeleteAccount -->
</asp:Content>