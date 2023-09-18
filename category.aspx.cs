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

public partial class category : System.Web.UI.Page
{
    private static TimeZoneInfo INDIAN_ZONE = TimeZoneInfo.FindSystemTimeZoneById("India Standard Time");
    DateTime indianTime = TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow, INDIAN_ZONE);

    PagedDataSource pgsource = new PagedDataSource();
    int findex, lindex;
    DataRow dr;
    DataTable GetData()
    {
        DataTable dtable = new DataTable();
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["cn"]);
        string strcon = "select * from products where status='Published' and category_slug like '%'+@category_slug+'%' ORDER BY sr DESC";
        SqlCommand cmd = new SqlCommand(strcon, con);
        cmd.Parameters.AddWithValue("@category_slug", Request.QueryString["c"].ToString());
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(dtable);
        con.Close();
        con.Dispose();
        return dtable;
    }

    private void BindDataList()
    {
        //try
        //{
        DataTable dt = GetData();
        pgsource.DataSource = dt.DefaultView;
        pgsource.AllowPaging = true;
        pgsource.PageSize = 12;
        pgsource.CurrentPageIndex = CurrentPage;
        ViewState["totpage"] = pgsource.PageCount;
        lblpage.Text = "Page " + (CurrentPage + 1) + " of " + pgsource.PageCount;
        lnkPrevious.Enabled = !pgsource.IsFirstPage;
        lnkNext.Enabled = !pgsource.IsLastPage;
        lnkFirst.Enabled = !pgsource.IsFirstPage;
        lnkLast.Enabled = !pgsource.IsLastPage;
        Repeater1.DataSource = pgsource;
        Repeater1.DataBind();
        doPaging();
        RepeaterPaging.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
        //}
        //catch (Exception ex)
        //{

        //}
    }

    private void doPaging()
    {
        //try
        //{
        DataTable dt = new DataTable();
        dt.Columns.Add("PageIndex");
        dt.Columns.Add("PageText");
        findex = CurrentPage - 5;
        if (CurrentPage > 5)
        {
            lindex = CurrentPage + 5;
        }
        else
        {
            lindex = 10;
        }
        if (lindex > Convert.ToInt32(ViewState["totpage"]))
        {
            lindex = Convert.ToInt32(ViewState["totpage"]);
            findex = lindex - 10;
        }
        if (findex < 0)
        {
            findex = 0;
        }
        for (int i = findex; i < lindex; i++)
        {
            DataRow dr = dt.NewRow();
            dr[0] = i;
            dr[1] = i + 1;
            dt.Rows.Add(dr);
        }
        RepeaterPaging.DataSource = dt;
        RepeaterPaging.DataBind();
        //}
        //catch (Exception ex)
        //{
        //}
    }

    private int CurrentPage
    {
        get
        {
            if (ViewState["CurrentPage"] == null)
            {
                return 0;
            }
            else
            {
                return ((int)ViewState["CurrentPage"]);
            }
        }
        set
        {
            ViewState["CurrentPage"] = value;
        }
    }
    protected void lnkFirst_Click(object sender, EventArgs e)
    {
        //try
        //{
        CurrentPage = 0;
        BindDataList();
        //}
        //catch (Exception ex)
        //{
        //}
    }
    protected void lnkLast_Click(object sender, EventArgs e)
    {
        //try
        //{
        CurrentPage = (Convert.ToInt32(ViewState["totpage"]) - 1);
        BindDataList();
        //}
        //catch (Exception ex)
        //{
        //}
    }
    protected void lnkPrevious_Click(object sender, EventArgs e)
    {
        //try
        //{
        CurrentPage -= 1;
        BindDataList();
        //}
        //catch (Exception ex)
        //{
        //}
    }
    protected void lnkNext_Click(object sender, EventArgs e)
    {
        //try
        //{
        CurrentPage += 1;
        BindDataList();
        //}
        //catch (Exception ex)
        //{
        //}
    }
    protected void RepeaterPaging_ItemCommand(object source, DataListCommandEventArgs e)
    {
        //try
        //{
        if (e.CommandName.Equals("newpage"))
        {
            CurrentPage = Convert.ToInt32(e.CommandArgument.ToString());
            BindDataList();
        }
        //}
        //catch (Exception ex)
        //{
        //}
    }
    protected void RepeaterPaging_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        //try
        //{
        LinkButton lnkPage = (LinkButton)e.Item.FindControl("Pagingbtn");
        if (lnkPage.CommandArgument.ToString() == CurrentPage.ToString())
        {
            lnkPage.Enabled = false;
            lnkPage.BackColor = System.Drawing.Color.FromName("#FFCC01");
        }
        //}
        //catch (Exception ex)
        //{
        //    Response.Write(ex.Message);
        //}
    }


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //try
            //{
            if (Request.QueryString["c"] != null)
            {
                BindDataList();
            }
            else
            {
                Response.Redirect("shop");
            }
            //}
            //catch (Exception ex)
            //{
            //}
        }
    }


    public void checkIfLogin()
    {
        //try
        //{
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
                while (reader.Read())
                {
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
                Response.Redirect("~/user/index");
            }
        }
        else
        {
            Response.Redirect("~/user/index");
        }
        //}
        //catch (Exception ex)
        //{
        //}
    }

    protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        //try
        //{
        Button add_cart_btn = (Button)e.Item.FindControl("add_cart_btn");
        Button remove_cart_btn = (Button)e.Item.FindControl("remove_cart_btn");


        HiddenField product_id = (HiddenField)e.Item.FindControl("product_id");
        HiddenField product_by = (HiddenField)e.Item.FindControl("product_by");
        HiddenField product_name = (HiddenField)e.Item.FindControl("product_name");
        HiddenField product_category = (HiddenField)e.Item.FindControl("product_category");
        HiddenField category_slug = (HiddenField)e.Item.FindControl("category_slug");
        HiddenField selling_price = (HiddenField)e.Item.FindControl("selling_price");
        HiddenField product_image = (HiddenField)e.Item.FindControl("product_image");

        if (e.CommandName == "add_cart_btn")
        {
            checkIfLogin();
            if (Request.Cookies["oid"] == null)
            {
                HttpCookie unCookie = new HttpCookie("oid");
                unCookie.Value = DateTime.Now.ToString("yyMMddhhmmssffffff");
                unCookie.Expires = DateTime.Now.AddYears(10);
                Response.Cookies.Add(unCookie);
            }
            //generate new order
            SqlConnection con2 = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["cn"]);
            SqlCommand cmd2 = new SqlCommand("Insert into transactions (transaction_id,product_id,product_by,purchased_by,product_category,category_slug,selling_price,product_image,status,query_added_date,order_id,product_name) values(@transaction_id,@product_id,@product_by,@purchased_by,@product_category,@category_slug,@selling_price,@product_image,@status,@query_added_date,@order_id,@product_name)", con2);
            cmd2.Parameters.AddWithValue("@transaction_id", indianTime.ToString("yyMMddhhmmssffffff"));
            cmd2.Parameters.AddWithValue("@product_id", product_id.Value);
            cmd2.Parameters.AddWithValue("@product_by", product_by.Value.ToString());
            cmd2.Parameters.AddWithValue("@purchased_by", Request.Cookies["unun"].Value.ToString());
            cmd2.Parameters.AddWithValue("@product_category", product_category.Value);
            cmd2.Parameters.AddWithValue("@category_slug", category_slug.Value);
            cmd2.Parameters.AddWithValue("@selling_price", selling_price.Value);
            cmd2.Parameters.AddWithValue("@product_image", product_image.Value);
            cmd2.Parameters.AddWithValue("@status", "Pending");
            cmd2.Parameters.AddWithValue("@query_added_date", indianTime.ToString("yyyyMMdd"));
            cmd2.Parameters.AddWithValue("@order_id", Request.Cookies["oid"].Value.ToString());
            cmd2.Parameters.AddWithValue("@product_name", product_name.Value);
            con2.Open();
            int count2 = cmd2.ExecuteNonQuery();
            con2.Close();
            con2.Dispose();
            //fillRepeater();
            remove_cart_btn.Visible = true;
            add_cart_btn.Visible = false;
        }

        else if (e.CommandName == "remove_cart_btn")
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
                        command.Parameters.AddWithValue("@sr", product_id.Value);
                        command.Parameters.AddWithValue("@status", "Pending");


                        int rowsAffected = command.ExecuteNonQuery();
                        if (rowsAffected > 0)
                        {
                            //fillRepeater();
                            remove_cart_btn.Visible = false;
                            add_cart_btn.Visible = true;
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
        else
        {
        }

        //}
        //catch (Exception ex)
        //{ }
    }

    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        Button add_cart_btn = (Button)e.Item.FindControl("add_cart_btn");
        Button remove_cart_btn = (Button)e.Item.FindControl("remove_cart_btn");
        HiddenField product_id_hf = (HiddenField)e.Item.FindControl("product_id_hf");

        //check if user is logged in
        try
        {
            if (Request.Cookies["unun"] != null)
            {
                SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["cn"]);
                con.Open();
                SqlCommand cmdd = new SqlCommand("select * from transactions where purchased_by=@purchased_by and product_id=@product_id and status=@status and query_added_date=@query_added_date", con);
                cmdd.Parameters.AddWithValue("@purchased_by", Request.Cookies["unun"].Value.ToString());
                cmdd.Parameters.AddWithValue("@product_id", product_id_hf.Value);
                cmdd.Parameters.AddWithValue("@status", "Pending");
                cmdd.Parameters.AddWithValue("@query_added_date", indianTime.ToString("yyyyMMdd"));

                SqlDataReader reader = cmdd.ExecuteReader();
                if (reader.HasRows)
                {
                    con.Close();
                    con.Dispose();
                    reader.Close();
                    add_cart_btn.Visible = false;
                    remove_cart_btn.Visible = true;
                }
                else
                {
                    con.Close();
                    con.Dispose();
                    reader.Close();
                    add_cart_btn.Text = "Add to Cart";
                    remove_cart_btn.Visible = false;
                }
            }
            else
            {
                //Response.Redirect("~/user/index");
            }
        }
        catch (Exception ex)
        {
        }

    }


}