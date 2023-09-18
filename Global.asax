<%@ Application Language="C#" %>
<%@ Import Namespace="System.Web.Routing" %>
<script runat="server">
    void Application_Start(object sender, EventArgs e) 
    {
	
        RegisterRoutes(RouteTable.Routes);
    }
    static void RegisterRoutes(RouteCollection routes)
    {
        routes.MapPageRoute("url1", "cart", "~/cart.aspx");
        routes.MapPageRoute("url2", "category", "~/category.aspx");
        routes.MapPageRoute("url3", "checkout", "~/checkout.aspx");
        routes.MapPageRoute("url4", "contact-us", "~/contact-us.aspx");
        routes.MapPageRoute("url5", "index", "~/index.aspx");
        routes.MapPageRoute("url6", "product", "~/product.aspx");
        routes.MapPageRoute("url7", "search", "~/search.aspx");
        routes.MapPageRoute("url8", "shop", "~/shop.aspx");
        routes.MapPageRoute("url9", "success", "~/success.aspx");

        routes.MapPageRoute("url10", "admin/all-users", "~/admin/all-users.aspx");
        routes.MapPageRoute("url11", "admin/dash", "~/admin/dash.aspx");
        routes.MapPageRoute("url12", "admin/index", "~/admin/index.aspx");
        routes.MapPageRoute("url13", "admin/logout", "~/admin/logout.aspx");
        routes.MapPageRoute("url14", "admin/products-sold", "~/admin/products-sold.aspx");
        routes.MapPageRoute("url15", "admin/products", "~/admin/products.aspx");
        routes.MapPageRoute("url16", "admin/view-product", "~/admin/view-product.aspx");

        routes.MapPageRoute("url17", "user/add-product", "~/user/add-product.aspx");
        routes.MapPageRoute("url18", "user/chat", "~/user/chat.aspx");
        routes.MapPageRoute("url19", "user/dash", "~/user/dash.aspx");
        routes.MapPageRoute("url20", "user/index", "~/user/index.aspx");
        routes.MapPageRoute("url21", "user/logout", "~/user/logout.aspx");
        routes.MapPageRoute("url22", "user/my-purchase", "~/user/my-purchase.aspx");
        routes.MapPageRoute("url23", "user/my-sale", "~/user/my-sale.aspx");
        routes.MapPageRoute("url24", "user/products", "~/user/products.aspx");
        routes.MapPageRoute("url25", "user/transaction-history", "~/user/transaction-history.aspx");
        routes.MapPageRoute("url26", "user/view-product", "~/user/view-product.aspx");
    }

    protected void Application_BeginRequest(Object sender, EventArgs e)
    {
        
    }

</script>