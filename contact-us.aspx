<%@ Page Title="Contact Us" Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="contact-us.aspx.cs" Inherits="contact_us" %>

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
                        <h3 class="tp-section-title-2">Contact Us</h3>
                        <h6>Plese drop an email on <a class="text-primary" href="mailto:2201317@buckingham.ac.uk">2201317@buckingham.ac.uk</a> for any queries or problem  you face </h6>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section>

        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div class="row">
                    <div class="col-lg-6 offset-lg-3">
                        <h5>Submit Details</h5>
                        <div class="pb-3">
                            <strong>Your Name*</strong>
                            <asp:TextBox ID="nametxt" CssClass="form-control" runat="server"></asp:TextBox>
                        </div>
                        <div class="pb-3">
                            <strong>Your Mobile</strong>
                            <asp:TextBox ID="mobiletxt" CssClass="form-control" runat="server"></asp:TextBox>
                        </div>
                        <div class="pb-3">
                            <strong>Your Email*</strong>
                            <asp:TextBox ID="emailtxt" CssClass="form-control" runat="server"></asp:TextBox>
                        </div>
                        <div class="pb-3">
                            <strong>Query*</strong>
                            <asp:TextBox ID="querytxt" Height="100px" TextMode="MultiLine" Rows="5" CssClass="form-control" runat="server"></asp:TextBox>
                        </div>
                        <div class="text-center">
                            <asp:Label ID="errorlbl" Visible="false" Font-Bold="true" ForeColor="Red" runat="server" Text=""></asp:Label>
                            <asp:Label ID="successlbl" Visible="false" Font-Bold="true" ForeColor="Green" runat="server" Text=""></asp:Label>
                        </div>
                        <div class="pb-3 text-center">
                            <asp:Button runat="server" ID="submitbtn" OnClick="submitbtn_Click" CssClass="btn btn-primary btn-md" Text="Submit Details" />
                        </div>
                        <div class="text-center">
                            <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                <ProgressTemplate>
                                    <p>Please wait...</p>
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>


    </section>

</asp:Content>

