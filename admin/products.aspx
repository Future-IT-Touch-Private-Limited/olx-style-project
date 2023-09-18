<%@ Page Title="Products" Language="C#" MasterPageFile="~/main-admin.master" AutoEventWireup="true" CodeFile="products.aspx.cs" Inherits="admin_products" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container-fluid">
        <div class="page-title">
            <div class="row">
                <div class="col-6">
                    <h3>Products</h3>
                </div>
                <div class="col-6">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="dash" data-bs-original-title="" title="">Dashboard</a></li>
                        <li class="breadcrumb-item active">All Products (<asp:Label ID="total_lbl" runat="server" Text="0"></asp:Label>)</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>

    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-12">
                <div class="card">
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <thead>
                                <tr class="border-bottom-primary">
                                    <th scope="col"></th>
                                    <th scope="col">Name</th>
                                    <th scope="col">Price</th>
                                    <th scope="col">Category</th>
                                    <th scope="col" class="text-center">Status</th>
                                    <th scope="col">View</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="Repeater1" runat="server">
                                    <ItemTemplate>
                                        <tr class="border-bottom-secondary">
                                            <td class="text-center">
                                                <img class="img-30 me-2" src='../products/<%# Eval("product_image") %>'></td>
                                            <td><%# Eval("product_name") %></td>
                                            <td><%# Eval("selling_price") %></td>
                                            <td><%# Eval("product_category") %></td>
                                            <td class="text-center"><span class="badge badge-light-primary"><%# Eval("status") %></span></td>
                                            <td><a href='view-product?sr=<%# Eval("sr") %>'>View</a></td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>

                            </tbody>
                        </table>
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

    </div>
</asp:Content>
