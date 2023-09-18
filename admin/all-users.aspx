<%@ Page Title="All Users" Language="C#" MasterPageFile="~/main-admin.master" AutoEventWireup="true" CodeFile="all-users.aspx.cs" Inherits="admin_all_users" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container-fluid">
        <div class="page-title">
            <div class="row">
                <div class="col-6">
                    <h3>All Users</h3>
                </div>
                <div class="col-6">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="dash" data-bs-original-title="" title="">Dashboard</a></li>
                        <li class="breadcrumb-item active">All Users</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>


    <div class="row">
        <div class="col-sm-12">
            <div class="card">
                <div class="card-header pb-0">
                    <h3>All Users
                         (Total
                        <asp:Label ID="total_lbl" runat="server" Text="0"></asp:Label>)
                    </h3>
                </div>
                <div class="card-body">
                    <div class="order-history table-responsive">
                        <table class="table table-bordered display">
                            <thead>
                                <tr>
                                    <th scope="col"></th>
                                    <th>Email Id</th>
                                    <th scope="col">Full Name</th>
                                    <th scope="col">Mobile</th>
                                    <th scope="col">Status</th>
                                    <th scope="col">View</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="Repeater1" OnItemDataBound="Repeater1_ItemDataBound" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td><img class="img-fluid img-30" src='../profile/<%# Eval("profile_pic") %>' alt=""></td>
                                            <td>
                                                <%# Eval("username") %>
                                            </td>
                                            <td>
                                                <div class="product-name">
                                                    <%# Eval("full_name") %>
                                                </div>
                                            </td>
                                            <td><%# Eval("mobile") %></td>
                                            <td><span class="badge badge-success">Running</span></td>
                                            <td>
                                                <div class="product-name">
                                                    <a class="fw-bold text-primary" href='view-user?rfc=<%# Eval("sr") %>'>View</a>
                                                </div>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <div class="row">
        <div class="col-lg-12">
            <div class="table-responsive">
                <table class="table">
                    <tr>
                        <td>
                            <asp:LinkButton ID="lnkFirst" runat="server" OnClick="lnkFirst_Click">First</asp:LinkButton>
                        </td>
                        <td>
                            <asp:LinkButton ID="lnkPrevious" runat="server" OnClick="lnkPrevious_Click">Previous</asp:LinkButton>
                        </td>
                        <td>
                            <asp:DataList ID="RepeaterPaging" runat="server"
                                OnItemCommand="RepeaterPaging_ItemCommand"
                                OnItemDataBound="RepeaterPaging_ItemDataBound" RepeatDirection="Horizontal">
                                <ItemTemplate>
                                    <asp:LinkButton ID="Pagingbtn" runat="server"
                                        CommandArgument='<%# Eval("PageIndex") %>' CommandName="newpage"
                                        Text='<%# Eval("PageText") %>' Width="20px"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:DataList>
                        </td>
                        <td>
                            <asp:LinkButton ID="lnkNext" runat="server" OnClick="lnkNext_Click">Next</asp:LinkButton>
                        </td>
                        <td>
                            <asp:LinkButton ID="lnkLast" runat="server" OnClick="lnkLast_Click">Last</asp:LinkButton>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="5" class="text-center">
                            <asp:Label ID="lblpage" runat="server" Text=""></asp:Label>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</asp:Content>
