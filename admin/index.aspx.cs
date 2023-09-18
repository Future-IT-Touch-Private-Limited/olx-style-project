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

public partial class admin_index : System.Web.UI.Page
{
    SqlCommand cmd;
    SqlDataAdapter da;
    DataSet ds;
    int inc = 0;
    string EncryptionKey = "ravindersinghgodara123admin";
    string EncryptionKey2 = "rvndr@123@adm";

    public static string MD5Hash(string text)
    {
        MD5 md5 = new MD5CryptoServiceProvider();
        md5.ComputeHash(ASCIIEncoding.ASCII.GetBytes(text));
        byte[] result = md5.Hash;
        StringBuilder strBuilder = new StringBuilder();
        for (int i = 0; i < result.Length; i++)
        {
            strBuilder.Append(result[i].ToString("x2"));
        }
        return strBuilder.ToString();
    }

    public string EncryptString(string Message, string Passphrase)
    {
        byte[] Results;
        System.Text.UTF8Encoding UTF8 = new System.Text.UTF8Encoding();
        MD5CryptoServiceProvider HashProvider = new MD5CryptoServiceProvider();
        byte[] TDESKey = HashProvider.ComputeHash(UTF8.GetBytes(Passphrase));
        TripleDESCryptoServiceProvider TDESAlgorithm = new TripleDESCryptoServiceProvider();
        TDESAlgorithm.Key = TDESKey;
        TDESAlgorithm.Mode = CipherMode.ECB;
        TDESAlgorithm.Padding = PaddingMode.PKCS7;
        byte[] DataToEncrypt = UTF8.GetBytes(Message);
        try
        {
            ICryptoTransform Encryptor = TDESAlgorithm.CreateEncryptor();
            Results = Encryptor.TransformFinalBlock(DataToEncrypt, 0, DataToEncrypt.Length);
        }
        finally
        {
            TDESAlgorithm.Clear();
            HashProvider.Clear();
        }
        return Convert.ToBase64String(Results);
    }

    public string DecryptString(string Message, string Passphrase)
    {
        byte[] Results;
        System.Text.UTF8Encoding UTF8 = new System.Text.UTF8Encoding();
        MD5CryptoServiceProvider HashProvider = new MD5CryptoServiceProvider();
        byte[] TDESKey = HashProvider.ComputeHash(UTF8.GetBytes(Passphrase));
        TripleDESCryptoServiceProvider TDESAlgorithm = new TripleDESCryptoServiceProvider();
        TDESAlgorithm.Key = TDESKey;
        TDESAlgorithm.Mode = CipherMode.ECB;
        TDESAlgorithm.Padding = PaddingMode.PKCS7;
        byte[] DataToDecrypt = Convert.FromBase64String(Message);
        try
        {
            ICryptoTransform Decryptor = TDESAlgorithm.CreateDecryptor();
            Results = Decryptor.TransformFinalBlock(DataToDecrypt, 0, DataToDecrypt.Length);
        }
        finally
        {
            TDESAlgorithm.Clear();
            HashProvider.Clear();
        }
        return UTF8.GetString(Results);
    }

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
                        Response.Redirect("all-users");
                    }
                    else
                    {

                    }
                }
                else
                {
                    Response.Cookies["aduserli"].Expires = DateTime.Now.AddYears(-10);
                }
            }
            catch (Exception ex)
            {
            }
        }
    }

    protected void loginbtn_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Cookies["aduserli"].Expires = DateTime.Now.AddYears(-5);
            errordiv.Visible = false;

            if (username.Text.Trim().ToString() == System.Configuration.ConfigurationManager.AppSettings["username"].ToString() && password.Text.Trim().ToString() == System.Configuration.ConfigurationManager.AppSettings["password"].ToString())
            {
                HttpCookie LoginInfo = new HttpCookie("aduserli");
                LoginInfo.Values["adusercmpun"] = username.Text.Trim().ToString();
                LoginInfo.Values["adusercmppw"] = password.Text.ToString();
                LoginInfo.Expires = DateTime.Now.AddDays(1);
                Response.Cookies.Add(LoginInfo);
                Response.Redirect("all-users");
            }
            else
            {
                errordiv.Visible = true;
                //return;
            }

        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
    }
}