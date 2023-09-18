using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class cart : System.Web.UI.Page
{
    private static TimeZoneInfo INDIAN_ZONE = TimeZoneInfo.FindSystemTimeZoneById("India Standard Time");
    DateTime indianTime = TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow, INDIAN_ZONE);

    public void fillRepeater()
    {
        string query = "select * from transactions where purchased_by=@purchased_by and status=@status and query_added_date=@query_added_date ORDER BY sr DESC";
        using (SqlConnection connection = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["cn"]))
        {
            SqlCommand command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@purchased_by", Request.Cookies["unun"].Value.ToString());
            command.Parameters.AddWithValue("@status", "Pending");
            command.Parameters.AddWithValue("@query_added_date", indianTime.ToString("yyyyMMdd"));
            connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            DataTable dataTable = new DataTable();
            dataTable.Load(reader);
            Repeater1.DataSource = dataTable;
            Repeater1.DataBind();
        }
    }

    public string sellingPriceTotal()
    {
        SqlConnection connection = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["cn"]);
        string query = "select sum(selling_price) from transactions where purchased_by=@purchased_by and status=@status and query_added_date=@query_added_date";
        SqlCommand command = new SqlCommand(query, connection);
        command.Parameters.AddWithValue("@purchased_by", Request.Cookies["unun"].Value.ToString());
        command.Parameters.AddWithValue("@status", "Pending");
        command.Parameters.AddWithValue("@query_added_date", indianTime.ToString("yyyyMMdd"));
        connection.Open();
        object total = command.ExecuteScalar();
        connection.Close();
        string str_total = total.ToString();
        if (str_total.Trim() == "" || str_total == null)
        {
            str_total = "0";
        }
        else
        {
            str_total = total.ToString();
        }
        return str_total.ToString();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            fillRepeater();
            subtotal_lbl.Text= "£ " + sellingPriceTotal();
            //gstcharges_lbl.Text = "£ " + gstTotal();
            //total_lbl.Text = "£ " + (Convert.ToInt32(sellingPriceTotal())+Convert.ToInt32(gstTotal())+ Convert.ToInt32(shippingTotal())).ToString();
        }
    }

    protected void goto_checkout_btn_Click(object sender, EventArgs e)
    {
        Response.Redirect("checkout");
    }

    protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        HiddenField sr = (HiddenField)e.Item.FindControl("sr");
        if (e.CommandName == "remove_btn")
        {
            string connectionString = System.Configuration.ConfigurationManager.AppSettings["cn"];
            string deleteQuery = "DELETE FROM transactions WHERE sr=@sr";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                try
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand(deleteQuery, connection))
                    {
                        command.Parameters.AddWithValue("@sr", sr.Value);
                        int rowsAffected = command.ExecuteNonQuery();
                        if (rowsAffected > 0)
                        {
                            fillRepeater();
                            subtotal_lbl.Text = "£ " + sellingPriceTotal();
                        }
                        else
                        {
                        }
                    }
                }
                catch (Exception ex)
                {
                }
            }
        }
    }

}