using System;
using System.Collections.Specialized;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Net;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class user_chat : System.Web.UI.Page
{
    private static TimeZoneInfo INDIAN_ZONE = TimeZoneInfo.FindSystemTimeZoneById("India Standard Time");
    DateTime indianTime = TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow, INDIAN_ZONE);


    public void fillRepeater()
    {
        string query = "select * from chat where (from_username=@from_username or to_username=@from_username) and (to_username=@to_username or from_username=@to_username) ORDER BY sr asc";
        using (SqlConnection connection = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["cn"]))
        {
            SqlCommand command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@from_username", Request.Cookies["unun"].Value.ToString());
            command.Parameters.AddWithValue("@to_username", Request.QueryString["e"].ToString());
            connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            DataTable dataTable = new DataTable();
            dataTable.Load(reader);
            Repeater1.DataSource = dataTable;
            Repeater1.DataBind();
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            receiver_lbl.Text = Request.QueryString["e"].ToString();
            fillRepeater();
        }
    }

    protected string GetCssClass(string fromUsername)
    {
        string myUsername = Session["Username"].ToString();
        if (fromUsername == myUsername)
        {
            return "message sent";
        }
        else
        {
            return "message received";
        }
    }

    protected void sendbtn_Click(object sender, EventArgs e)
    {
        if (messagetxt.Text.Trim() != "")
        {
            SqlConnection con2 = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["cn"]);
            SqlCommand cmd2 = new SqlCommand("Insert into chat (from_username,to_username,message,message_date,message_time,query_message_date,sender_name,receiver_name,status) values(@from_username,@to_username,@message,@message_date,@message_time,@query_message_date,@sender_name,@receiver_name,@status)", con2);
            cmd2.Parameters.AddWithValue("@from_username", Request.Cookies["unun"].Value.ToString());
            cmd2.Parameters.AddWithValue("@to_username", Request.QueryString["e"].ToString());
            cmd2.Parameters.AddWithValue("@message", messagetxt.Text.Trim().ToString());
            cmd2.Parameters.AddWithValue("@message_date", indianTime.ToString("dd MMM yyy "));
            cmd2.Parameters.AddWithValue("@message_time", indianTime.ToString("hh:mm:ss tt"));
            cmd2.Parameters.AddWithValue("@query_message_date", indianTime.ToString("yyyyMMdd"));
            cmd2.Parameters.AddWithValue("@sender_name", "");
            cmd2.Parameters.AddWithValue("@receiver_name", "");
            cmd2.Parameters.AddWithValue("@status", "Seen");
            con2.Open();
            int count2 = cmd2.ExecuteNonQuery();
            con2.Close();
            con2.Dispose();
            messagetxt.Text = "";
            fillRepeater();
        }
        else
        {
            messagetxt.Focus();
        }
    }



    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        Panel messageDiv = (Panel)e.Item.FindControl("messageDiv");
        HiddenField from_username_hf = (HiddenField)e.Item.FindControl("from_username_hf");
        if (Request.Cookies["unun"].Value.ToString() == from_username_hf.Value)
        {
            messageDiv.CssClass = "message sent";
        }
        else
        {
            messageDiv.CssClass = "message received";
        }
    }
}
