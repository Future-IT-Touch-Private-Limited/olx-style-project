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
            Response.Cookies["aduserli"].Expires = DateTime.Now.AddYears(-5);
        }
        catch (Exception ex)
        { }
        Response.Redirect("index");
    }
}