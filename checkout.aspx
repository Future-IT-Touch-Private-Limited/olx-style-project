<%@ Page Title="Checkout" Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="checkout.aspx.cs" Inherits="checkout" %>

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
                        <h3 class="breadcrumb__title">Checkout</h3>
                        <div class="breadcrumb__list">
                            <span><a href="index">Home</a></span>
                            <span>Checkout</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="tp-checkout-area pb-120" data-bg-color="#EFF1F5" style="background-color: rgb(239, 241, 245);">
        <div class="container">
            <div class="row">

                <div class="col-lg-6 offset-lg-3">
                    <!-- checkout place order -->
                    <div class="tp-checkout-place white-bg">
                        <h3 class="tp-checkout-place-title">Your Order</h3>
                        <asp:HiddenField ID="product_ids_hf" runat="server" />
                        <div class="tp-order-info-list">
                            <ul>
                                <!-- header -->
                                <li class="tp-order-info-list-header">
                                    <h4>Product</h4>
                                    <h4>Total</h4>
                                </li>

                                <!-- item list -->
                                <asp:Repeater ID="Repeater1" OnItemDataBound="Repeater1_ItemDataBound" runat="server">
                                    <ItemTemplate>
                                        <li class="tp-order-info-list-desc">
                                            <asp:HiddenField ID="sr_hf" Value='<%# Eval("product_id") %>' runat="server" />
                                            <p><%# Eval("product_name") %></p>
                                            <span>£ <%# Eval("selling_price") %></span>
                                        </li>
                                    </ItemTemplate>
                                </asp:Repeater>
                                <!-- subtotal -->

                                <li class="tp-order-info-list-subtotal">
                                    <span>Subtotal</span>
                                    <span><asp:Label ID="subtotal_lbl" runat="server" Text="0"></asp:Label></span>
                                </li>


                                <!-- shipping -->
                                <li class="tp-order-info-list-shipping">
                                    <span>Shipping</span>
                                    <div class="tp-order-info-list-shipping-item d-flex flex-column align-items-end">
                                        <span>
                                            <input id="flat_rate" type="radio" name="shipping">
                                            <label for="flat_rate">GST Charges: <span><asp:Label ID="gstcharges_lbl" runat="server" Text="0"></asp:Label></span></label>
                                        </span>
                                        <span>
                                            <input id="local_pickup" type="radio" name="shipping">
                                            <label for="local_pickup">Shipping Charges: <span><asp:Label ID="shipping_charges_lbl" runat="server" Text="0"></asp:Label></span></label>
                                        </span>
                                    </div>
                                </li>

                                <!-- total -->
                                <li class="tp-order-info-list-total">
                                    <span>Total Payable</span>
                                    <span><asp:Label ID="total_lbl" runat="server" Text="0"></asp:Label></span>
                                </li>
                            </ul>
                        </div>
                        <div class="tp-checkout-payment">
                            <div class="tp-checkout-payment-item">
                                <input type="radio" id="back_transfer" name="payment">
                                <label for="back_transfer" data-bs-toggle="direct-bank-transfer">Book This Product</label>
                                <div class="tp-checkout-payment-desc direct-bank-transfer" style="display: none;">
                                    <p>After booking of this product you can now talk to the owner of this product.</p>
                                </div>
                            </div>
                        </div>
                        <div class="tp-checkout-agree">
                            <div class="tp-checkout-option">
                                <label for="read_all">Before proceed you must read and agree to the terms and conditions.</label>
                            </div>
                        </div>
                        <div class="tp-checkout-btn-wrapper">
                            <asp:Button ID="checkout_btn" OnClick="checkout_btn_Click" class="tp-checkout-btn w-100" runat="server" Text="Place Order" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>


</asp:Content>
