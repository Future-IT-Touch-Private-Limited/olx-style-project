<%@ Page Title="Success" Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="success.aspx.cs" Inherits="success" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <section class="breadcrumb__area include-bg pt-95 pb-50">
        <div class="container">
            <div class="row">
                <div class="col-xxl-12">
                    <div class="breadcrumb__content p-relative z-index-1">
                        <h3 class="breadcrumb__title">Checkout</h3>
                        <div class="breadcrumb__list">
                            <span><a href="#">Home</a></span>
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
                        <div class="text-center">
                            <img src="icons/success.png" width="150" height="150" />
                        </div>
                        <h3 class="tp-checkout-place-title text-center text-success">Reservation of this product is confirmed. ThankYou.</h3>

                        <div class="tp-checkout-btn-wrapper">
                            <a href="../user/dash" class="tp-checkout-btn w-100 bg-success">Goto Dashboard</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>