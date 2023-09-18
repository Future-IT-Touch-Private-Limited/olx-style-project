using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class user_logout : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            //remove cookies
            Response.Cookies["unun"].Expires = DateTime.Now.AddYears(-5);
            Response.Cookies["unpw"].Expires = DateTime.Now.AddYears(-5);
            Response.Redirect("index");
        }
        catch (Exception ex)
        { }
    }
}