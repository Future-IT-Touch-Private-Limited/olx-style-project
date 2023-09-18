using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Configuration.Provider;
using System.Net;
using System.Collections;
using System.Web.Configuration;
using System.IO;
using System.Text;
using System.Drawing.Printing;
using System.Security.Cryptography;

public partial class main_admin : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {
                if (HttpContext.Current.Request.Cookies["aduserli"] != null)
                {
                    if (Request.Cookies["aduserli"]["adusercmpun"].ToString() == System.Configuration.ConfigurationManager.AppSettings["username"] && Request.Cookies["aduserli"]["adusercmppw"].ToString() == System.Configuration.ConfigurationManager.AppSettings["password"])
                    {

                    }
                    else
                    {
                        try
                        {
                            Response.Cookies["aduserli"].Expires = DateTime.Now.AddYears(-5);
                            Response.Redirect("index");
                        }
                        catch (Exception ex)
                        {
                        }
                    }
                }
                else
                {
                    Response.Redirect("index");
                }
            }
            catch (Exception ex)
            {
            }
        }
    }
}
