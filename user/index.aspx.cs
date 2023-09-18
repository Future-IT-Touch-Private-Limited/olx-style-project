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
using System.Web.UI.WebControls;

public partial class user_index : System.Web.UI.Page
{
    private static TimeZoneInfo INDIAN_ZONE = TimeZoneInfo.FindSystemTimeZoneById("India Standard Time");
    DateTime indianTime = TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow, INDIAN_ZONE);
    public void logout()
    {
        try
        {
            //remove cookies
            //Response.Cookies["un"].Domain = "epackers.in";
            Response.Cookies["unun"].Expires = DateTime.Now.AddYears(-5);
            //Response.Cookies["pw"].Domain = "epackers.in";
            Response.Cookies["unpw"].Expires = DateTime.Now.AddYears(-5);
        }
        catch (Exception ex)
        { }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {
                if (Request.Cookies["unun"] != null)
                {
                    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["cn"]);
                    con.Open();
                    SqlCommand cmdd = new SqlCommand("select * from users where username=@username and password=@password", con);
                    cmdd.Parameters.AddWithValue("@username", Request.Cookies["unun"].Value.ToString());
                    cmdd.Parameters.AddWithValue("@password", Request.Cookies["unpw"].Value.ToString());
                    SqlDataReader reader = cmdd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        con.Close();
                        con.Dispose();
                        reader.Close();
                        Response.Redirect("../index");
                    }
                    else
                    {
                        con.Close();
                        con.Dispose();
                        reader.Close();
                        logout();
                    }
                }
            }
            catch (Exception ex)
            {
                errorlbl.Text = ex.Message;
                errordiv.Visible = true;
                return;
            }
        }
    }


    protected void loginbtn_Click(object sender, EventArgs e)
    {
        errordiv.Visible = false;
        //logout();
        try
        {
            string encryptedmobile = username.Text.Trim().ToLower().ToString();
            string encryptedpass = password.Text;
            SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["cn"]);
            con.Open();
            SqlCommand cmdd = new SqlCommand("select * from users where username=@username and password=@password and account_status=@account_status", con);
            cmdd.Parameters.AddWithValue("@username", encryptedmobile);
            cmdd.Parameters.AddWithValue("@password", encryptedpass);
            cmdd.Parameters.AddWithValue("@account_status", "Running");
            SqlDataReader reader = cmdd.ExecuteReader();

            if (reader.HasRows)
            {
                //create login cookies
                try
                {
                    //create username
                    HttpCookie unCookie = new HttpCookie("unun");
                    unCookie.Value = username.Text.Trim().ToString();
                    unCookie.Expires = DateTime.Now.AddMonths(6);
                    Response.Cookies.Add(unCookie);
                    //create password
                    HttpCookie pwCookie = new HttpCookie("unpw");
                    pwCookie.Value = password.Text.ToString();
                    pwCookie.Expires = DateTime.Now.AddMonths(6);
                    Response.Cookies.Add(pwCookie);
                    Response.Redirect("../index");
                }
                catch (Exception ex)
                {
                    errorlbl.Text = "Error While Login";
                    errordiv.Visible = true;
                }
                con.Close();
                con.Dispose();
                reader.Close();
            }
            else
            {
                con.Close();
                con.Dispose();
                reader.Close();
                errorlbl.Text = "Invalid username or password";
                errordiv.Visible = true;
                //logout();
            }
            con.Close();
            con.Dispose();
            reader.Close();
        }
        catch (Exception ex)
        {
            errorlbl.Text = ex.Message;
            errordiv.Visible = true;
        }
    }

    protected void registerbtn_Click(object sender, EventArgs e)
    {
        try
        {
            if (email_txt.Text.Trim() == "")
            {
                errordiv_register.Visible = true;
                errorlbl_register.Text = "Invalid Email Address";
                return;
            }
            if(email_txt.Text.Trim().Contains("@buckingham.ac.uk")==false)
            {
                errordiv_register.Visible = true;
                errorlbl_register.Text = "Invalid email id";
                return;
            }
            if (password_txt.Text.Contains(" "))
            {
                errordiv_register.Visible = true;
                errorlbl_register.Text = "White space not allowed in password";
                return;
            }
            if (password_txt.Text.Length < 8)
            {
                errordiv_register.Visible = true;
                errorlbl_register.Text = "Minimum 8 digits password required";
                return;
            }
            if (password_txt.Text.Length > 32)
            {
                errordiv_register.Visible = true;
                errorlbl_register.Text = "Maximum 32 digits password allowed";
                return;
            }
            if (password_txt.Text.ToString() != confirm_password_txt.Text.ToString())
            {
                errordiv_register.Visible = true;
                errorlbl_register.Text = "Password Confirmation Failed";
                return;
            }
            SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["cn"]);
            con.Open();
            SqlCommand cmdd = new SqlCommand("select * from users where username=@username", con);
            cmdd.Parameters.AddWithValue("@username", email_txt.Text.ToLower().Trim().ToString());
            SqlDataReader reader = cmdd.ExecuteReader();
            if (reader.HasRows)
            {
                con.Close();
                con.Dispose();
                reader.Close();
                errordiv.Visible = true;
                errorlbl.Text = "Account already exist with email (" + email_txt.Text.Trim().ToLower().ToString() + ")";
                return;
            }
            else
            {
                string str_username = email_txt.Text.Trim().ToLower().ToString();
                string str_password = password_txt.Text;
                SqlConnection con2 = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["cn"]);
                SqlCommand cmd2 = new SqlCommand("Insert into users (username,password,full_name,mobile,account_status) values(@username,@password,@full_name,@mobile,@account_status)", con2);
                cmd2.Parameters.AddWithValue("@username", str_username);
                cmd2.Parameters.AddWithValue("@password", str_password);
                cmd2.Parameters.AddWithValue("@full_name", "");
                cmd2.Parameters.AddWithValue("@mobile", "");
                cmd2.Parameters.AddWithValue("@account_status", "Running");

                con2.Open();
                int count2 = cmd2.ExecuteNonQuery();
                con2.Close();
                con2.Dispose();
                con.Close();
                con.Dispose();
                reader.Close();
                //create username
                HttpCookie unCookie = new HttpCookie("unun");
                unCookie.Value = email_txt.Text.Trim().ToLower().ToString();
                unCookie.Expires = DateTime.Now.AddMonths(6);
                Response.Cookies.Add(unCookie);
                //create password
                HttpCookie pwCookie = new HttpCookie("unpw");
                pwCookie.Value = password_txt.Text.ToString();
                pwCookie.Expires = DateTime.Now.AddMonths(6);
                Response.Cookies.Add(pwCookie);
                Response.Redirect("../index");

            }
        }
        catch(Exception ex)
        {
            errordiv_register.Visible = true;
            errorlbl_register.Text = ex.Message;
        }




    }

}