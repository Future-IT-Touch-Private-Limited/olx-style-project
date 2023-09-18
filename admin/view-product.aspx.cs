using System;
using System.Collections.Specialized;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Net;
using System.Reflection.Emit;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
public partial class admin_view_product : System.Web.UI.Page
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
        SqlCommand myCommand = new SqlCommand("select * from products where sr=@sr", con1);
        myCommand.Parameters.AddWithValue("@sr", Request.QueryString["sr"].ToString());
        myReader = myCommand.ExecuteReader();
        if (myReader.HasRows)
        {
            while (myReader.Read())
            {
                product_image.ImageUrl = "../products/" + myReader["product_image"].ToString();
                product_name.Text = myReader["product_name"].ToString();
                product_category.Text = myReader["product_category"].ToString();
                selling_price.Text = myReader["selling_price"].ToString();
                description.Text = myReader["description"].ToString();
                status.Text = myReader["status"].ToString();
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

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //try
            //{
            fillDetails();
            //}
            //catch (Exception ex)
            //{ }
        }
    }

    public static string CreateSlug(string input)
    {
        if (string.IsNullOrEmpty(input))
            return string.Empty;
        input = input.ToLowerInvariant().Trim();
        input = Regex.Replace(input, @"[^a-z0-9\s-]", string.Empty);
        input = Regex.Replace(input, @"\s+", "-").Trim();
        input = Regex.Replace(input, @"-+", "-");
        return input;
    }

    protected void upload_btn_Click(object sender, EventArgs e)
    {
        errordiv.Visible = false;
        successdiv.Visible = false;
        string oldFileName = current_photo_name_hf.Value;
        if (oldFileName != "no-photo.png")
        {
            try
            {
                string file_name = oldFileName;
                string path = Server.MapPath("~/products/" + file_name);
                FileInfo file = new FileInfo(path);
                if (file.Exists)
                {
                    file.Delete();
                }
                else
                {
                }
            }
            catch (Exception ex)
            {
                return;
            }
        }

        Response.AddHeader("X-XSS-Protection", "0");
        string[] validFileTypes = { "png", "jpg", "jpeg", "gif" };
        string ext = System.IO.Path.GetExtension(FileUpload1.PostedFile.FileName);
        bool isValidFile = false;
        for (int i = 0; i < validFileTypes.Length; i++)
        {
            if (ext == "." + validFileTypes[i])
            {
                isValidFile = true;
                break;
            }
        }
        if (!isValidFile)
        {
            errordiv.Visible = true;
            errorlbl.Text = "Invalid File. Please upload a File with extension " + string.Join(",", validFileTypes);
            return;
        }
        if (FileUpload1.FileBytes.Length > 1024000)
        {
            errorlbl.Text = "Large file not allowed";
            errordiv.Visible = true;
            return;
        }
        try
        {
            if (FileUpload1.HasFile)
            {
                string exten = Path.GetExtension(FileUpload1.PostedFile.FileName);
                string filename_part2 = DateTime.Now.ToString("yyyyMMddhhmmssffffff");
                FileUpload1.PostedFile.SaveAs(Server.MapPath("~/products/") + filename_part2 + exten);
                SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["cn"]);
                SqlCommand cmd = new SqlCommand("update products set product_image=@product_image where sr=@sr", con);
                cmd.Parameters.AddWithValue("@sr", Request.QueryString["sr"].ToString());
                cmd.Parameters.AddWithValue("@product_image", filename_part2 + exten);
                con.Open();
                int count = cmd.ExecuteNonQuery();
                con.Close();
                con.Dispose();
                successlbl.Text = "Product Image Updated Sucessfully";
                successdiv.Visible = true;
                fillDetails();
            }
        }
        catch (Exception ex)
        {
        }
    }

    protected void update_btn_Click(object sender, EventArgs e)
    {
        successdiv.Visible = false;
        errordiv.Visible = false;
        SqlConnection con2 = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["cn"]);
        SqlCommand cmd2 = new SqlCommand("update products set product_name=@product_name,product_category=@product_category,category_slug=@category_slug,selling_price=@selling_price,description=@description,status=@status where sr=@sr", con2);
        cmd2.Parameters.AddWithValue("@sr", Request.QueryString["sr"].ToString());
        cmd2.Parameters.AddWithValue("@product_name", product_name.Text);
        cmd2.Parameters.AddWithValue("@product_category", product_category.Text.Trim());
        cmd2.Parameters.AddWithValue("@category_slug", CreateSlug(product_category.Text.Trim()));
        cmd2.Parameters.AddWithValue("@selling_price", selling_price.Text.Trim());
        cmd2.Parameters.AddWithValue("@description", description.Text);
        cmd2.Parameters.AddWithValue("@status", status.Text);
        con2.Open();
        int count = cmd2.ExecuteNonQuery();
        con2.Close();
        con2.Dispose();
        successdiv.Visible = true;
        successlbl.Text = "Product Details Updated";
    }

    protected void deletebtn_Click(object sender, EventArgs e)
    {
        errordiv.Visible = false;
        successdiv.Visible = false;
        if (confirm_cb.Checked)
        {
            string connectionString = System.Configuration.ConfigurationManager.AppSettings["cn"];
            string deleteQuery = "DELETE FROM products WHERE sr=@sr";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                //try
                //{
                connection.Open();
                using (SqlCommand command = new SqlCommand(deleteQuery, connection))
                {
                    command.Parameters.AddWithValue("@sr", Request.QueryString["sr"].ToString());
                    int rowsAffected = command.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        Response.Redirect("products");
                    }
                    else
                    {
                    }
                }
                connection.Close();
                connection.Dispose();
                //}
                //catch (Exception ex)
                //{
                //}
            }
        }
        else
        {
            errordiv.Visible = true;
            errorlbl.Text = "Kindly confirm to delete this product.";
        }
    }

}

