using System;
using System.Collections.Specialized;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Net;
using System.Reflection.Emit;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class main_user : System.Web.UI.MasterPage
{
    private static TimeZoneInfo INDIAN_ZONE = TimeZoneInfo.FindSystemTimeZoneById("India Standard Time");
    DateTime indianTime = TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow, INDIAN_ZONE);

    public void fillDetails()
    {
        //try
        //{
        SqlConnection con1 = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["cn"]);
        DataTable dt = new DataTable();
        con1.Open();
        SqlDataReader myReader = null;
        SqlCommand myCommand = new SqlCommand("select * from users where username=@username and account_status=@account_status", con1);
        myCommand.Parameters.AddWithValue("@username", Request.Cookies["unun"].Value.ToString());
        myCommand.Parameters.AddWithValue("@account_status", "Running");
        myReader = myCommand.ExecuteReader();
        if (myReader.HasRows)
        {
            while (myReader.Read())
            {
                full_name.Text = myReader["full_name"].ToString();
            }
        }
        else
        {
        }
        con1.Close();
        con1.Dispose();
        myReader.Close();
        //}
        //catch (Exception ex)
        //{
        //}
    }

    public void fillRepeater()
    {
        string query = "select top 5 * from chat where from_username=@my_username or to_username=@my_username and query_message_date=@query_message_date ORDER BY sr DESC";
        using (SqlConnection connection = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["cn"]))
        {
            SqlCommand command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@my_username", Request.Cookies["unun"].Value.ToString());
            command.Parameters.AddWithValue("@query_message_date", indianTime.ToString("yyyyMMdd"));
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
            fillDetails();
            fillRepeater();
        }
    }
}
