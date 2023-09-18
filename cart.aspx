<%@ Page Title="Cart" Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="cart.aspx.cs" Inherits="cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .tp-cart-checkout-shipping-option label::after {
            position: absolute;
            content: "";
            left: 0;
            top: 5px;
            width: 16px;
            height: 16px;
            border-radius: 50%;
            border: 1px solid #BCBCBC;
            background: #000;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section class="breadcrumb__area include-bg pt-95 pb-50">
        <div class="container">
            <div class="row">
                <div class="col-xxl-12">
                    <div class="breadcrumb__content p-relative z-index-1">
                        <h3 class="breadcrumb__title">Shopping Cart</h3>
                        <div class="breadcrumb__list">
                            <span><a href="index">Home</a></span>
                            <span>Shopping Cart</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="tp-cart-area pb-120">
        <div class="container">
            <div class="row">
                <div class="col-xl-9 col-lg-8">
                    <div class="tp-cart-list mb-25 mr-30">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th></th>
                                    <th class="tp-cart-header-product p-3">Product</th>
                                    <th class="tp-cart-header-price p-3">Price</th>
                                    <th class="tp-cart-header-quantity p-3">Remove</th>
                                </tr>
                            </thead>
                            <tbody>

                                <asp:Repeater ID="Repeater1" OnItemCommand="Repeater1_ItemCommand" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td class="tp-cart-img p-3">
                                                <asp:HiddenField ID="sr" Value='<%# Eval("sr") %>' runat="server" />
                                                <asp:HiddenField ID="product_id_hf" Value='<%# Eval("product_id") %>' runat="server" />
                                                <asp:HiddenField ID="selling_price_hf" Value='<%# Eval("selling_price") %>' runat="server" />
                                                <img src='../products/<%# Eval("product_image") %>'></td>
                                            <td class="tp-cart-title p-3"><strong><%# Eval("product_name") %></strong></td>
                                            <td class="tp-cart-price p-3"><span><strong>£ <%# Eval("selling_price") %></strong></span></td>
                                            <td class="tp-cart-action p-3">
                                                <asp:Button ID="remove_btn" CommandName="remove_btn" runat="server" Text="Remove" CssClass="btn btn-sm fw-bolder text-danger btn-outline-sm" />
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>

                            </tbody>
                        </table>
                    </div>

                </div>
                <div class="col-xl-3 col-lg-4 col-md-6">
                    <div class="tp-cart-checkout-wrapper">
                        <div class="tp-cart-checkout-top d-flex align-items-center justify-content-between">
                            <span class="tp-cart-checkout-top-title">Subtotal</span>
                            <span class="tp-cart-checkout-top-price">
                                <asp:Label ID="subtotal_lbl" runat="server" Text="0"></asp:Label></span>
                        </div>
                        <div class="tp-cart-checkout-shipping">
                            <h4 class="tp-cart-checkout-shipping-title">Other Charges</h4>

                            <div class="tp-cart-checkout-shipping-option-wrapper">
                                <div class="tp-cart-checkout-shipping-option">
                                    <label>GST Charges: <span>
                                        <asp:Label ID="gstcharges_lbl" runat="server" Text="0"></asp:Label></span></label>
                                </div>
                                <div class="tp-cart-checkout-shipping-option">
                                    <label>Shipping Charges: <span>
                                        <asp:Label ID="shipping_charges_lbl" runat="server" Text="0"></asp:Label></span></label>
                                </div>
                                <asp:Label ID="you_saved_lbl" CssClass="fw-bolder" ForeColor="#38A829" runat="server" Text="You saved £ 0 on this order"></asp:Label>
                            </div>
                        </div>
                        <div class="tp-cart-checkout-total d-flex align-items-center justify-content-between">
                            <span>Total Payable</span>
                            <span><asp:Label ID="total_lbl" runat="server" Text="0"></asp:Label></span>
                        </div>
                        <div class="tp-cart-checkout-proceed">
                            <asp:Button ID="goto_checkout_btn" OnClick="goto_checkout_btn_Click" runat="server" class="tp-cart-checkout-btn w-100" Text="Proceed to Checkout" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

</asp:Content>
