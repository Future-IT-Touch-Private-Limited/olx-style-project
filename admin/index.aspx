<%@ Page Language="C#" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="admin_index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Now</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="robots" content="noindex,nofollow" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="">
    <link href="https://fonts.googleapis.com/css2?family=Rubik:ital,wght@0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,300;1,400;1,500;1,600;1,700;1,800;1,900&amp;display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&amp;display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&amp;display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href=".assets/css/vendors/font-awesome.css">
    <link rel="stylesheet" type="text/css" href="assets/css/vendors/icofont.css">
    <link rel="stylesheet" type="text/css" href="assets/css/vendors/themify.css">
    <link rel="stylesheet" type="text/css" href="assets/css/vendors/flag-icon.css">
    <link rel="stylesheet" type="text/css" href="assets/css/vendors/feather-icon.css">
    <link rel="stylesheet" type="text/css" href="assets/css/vendors/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="assets/css/style.css">
    <link id="color" rel="stylesheet" href="assets/css/color-1.css" media="screen">
    <link rel="stylesheet" type="text/css" href="assets/css/responsive.css">
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" EnableCdn="true" runat="server"></asp:ScriptManager>


        <!-- Loader starts-->
        <div class="loader-wrapper">
            <div class="loader"></div>
        </div>
        <!-- Loader ends-->
        <!-- login page start-->
        <div class="container-fluid p-0">
            <div class="row m-0">
                <div class="col-12 p-0">
                    <div class="login-card">
                        <div>
                            <div>
                                <a class="logo" href="#">
                                    <img width="300" class="for-light" src="../tl-generation-logo.png" alt="logo image"></a>
                            </div>
                            <div class="login-main">
                                <div class="theme-form">
                                    <h2 class="text-center">Sign in to account</h2>
                                    <p class="text-center">Enter your credentials to access your account.</p>
                                    <div class="form-group">
                                        <label class="col-form-label">Username</label>
                                        <asp:TextBox ID="username" class="form-control" placeholder="example@gmail.com" runat="server"></asp:TextBox>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-form-label">Password</label>
                                        <asp:TextBox ID="password" TextMode="Password" class="form-control" placeholder="**********" runat="server"></asp:TextBox>
                                    </div>
                                    <div class="form-group mb-0">
                                        <%--<a class="link" href="forget-password">Forgot password?</a>--%>
                                        <div class="text-end mt-3">
                                            <asp:Button ID="login_btn" OnClick="loginbtn_Click" class="btn btn-primary btn-block w-100" runat="server" Text="Sign In" />
                                        </div>
                                    </div>

                                    <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                        <ProgressTemplate>
                                            <div class="text-center pt-1">
                                                <div class="spinner-border text-primary" role="status">
                                                    <span class="visually-hidden">Loading...</span>
                                                </div>
                                            </div>
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>

                                    <asp:Panel runat="server" ID="errordiv" Visible="false" class="alert alert-danger alert-dismissible mt-3" role="alert">
                                        <div>
                                            <asp:Label ID="errorlbl" Font-Bold="true" ForeColor="white" runat="server" Text=""></asp:Label>
                                        </div>
                                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                    </asp:Panel>
                                    <asp:Panel runat="server" ID="successdiv" Visible="false" class="alert alert-success alert-dismissible mt-3" role="alert">
                                        <div>
                                            <asp:Label ID="successlbl" Font-Bold="true" ForeColor="white" runat="server" Text=""></asp:Label>
                                        </div>
                                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                    </asp:Panel>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <!-- latest jquery-->
        <script src="assets/js/jquery-3.6.0.min.js"></script>
        <script src="assets/js/bootstrap/popper.min.js"></script>
        <script src="assets/js/bootstrap/bootstrap.bundle.min.js"></script>
        <!-- feather icon js-->
        <script src="assets/js/icons/feather-icon/feather.min.js"></script>
        <script src="assets/js/icons/feather-icon/feather-icon.js"></script>
        <!-- Sidebar jquery-->
        <script src="assets/js/config.js"></script>
        <!-- Theme js-->
        <script src="assets/js/script.js"></script>

    </form>
</body>
</html>
