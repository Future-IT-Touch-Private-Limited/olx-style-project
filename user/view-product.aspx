<%@ Page Title="View Product" ValidateRequest="false" Language="C#" MasterPageFile="~/main-user.master" AutoEventWireup="true" CodeFile="view-product.aspx.cs" Inherits="user_view_product" %>

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
                    <h3>View Product</h3>
                </div>
                <div class="col-6">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="dash" data-bs-original-title="" title="">Dashboard</a></li>
                        <li class="breadcrumb-item active">View Product</li>
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
                            <h3>Update Product Details</h3>
                        </div>
                        <div class="card-body">
                            <div class="needs-validation">
                                <div class="row g-3">
                                    <div class="row mb-4">
                                        <div class="col-lg-12">

                                            <div class="col-lg-12 pt-2 pb-2">
                                                <asp:Panel runat="server" ID="errordiv" Visible="false" class="alert alert-danger dark alert-dismissible fade show" role="alert">
                                                    <asp:Label ID="errorlbl" runat="server" Text="Error"></asp:Label>
                                                    <button class="btn-close" type="button" data-bs-dismiss="alert" aria-label="Close" data-bs-original-title="" title=""></button>
                                                </asp:Panel>
                                            </div>
                                            <div class="col-lg-12 pt-2 pb-2">
                                                <asp:Panel runat="server" ID="successdiv" Visible="false" class="alert alert-success dark alert-dismissible fade show" role="alert">
                                                    <asp:Label ID="successlbl" runat="server" Text="Error"></asp:Label>
                                                    <button class="btn-close" type="button" data-bs-dismiss="alert" aria-label="Close" data-bs-original-title="" title=""></button>
                                                </asp:Panel>
                                            </div>
                                        </div>
                                        <div class="col-lg-9">
                                            <div class="col-md-12 mb-3">
                                                <asp:HiddenField ID="current_photo_name_hf" Visible="false" runat="server" />
                                                <label class="form-label" for="validationCustom01">Product Name</label>
                                                <asp:TextBox ID="product_name" class="form-control" runat="server"></asp:TextBox>
                                            </div>
                                            <div class="col-md-12 mb-3">
                                                <label class="form-label" for="validationCustom01">Product Category</label>
                                                <asp:TextBox ID="product_category" class="form-control" runat="server"></asp:TextBox>
                                            </div>
                                            <div class="col-lg-12 mb-3">
                                                <div class="row">
                                                    <div class="col-md-8">
                                                        <label class="form-label" for="validationCustom01">Selling Price</label>
                                                        <asp:TextBox ID="selling_price" TextMode="Number" class="form-control" runat="server"></asp:TextBox>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <label class="form-label" for="validationCustom01">Status</label>
                                                        <asp:DropDownList ID="status" CssClass="form-control" runat="server">
                                                            <asp:ListItem>Published</asp:ListItem>
                                                            <asp:ListItem>Sold</asp:ListItem>
                                                            <asp:ListItem>Draft</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-3">
                                            <asp:Image ID="product_image" CssClass="img-fluid" runat="server" />
                                            <strong class="pb-3">Product Thumbnail (Upto 1MB in size, jpg, png or gif only)</strong>
                                            <asp:FileUpload ID="FileUpload1" CssClass="form-control" runat="server" />
                                            <div class="text-center pt-3">
                                                <asp:Button ID="upload_btn" CssClass="btn btn-md btn-primary" OnClick="upload_btn_Click" runat="server" Text="Change Thumbnail" />
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row pb-5">
                                    <div class="col-lg-12">
                                        <label class="form-label" for="validationCustom01">Product Description</label>
                                        <asp:TextBox ID="description" TextMode="MultiLine" Rows="19" class="form-control" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-8">
                                        <div class="text-center">
                                            <asp:Button ID="update_btn" OnClick="update_btn_Click" class="btn btn-primary" runat="server" Text="Update Product" />
                                        </div>
                                    </div>
                                    <div class="col-lg-4">
                                        <div class="text-center">
                                            <div>
                                                <asp:CheckBox ID="confirm_cb" Text="Confirm to delete this product" runat="server" />
                                            </div>
                                            <div>
                                                <asp:Button ID="deletebtn" OnClick="deletebtn_Click" class="btn btn-sm btn-danger" runat="server" Text="Delete Product" />
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
</asp:Content>
