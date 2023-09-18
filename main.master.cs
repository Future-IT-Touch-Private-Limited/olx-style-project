using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class main : System.Web.UI.MasterPage
{private static TimeZoneInfo INDIAN_ZONE = TimeZoneInfo.FindSystemTimeZoneById("India Standard Time");
    DateTime indianTime = TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow, INDIAN_ZONE);

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string str_oid = DateTime.Now.ToString("yyMMddhhmmssffffff");
            if (Request.Cookies["oid"] == null)
            {
                HttpCookie unCookie = new HttpCookie("oid");
                unCookie.Value = DateTime.Now.ToString("yyMMddhhmmssffffff");
                unCookie.Expires = DateTime.Now.AddYears(10);
                Response.Cookies.Add(unCookie);
            }
            else
            {
                if (Request.Cookies["oid"] != null)
                {
                    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["cn"]);
                    con.Open();
                    SqlCommand cmdd = new SqlCommand("select * from transactions where order_id=@order_id and status<>@status", con);
                    cmdd.Parameters.AddWithValue("order_id", Request.Cookies["oid"].Value.ToString());
                    cmdd.Parameters.AddWithValue("status", "Pending");
                    SqlDataReader reader = cmdd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        try
                        {
                            Response.Cookies["oid"].Expires = DateTime.Now.AddYears(-15);
                        }
                        catch (Exception ex)
                        { }
                        HttpCookie unCookie = new HttpCookie("oid");
                        unCookie.Value = str_oid;
                        unCookie.Expires = DateTime.Now.AddYears(10);
                        Response.Cookies.Add(unCookie);
                        con.Close();
                        con.Dispose();
                        reader.Close();
                    }
                    else
                    {
                        con.Close();
                        con.Dispose();
                        reader.Close();
                    }
                    con.Close();
                    con.Dispose();
                    reader.Close();
                }
                else
                {
                    HttpCookie unCookie = new HttpCookie("oid");
                    unCookie.Value = DateTime.Now.ToString("yyMMddhhmmssffffff");
                    unCookie.Expires = DateTime.Now.AddYears(10);
                    Response.Cookies.Add(unCookie);
                }
            }
        }
    }

    protected void searchbtn_ServerClick(object sender, EventArgs e)
    {
        
    }


    protected void Button1_Click(object sender, EventArgs e)
    {
        if (searchtxt2.Text.Trim() != "")
        {
            Response.Redirect("search?q=" + searchtxt2.Text.Trim().ToString());
        }
    }

    protected void searchbtn2_ServerClick(object sender, EventArgs e)
    {
        Response.Redirect("search?q=" + searchtxt2.Text.Trim().ToString());
    }
}
