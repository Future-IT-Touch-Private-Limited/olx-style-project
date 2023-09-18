using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class contact_us : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void submitbtn_Click(object sender, EventArgs e)
    {
        errorlbl.Visible = false;
        successlbl.Visible = false;
        if(nametxt.Text.Trim().ToString()=="")
        {
            errorlbl.Text = "Kindly enter valid name";
            errorlbl.Visible = true;
            return;
        }
        if (emailtxt.Text.Trim().ToString() == "")
        {
            errorlbl.Text = "Kindly enter valid email address";
            errorlbl.Visible = true;
            return;
        }
        if (querytxt.Text.Trim().ToString() == "")
        {
            errorlbl.Text = "Kindly enter your query";
            errorlbl.Visible = true;
            return;
        }
        try
        {
            MailMessage mail = new MailMessage();
            SmtpClient smtpC = new SmtpClient(System.Configuration.ConfigurationManager.AppSettings["host"].ToString());
            smtpC.EnableSsl = true;
            mail.From = new MailAddress(System.Configuration.ConfigurationManager.AppSettings["fromemail"].ToString());
            mail.To.Add("2201317@buckingham.ac.uk");
            mail.IsBodyHtml = true;
            
            mail.Body = "<strong>New Query from user<br></strong> Name: "+nametxt.Text.Trim()+"<br>Mobile: "+mobiletxt.Text.Trim()+"<br>Email Address: "+emailtxt.Text+"<br>Query: "+querytxt.Text;
            mail.Subject = "New Query from user";
            smtpC.Port = Convert.ToInt32(System.Configuration.ConfigurationManager.AppSettings["port"].ToString());
            string pas = (System.Configuration.ConfigurationManager.AppSettings["emailpassword"].ToString());
            smtpC.UseDefaultCredentials = false;
            smtpC.Credentials = new System.Net.NetworkCredential(System.Configuration.ConfigurationManager.AppSettings["fromemail"].ToString(), pas);
            smtpC.Send(mail);
            successlbl.Text = "Details submitted sucessfully. We will connect to you shortly. ThankYou!";
            successlbl.Visible = true;
            submitbtn.Visible = false;
        }
        catch (Exception ex)
        {
        }

    }
}