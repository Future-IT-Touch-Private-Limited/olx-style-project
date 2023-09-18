using System;
using System.Collections.Specialized;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Net;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class user_add_product : System.Web.UI.Page
{
    private static TimeZoneInfo INDIAN_ZONE = TimeZoneInfo.FindSystemTimeZoneById("India Standard Time");
    DateTime indianTime = TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow, INDIAN_ZONE);
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
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void add_btn_Click(object sender, EventArgs e)
    {
        //try
        //{
        errordiv.Visible = false;
        if (product_name.Text.Trim() == "")
        {
            errordiv.Visible = true;
            errorlbl.Text = "Kindly Enter Product Name";
            return;
        }
        if (selling_price.Text.Trim() == "")
        {
            errordiv.Visible = true;
            errorlbl.Text = "Selling Price Required";
            return;
        }

        string file_name = "no-photo.png";
        if (FileUpload1.HasFile)
        {
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
            string exten = Path.GetExtension(FileUpload1.PostedFile.FileName);
            string filename_part2 = DateTime.Now.ToString("yyyyMMddhhmmssffffff");
            file_name = filename_part2 + exten;
            FileUpload1.PostedFile.SaveAs(Server.MapPath("~/products/") + filename_part2 + exten);
        }
        else
        {
            file_name = "no-photo.png";
        }

        SqlConnection con2 = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["cn"]);
        SqlCommand cmd2 = new SqlCommand("Insert into products (product_by,product_name,product_category,category_slug,selling_price,product_image,description,product_date,query_product_date,status) values(@product_by,@product_name,@product_category,@category_slug,@selling_price,@product_image,@description,@product_date,@query_product_date,@status)", con2);
        cmd2.Parameters.AddWithValue("@product_by", Request.Cookies["unun"].Value.ToString());
        cmd2.Parameters.AddWithValue("@product_name", product_name.Text.Trim().ToString());
        cmd2.Parameters.AddWithValue("@product_category", product_category.Text.Trim().ToString());
        cmd2.Parameters.AddWithValue("@category_slug", CreateSlug(product_category.Text.Trim().ToString()));
        cmd2.Parameters.AddWithValue("@selling_price", selling_price.Text.ToString());
        cmd2.Parameters.AddWithValue("@product_image", file_name);
        cmd2.Parameters.AddWithValue("@description", description.Text.Trim().ToString());
        cmd2.Parameters.AddWithValue("@product_date", indianTime.ToString("dd MMM yyyy hh:mm:ss tt"));
        cmd2.Parameters.AddWithValue("@query_product_date", indianTime.ToString("yyyyMMdd"));
        cmd2.Parameters.AddWithValue("@status", "Published");
        con2.Open();
        int count2 = cmd2.ExecuteNonQuery();
        con2.Close();
        con2.Dispose();
        Response.Redirect("products");
        //}
        //catch (Exception ex)
        //{
        //    errordiv.Visible = true;
        //    errorlbl.Text = ex.Message;
        //}
    }

}