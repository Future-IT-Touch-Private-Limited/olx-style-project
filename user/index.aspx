<%@ Page Language="C#" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="user_index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login Now</title>
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
                                    <p class="text-center">Enter your university Id to access your account.</p>
                                    <div class="form-group">
                                        <label class="col-form-label">Email ID</label>
                                        <asp:TextBox ID="username" class="form-control" placeholder="student@buckingham.ac.uk" runat="server"></asp:TextBox>
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


                                    <div class="login-social-title">
                                        <h3>Or</h3>
                                    </div>
                                    <p class="mt-4 mb-0 text-center">New here?<span class="ms-2 btn btn-link" data-bs-toggle="modal" data-bs-target="#staticBackdrop">Setup Account</span></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <!-- Modal -->
        <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div class="modal-content">

                            <div class="modal-header">
                                <h1 class="modal-title fs-5" id="staticBackdropLabel">Register Account</h1>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">

                                <div class="login-main">
                                    <div class="theme-form">
                                        <div class="form-group">
                                            <label class="col-form-label">Email ID</label>
                                            <asp:TextBox ID="email_txt" class="form-control" placeholder="eg. student@buckingham.ac.uk" runat="server"></asp:TextBox>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-form-label">Password</label>
                                            <asp:TextBox ID="password_txt" TextMode="Password" class="form-control" placeholder="Min. 8 digits" runat="server"></asp:TextBox>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-form-label">Confirm Password</label>
                                            <asp:TextBox ID="confirm_password_txt" TextMode="Password" class="form-control" placeholder="Enter your password" runat="server"></asp:TextBox>
                                        </div>
                                        <div class="form-group mb-0">
                                            <div class="text-end mt-3">
                                                <asp:Button ID="registerbtn" OnClick="registerbtn_Click" class="btn btn-primary btn-block w-100" runat="server" Text="Setup Account" />
                                            </div>
                                        </div>

                                        <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                                            <ProgressTemplate>
                                                <div class="text-center pt-1">
                                                    <div class="spinner-border text-primary" role="status">
                                                        <span class="visually-hidden">Loading...</span>
                                                    </div>
                                                </div>
                                            </ProgressTemplate>
                                        </asp:UpdateProgress>

                                        <asp:Panel runat="server" ID="errordiv_register" Visible="false" class="alert alert-danger alert-dismissible mt-3" role="alert">
                                            <div>
                                                <asp:Label ID="errorlbl_register" Font-Bold="true" ForeColor="white" runat="server" Text=""></asp:Label>
                                            </div>
                                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                        </asp:Panel>
                                        <asp:Panel runat="server" ID="successdiv_register" Visible="false" class="alert alert-success alert-dismissible mt-3" role="alert">
                                            <div>
                                                <asp:Label ID="successlbl_register" Font-Bold="true" ForeColor="white" runat="server" Text=""></asp:Label>
                                            </div>
                                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                        </asp:Panel>

                                        <div class="login-social-title">
                                            <h3 class="text-center pt-3">Or</h3>
                                        </div>
                                        <p class="mt-4 mb-0 text-center">Already have an account?<span class="ms-2 btn btn-link" data-bs-dismiss="modal">Login Now</span></p>
                                    </div>
                                </div>

                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-link text-decoration-none text-danger" data-bs-dismiss="modal">Close</button>
                            </div>

                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>

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
