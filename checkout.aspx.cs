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
public partial class checkout : System.Web.UI.Page
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
        if (!IsPostBack)
        {
            try
            {
                SqlConnection con01 = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["cn"]);
                string myScalarQuery01 = "select count(*) from transactions where purchased_by=@purchased_by and query_added_date=@query_added_date";
                SqlCommand myCommand01 = new SqlCommand(myScalarQuery01, con01);
                myCommand01.Parameters.AddWithValue("@purchased_by", Request.Cookies["unun"].Value.ToString());
                myCommand01.Parameters.AddWithValue("@query_added_date", indianTime.ToString("yyyyMMdd"));
                myCommand01.Connection.Open();
                int countuser01 = (int)myCommand01.ExecuteScalar();
                con01.Close();
                con01.Dispose();
                if(countuser01<1)
                {
                    Response.Redirect("shop");
                }
            }
            catch (Exception ex)
            {
                Response.Redirect("shop");
            }

            fillRepeater();
            subtotal_lbl.Text = "£ " + sellingPriceTotal();
            //gstcharges_lbl.Text = "£ " + gstTotal();
            //shipping_charges_lbl.Text = "£ " + shippingTotal();
            total_lbl.Text = "£ " + sellingPriceTotal();
        }
    }

    protected void checkout_btn_Click(object sender, EventArgs e)
    {
        try
        {
            SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["cn"]);
            SqlCommand cmd = new SqlCommand("update transactions set status=@status where purchased_by=@purchased_by and status=@status2 and query_added_date=@query_added_date", con);
            cmd.Parameters.AddWithValue("@purchased_by", Request.Cookies["unun"].Value.ToString());
            cmd.Parameters.AddWithValue("@status", "Success");
            cmd.Parameters.AddWithValue("@status2", "Pending");
            cmd.Parameters.AddWithValue("@query_added_date", indianTime.ToString("yyyyMMdd"));
            con.Open();
            int count = cmd.ExecuteNonQuery();
            con.Close();
            con.Dispose();
        }
        catch(Exception ex)
        {
        }

        //try
        //{
            string connectionString = System.Configuration.ConfigurationManager.AppSettings["cn"];
            string idsString = product_ids_hf.Value;
            string[] ids = idsString.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                foreach (string id in ids)
                {
                    int rowId = int.Parse(id);
                    string status = "Sold";
                    string updateQuery = "UPDATE products SET status=@Status WHERE sr=@ID";
                    using (SqlCommand command = new SqlCommand(updateQuery, connection))
                    {
                        command.Parameters.AddWithValue("@status", status);
                        command.Parameters.AddWithValue("@ID", rowId);
                        command.ExecuteNonQuery();
                    }
                }
                connection.Close();
            }
        //}
        //catch (Exception ex)
        //{
        //}

        Response.Redirect("success");
    }

    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        HiddenField sr_hf = (HiddenField)e.Item.FindControl("sr_hf");
        product_ids_hf.Value += sr_hf.Value+",";
    }

}