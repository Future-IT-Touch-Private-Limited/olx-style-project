<%@ Page Title="View Product" Language="C#" MasterPageFile="~/main.master" AutoEventWireup="true" CodeFile="product.aspx.cs" Inherits="product" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>

            <section class="breadcrumb__area breadcrumb__style-2 include-bg pt-50 pb-20">
                <div class="container">
                    <div class="row">
                        <div class="col-xxl-12">
                            <div class="breadcrumb__content p-relative z-index-1">
                                <div class="breadcrumb__list has-icon">
                                    <span class="breadcrumb-icon">
                                        <svg width="17" height="17" viewBox="0 0 17 17" fill="none" xmlns="http://www.w3.org/2000/svg">
                                            <path d="M1.42393 16H15.5759C15.6884 16 15.7962 15.9584 15.8758 15.8844C15.9553 15.8104 16 15.71 16 15.6054V6.29143C16 6.22989 15.9846 6.1692 15.9549 6.11422C15.9252 6.05923 15.8821 6.01147 15.829 5.97475L8.75305 1.07803C8.67992 1.02736 8.59118 1 8.5 1C8.40882 1 8.32008 1.02736 8.24695 1.07803L1.17098 5.97587C1.11791 6.01259 1.0748 6.06035 1.04511 6.11534C1.01543 6.17033 0.999976 6.23101 1 6.29255V15.6063C1.00027 15.7108 1.04504 15.8109 1.12451 15.8847C1.20398 15.9585 1.31165 16 1.42393 16ZM10.1464 15.2107H6.85241V10.6202H10.1464V15.2107ZM1.84866 6.48977L8.4999 1.88561L15.1517 6.48977V15.2107H10.9946V10.2256C10.9946 10.1209 10.95 10.0206 10.8704 9.94654C10.7909 9.87254 10.683 9.83096 10.5705 9.83096H6.42848C6.316 9.83096 6.20812 9.87254 6.12858 9.94654C6.04904 10.0206 6.00435 10.1209 6.00435 10.2256V15.2107H1.84806L1.84866 6.48977Z" fill="#55585B" stroke="#55585B" stroke-width="0.5"></path>
                                        </svg>
                                    </span>
                                    <span><a href="index">Home</a></span>
                                    <span>View Product</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <asp:HiddenField ID="product_id_hf" runat="server" />
            <asp:HiddenField ID="product_by_hf" runat="server" />
            <asp:HiddenField ID="product_category_hf" runat="server" />
            <asp:HiddenField ID="category_slug_hf" runat="server" />
            <asp:HiddenField ID="selling_price_hf" runat="server" />
            <asp:HiddenField ID="product_image_hf" runat="server" />
            <asp:HiddenField ID="product_name_hf" runat="server" />


            <section class="tp-product-details-area">
                <div class="tp-product-details-top pb-115">
                    <div class="container">
                        <div class="row">
                            <div class="col-xl-7 col-lg-6">
                                <div class="tp-product-details-thumb-wrapper tp-tab d-sm-flex">
                                    <div class="tab-content m-img" id="productDetailsNavContent">
                                        <div class="tab-pane fade show active" id="nav-1" role="tabpanel" aria-labelledby="nav-1-tab" tabindex="0">
                                            <div class="tp-product-details-nav-main-thumb">
                                                <asp:Image ID="Image1" runat="server" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- col end -->
                            <div class="col-xl-5 col-lg-6">
                                <div class="tp-product-details-wrapper">
                                    <div class="tp-product-details-category">
                                        <span>
                                            <asp:Label ID="product_category" runat="server" Text=""></asp:Label></span>
                                    </div>
                                    <h3 class="tp-product-details-title">
                                        <asp:Label ID="product_name" runat="server" Text=""></asp:Label></h3>

                                    <!-- inventory details -->
                                    <div class="tp-product-details-inventory d-flex align-items-center mb-10">
                                        <div class="tp-product-details-stock mb-10">
                                            <span>Available for Sale</span>
                                        </div>
                                        <div class="tp-product-details-rating-wrapper d-flex align-items-center mb-10">
                                            <div class="tp-product-details-rating">
                                                <span><i class="fa-solid fa-star"></i></span>
                                                <span><i class="fa-solid fa-star"></i></span>
                                                <span><i class="fa-solid fa-star"></i></span>
                                                <span><i class="fa-solid fa-star"></i></span>
                                                <span><i class="fa-solid fa-star"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- price -->
                                    <div class="tp-product-details-price-wrapper mb-20">
                                        <span class="tp-product-details-price new-price">€
                                            <asp:Label ID="selling_price" runat="server" Text=""></asp:Label></span>
                                    </div>


                                    <!-- actions -->
                                    <div class="tp-product-details-action-wrapper">
                                        <h3 class="tp-product-details-action-title">Quantity</h3>
                                        <div class="tp-product-details-action-item-wrapper d-flex align-items-center">
                                            <div class="tp-product-details-add-to-cart mb-15 w-100">
                                                <asp:Button ID="addcartbtn" OnClick="addcartbtn_Click" Visible="true" class="tp-product-details-add-to-cart-btn w-100" runat="server" Text="Add To Cart" />
                                                <asp:Button ID="removecartbtn" OnClick="removecartbtn_Click" Visible="false" class="tp-product-details-add-to-cart-btn bg-danger text-white w-100" runat="server" Text="Remove From Cart" />
                                            </div>
                                        </div>
                                        <a href="checkout" class="tp-product-details-buy-now-btn w-100 text-center">Checkout</a>
                                    </div>
                                    <div class="tp-product-details-action-sm">
                                        <button type="button" class="tp-product-details-action-sm-btn">
                                            <svg width="17" height="16" viewBox="0 0 17 16" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                <path d="M8.575 12.6927C8.775 12.6927 8.94375 12.6249 9.08125 12.4895C9.21875 12.354 9.2875 12.1878 9.2875 11.9907C9.2875 11.7937 9.21875 11.6275 9.08125 11.492C8.94375 11.3565 8.775 11.2888 8.575 11.2888C8.375 11.2888 8.20625 11.3565 8.06875 11.492C7.93125 11.6275 7.8625 11.7937 7.8625 11.9907C7.8625 12.1878 7.93125 12.354 8.06875 12.4895C8.20625 12.6249 8.375 12.6927 8.575 12.6927ZM8.55625 5.0638C8.98125 5.0638 9.325 5.17771 9.5875 5.40553C9.85 5.63335 9.98125 5.92582 9.98125 6.28294C9.98125 6.52924 9.90625 6.77245 9.75625 7.01258C9.60625 7.25272 9.3625 7.5144 9.025 7.79763C8.7 8.08087 8.44063 8.3795 8.24688 8.69352C8.05313 9.00754 7.95625 9.29385 7.95625 9.55246C7.95625 9.68792 8.00938 9.79567 8.11563 9.87572C8.22188 9.95576 8.34375 9.99578 8.48125 9.99578C8.63125 9.99578 8.75625 9.94653 8.85625 9.84801C8.95625 9.74949 9.01875 9.62635 9.04375 9.47857C9.08125 9.23228 9.16562 9.0137 9.29688 8.82282C9.42813 8.63195 9.63125 8.42568 9.90625 8.20402C10.2812 7.89615 10.5531 7.58829 10.7219 7.28042C10.8906 6.97256 10.975 6.62775 10.975 6.246C10.975 5.59333 10.7594 5.06996 10.3281 4.67589C9.89688 4.28183 9.325 4.0848 8.6125 4.0848C8.1375 4.0848 7.7 4.17716 7.3 4.36187C6.9 4.54659 6.56875 4.81751 6.30625 5.17463C6.20625 5.31009 6.16563 5.44863 6.18438 5.59025C6.20313 5.73187 6.2625 5.83962 6.3625 5.91351C6.5 6.01202 6.64688 6.04281 6.80313 6.00587C6.95937 5.96892 7.0875 5.88272 7.1875 5.74726C7.35 5.5256 7.54688 5.35627 7.77813 5.23929C8.00938 5.1223 8.26875 5.0638 8.55625 5.0638ZM8.5 15.7775C7.45 15.7775 6.46875 15.5897 5.55625 15.2141C4.64375 14.8385 3.85 14.3182 3.175 13.6532C2.5 12.9882 1.96875 12.2062 1.58125 11.3073C1.19375 10.4083 1 9.43547 1 8.38873C1 7.35431 1.19375 6.38762 1.58125 5.48866C1.96875 4.58969 2.5 3.80772 3.175 3.14273C3.85 2.47775 4.64375 1.95438 5.55625 1.57263C6.46875 1.19088 7.45 1 8.5 1C9.5375 1 10.5125 1.19088 11.425 1.57263C12.3375 1.95438 13.1313 2.47775 13.8063 3.14273C14.4813 3.80772 15.0156 4.58969 15.4094 5.48866C15.8031 6.38762 16 7.35431 16 8.38873C16 9.43547 15.8031 10.4083 15.4094 11.3073C15.0156 12.2062 14.4813 12.9882 13.8063 13.6532C13.1313 14.3182 12.3375 14.8385 11.425 15.2141C10.5125 15.5897 9.5375 15.7775 8.5 15.7775ZM8.5 14.6692C10.2625 14.6692 11.7656 14.0534 13.0094 12.822C14.2531 11.5905 14.875 10.1128 14.875 8.38873C14.875 6.6647 14.2531 5.18695 13.0094 3.95549C11.7656 2.72404 10.2625 2.10831 8.5 2.10831C6.7125 2.10831 5.20312 2.72404 3.97188 3.95549C2.74063 5.18695 2.125 6.6647 2.125 8.38873C2.125 10.1128 2.74063 11.5905 3.97188 12.822C5.20312 14.0534 6.7125 14.6692 8.5 14.6692Z" fill="currentColor" stroke="currentColor" stroke-width="0.3"></path>
                                            </svg>
                                            Ask a question
                                        </button>
                                    </div>
                                    <div class="tp-product-details-query">
                                        <div class="tp-product-details-query-item d-flex align-items-center">
                                            <span>Category:  </span>
                                            <p>
                                                <asp:Label ID="product_category2" runat="server" Text=""></asp:Label></p>
                                        </div>
                                    </div>
                                    <div class="tp-product-details-social">
                                        <span>Share: </span>
                                        <a href="#"><i class="fa-brands fa-facebook-f"></i></a>
                                        <a href="#"><i class="fa-brands fa-twitter"></i></a>
                                        <a href="#"><i class="fa-brands fa-linkedin-in"></i></a>
                                        <a href="#"><i class="fa-brands fa-vimeo-v"></i></a>
                                    </div>
                                    <div class="tp-product-details-msg mb-15">
                                        <ul>
                                            <li>No return and refund policy</li>
                                        </ul>
                                    </div>
                                    <div class="tp-product-details-payment d-flex align-items-center flex-wrap justify-content-between">
                                        <p>
                                            Guaranteed safe
                                    <br>
                                            &amp; secure checkout
                                        </p>
                                        <img src="assets/img/product/icons/payment-option.png" alt="">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="tp-product-details-bottom pb-140">
                    <div class="container">
                        <div class="row">
                            <div class="col-xl-12">
                                <div class="tp-product-details-tab-nav tp-tab">
                                    <nav>
                                        <div class="nav nav-tabs justify-content-center p-relative tp-product-tab" id="navPresentationTab" role="tablist">
                                            <button class="nav-link active" id="nav-description-tab" data-bs-toggle="tab" data-bs-target="#nav-description" type="button" role="tab" aria-controls="nav-description" aria-selected="true">Description</button>
                                            <span id="productTabMarker" class="tp-product-details-tab-line" style="left: 393px; display: block; width: 112px;"></span>
                                        </div>
                                    </nav>
                                    <div class="tab-content" id="navPresentationTabContent">
                                        <div class="tab-pane fade active show" id="nav-description" role="tabpanel" aria-labelledby="nav-description-tab" tabindex="0">
                                            <div class="tp-product-details-desc-wrapper pt-80">
                                                <div class="row justify-content-center">
                                                    <div class="col-xl-10">
                                                        <asp:Literal ID="Literal1" runat="server"></asp:Literal>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>


                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
