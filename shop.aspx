<%@ Page Title="Shop" Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="shop.aspx.cs" Inherits="shop" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <section class="tp-seller-area pb-140 pt-50">
        <div class="container">
            <div class="row">
                <div class="col-xl-12">
                    <div class="tp-section-title-wrapper-2 mb-50">
                        <span class="tp-section-title-pre-2">Best Seller This Week’s
                            <svg width="82" height="22" viewBox="0 0 82 22" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M81 14.5798C0.890564 -8.05914 -5.81154 0.0503902 5.00322 21" stroke="currentColor" stroke-opacity="0.3" stroke-width="2" stroke-miterlimit="3.8637" stroke-linecap="round"></path>
                            </svg>
                        </span>
                        <h3 class="tp-section-title-2">Men's Garments</h3>
                    </div>
                </div>
            </div>


            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>

                    <div class="row">

                        <asp:Repeater ID="Repeater1" OnItemCommand="Repeater1_ItemCommand" OnItemDataBound="Repeater1_ItemDataBound" runat="server">
                            <ItemTemplate>
                                <div class="col-xl-3 col-lg-4 col-sm-6">
                                    <asp:HiddenField ID="product_id" Value='<%# Eval("sr") %>' runat="server" />
                                    <asp:HiddenField ID="product_id_hf" Value='<%# Eval("sr") %>' runat="server" />
                                    <asp:HiddenField ID="product_by" Value='<%# Eval("product_by") %>' runat="server" />
                                    <asp:HiddenField ID="product_name" Value='<%# Eval("product_name") %>' runat="server" />
                                    <asp:HiddenField ID="product_category" Value='<%# Eval("product_category") %>' runat="server" />
                                    <asp:HiddenField ID="category_slug" Value='<%# Eval("category_slug") %>' runat="server" />
                                    <asp:HiddenField ID="selling_price" Value='<%# Eval("selling_price") %>' runat="server" />
                                    <asp:HiddenField ID="product_image" Value='<%# Eval("product_image") %>' runat="server" />
                                    <div class="tp-product-item-2 mb-40 p_border">
                                        <div class="tp-product-thumb-2 p-relative z-index-1 fix w-img">
                                            <a href='product?sr=<%# Eval("sr") %>'>
                                                <img src='../products/<%# Eval("product_image") %>' alt="">
                                            </a>
                                            <div class="tp-product-badge">
                                                <span class="product-trending">Trending</span>
                                            </div>
                                        </div>
                                        <div class="tp-product-content-2 pt-15">
                                            <div class="tp-product-tag-2">
                                                <a href='category?c=<%# Eval("category_slug") %>'><%# Eval("product_category") %></a>
                                            </div>
                                            <h3 class="tp-product-title-2">
                                                <a href='product?sr=<%# Eval("sr") %>'><%# Eval("product_name") %></a>
                                            </h3>
                                            <div class="tp-product-price-wrapper-2">
                                                <span class="tp-product-price-2 text-success new-price">£ <%# Eval("selling_price") %></span>
                                            </div>
                                            <div class="text-center">
                                                <div class="row">
                                                    <div class="col-12">
                                                        <asp:Button ID="add_cart_btn" CommandName="add_cart_btn" Visible="true" CssClass="btn btn-sm btn-success col-12" runat="server" Text="Add to Cart" />
                                                        <asp:Button ID="remove_cart_btn" CommandName="remove_cart_btn" Visible="false" CssClass="btn btn-sm btn-danger col-12" runat="server" Text="Remove Cart" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>

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

                </ContentTemplate>
            </asp:UpdatePanel>

        </div>
    </section>
</asp:Content>
