<%@ Page Title="Add Product" ValidateRequest="false" Language="C#" MasterPageFile="~/main-user.master" AutoEventWireup="true" CodeFile="add-product.aspx.cs" Inherits="user_add_product" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="https://cdn.tiny.cloud/1/t04wmgok1gjyf1rgdxf8r5mu55yjbmbgh1wg0lpdeq5fawu2/tinymce/5/tinymce.min.js" referrerpolicy="origin"></script>
    <script type="text/javascript">
        tinymce.init({
            selector: "textarea",  // change this value according to your HTML
            content_style: "div {margin: 10px; border: 5px solid red; padding: 3px}",
            plugins: ["advlist autolink lists charmap preview hr anchor",
                "pagebreak code nonbreaking table contextmenu directionality paste link fullscreen image imagetools media searchreplace textcolor wordcount textpattern"],
            toolbar1: "styleselect | bold italic underline | preview | undo redo | link | image media | searchreplace",
            toolbar2: "alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | forecolor backcolor | fullscreen",
            relative_urls: false,
            remove_script_host: false,
            convert_urls: true,
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container-fluid">
        <div class="page-title">
            <div class="row">
                <div class="col-6">
                    <h3>Add Product</h3>
                </div>
                <div class="col-6">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="dash" data-bs-original-title="" title="">Dashboard</a></li>
                        <li class="breadcrumb-item active">Add Product</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>


    <section>
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12">

                    <div class="card">
                        <div class="card-header pb-0">
                            <h3>Add Product</h3>
                        </div>
                        <div class="card-body">
                            <div class="needs-validation">
                                <div class="row g-3">
                                    <div class="row mb-4">
                                        <div class="col-lg-9">
                                            <div class="col-md-12">
                                                <label class="form-label" for="validationCustom01">Product Name</label>
                                                <asp:TextBox ID="product_name" class="form-control" runat="server"></asp:TextBox>
                                            </div>
                                            <div class="col-md-12">
                                                <label class="form-label" for="validationCustom01">Product Category</label>
                                                <asp:TextBox ID="product_category" class="form-control" runat="server"></asp:TextBox>
                                            </div>
                                            <div class="col-md-12">
                                                <label class="form-label" for="validationCustom01">Selling Price</label>
                                                <asp:TextBox ID="selling_price" TextMode="Number" class="form-control" runat="server"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-lg-3 pt-5 pb-5">
                                            <strong class="pb-3">Product Thumbnail (Upto 1MB in size, jpg, png or gif only)</strong>
                                            <asp:FileUpload ID="FileUpload1" CssClass="form-control" runat="server" />
                                        </div>
                                    </div>
                                </div>

                                <div class="row pb-5">
                                    <div class="col-lg-12">
                                        <label class="form-label" for="validationCustom01">Product Description</label>
                                        <asp:TextBox ID="description" TextMode="MultiLine" Rows="19" class="form-control" runat="server"></asp:TextBox>
                                    </div>
                                    <div class="col-lg-12 pt-2 pb-2">
                                        <asp:Panel runat="server" ID="errordiv" Visible="false" class="alert alert-danger dark alert-dismissible fade show" role="alert">
                                            <asp:Label ID="errorlbl" runat="server" Text="Error"></asp:Label>
                                            <button class="btn-close" type="button" data-bs-dismiss="alert" aria-label="Close" data-bs-original-title="" title=""></button>
                                        </asp:Panel>
                                    </div>
                                </div>
                                <div class="text-center">
                                    <asp:Button ID="add_btn" OnClick="add_btn_Click" class="btn btn-primary" runat="server" Text="Sale Product" />
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </section>
</asp:Content>
