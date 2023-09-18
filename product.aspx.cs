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

public partial class product : System.Web.UI.Page
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
        SqlCommand myCommand = new SqlCommand("select * from products where sr=@sr and status=@status", con1);
        myCommand.Parameters.AddWithValue("@sr", Request.QueryString["sr"].ToString());
        myCommand.Parameters.AddWithValue("@status", "Published");
        myReader = myCommand.ExecuteReader();
        if (myReader.HasRows)
        {
            while (myReader.Read())
            {
                Image1.ImageUrl = "../products/" + myReader["product_image"].ToString();
                product_category.Text = myReader["product_category"].ToString();
                product_name.Text = myReader["product_name"].ToString();
                selling_price.Text = myReader["selling_price"].ToString();
                product_category2.Text = myReader["product_category"].ToString();
                Literal1.Text = myReader["description"].ToString();

                product_id_hf.Value = myReader["sr"].ToString();
                product_by_hf.Value = myReader["product_by"].ToString();
                product_category_hf.Value = myReader["product_category"].ToString();
                category_slug_hf.Value = myReader["category_slug"].ToString();
                selling_price_hf.Value = myReader["selling_price"].ToString();
                product_image_hf.Value = myReader["product_image"].ToString();
                product_name_hf.Value = myReader["product_name"].ToString();

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

    public void checkIfAdded()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["cn"]);
        con.Open();
        SqlCommand cmdd = new SqlCommand("select * from transactions where purchased_by=@purchased_by and product_id=@product_id and query_added_date=@query_added_date", con);
        cmdd.Parameters.AddWithValue("@purchased_by", Request.Cookies["unun"].Value.ToString());
        cmdd.Parameters.AddWithValue("@product_id", Request.QueryString["sr"].ToString());
        cmdd.Parameters.AddWithValue("@query_added_date", indianTime.ToString("yyyyMMdd"));
        SqlDataReader reader = cmdd.ExecuteReader();
        if (reader.HasRows)
        {
            addcartbtn.Visible = false;
            removecartbtn.Visible=true;
        }
        else
        {
            addcartbtn.Visible = true;
            removecartbtn.Visible = false;
        }
        con.Close();
        con.Dispose();
        reader.Close();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            fillDetails();
            checkIfAdded();
        }
    }


    protected void addcartbtn_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["cn"]);
        con.Open();
        SqlCommand cmdd = new SqlCommand("select * from users where username=@username and password=@password", con);
        cmdd.Parameters.AddWithValue("@username", Request.Cookies["unun"].Value.ToString());
        cmdd.Parameters.AddWithValue("@password", Request.Cookies["unpw"].Value.ToString());
        SqlDataReader reader = cmdd.ExecuteReader();
        if (reader.HasRows)
        {
            SqlConnection con2 = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["cn"]);
            SqlCommand cmd2 = new SqlCommand("Insert into transactions (transaction_id,product_id,product_by,purchased_by,product_category,category_slug,selling_price,product_image,status,query_added_date,order_id,product_name) values(@transaction_id,@product_id,@product_by,@purchased_by,@product_category,@category_slug,@selling_price,@product_image,@status,@query_added_date,@order_id,@product_name)", con2);
            cmd2.Parameters.AddWithValue("@transaction_id", indianTime.ToString("yyMMddhhmmssffffff"));
            cmd2.Parameters.AddWithValue("@product_id", product_id_hf.Value);
            cmd2.Parameters.AddWithValue("@product_by", product_by_hf.Value.ToString());
            cmd2.Parameters.AddWithValue("@purchased_by", Request.Cookies["unun"].Value.ToString());
            cmd2.Parameters.AddWithValue("@product_category", product_category_hf.Value);
            cmd2.Parameters.AddWithValue("@category_slug", category_slug_hf.Value);
            cmd2.Parameters.AddWithValue("@selling_price", selling_price_hf.Value);
            cmd2.Parameters.AddWithValue("@product_image", product_image_hf.Value);
            cmd2.Parameters.AddWithValue("@status", "Pending");
            cmd2.Parameters.AddWithValue("@query_added_date", indianTime.ToString("yyyyMMdd"));
            cmd2.Parameters.AddWithValue("@order_id", Request.Cookies["oid"].Value.ToString());
            cmd2.Parameters.AddWithValue("@product_name", product_name_hf.Value);
            con2.Open();
            int count2 = cmd2.ExecuteNonQuery();
            con2.Close();
            con2.Dispose();
            removecartbtn.Visible = true;
            addcartbtn.Visible = false;
            con.Close();
            con.Dispose();
            reader.Close();
            checkIfAdded();
        }
        else
        {
            con.Close();
            con.Dispose();
            reader.Close();

            Response.Redirect("~/user/index");
        }
    }

    protected void removecartbtn_Click(object sender, EventArgs e)
    {
        string connectionString = System.Configuration.ConfigurationManager.AppSettings["cn"];
        string deleteQuery = "DELETE FROM transactions WHERE purchased_by=@purchased_by and product_id=@sr and status=@status";
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            try
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand(deleteQuery, connection))
                {
                    command.Parameters.AddWithValue("@purchased_by", Request.Cookies["unun"].Value.ToString());
                    command.Parameters.AddWithValue("@sr", product_id_hf.Value);
                    command.Parameters.AddWithValue("@status", "Pending");


                    int rowsAffected = command.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        checkIfAdded();
                        //fillRepeater();
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