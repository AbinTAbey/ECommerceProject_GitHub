
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
namespace ECommerceproject
{
  
    public class DBConnection
    {
        SqlConnection con;
        SqlCommand cmd;

        public DBConnection()
        {
            con = new SqlConnection
                (@"server=DESKTOP-N272NOH\SQLEXPRESS;database=ECommerceProject;integrated security=true");
        }

        public int fn_nonquery(string query)
        {
            cmd = new SqlCommand(query, con);
            con.Open();
            int i = cmd.ExecuteNonQuery();
            con.Close();
            return i;
        }

        public string fn_scalar(string query)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }

            cmd = new SqlCommand(query, con);
            con.Open();

            string s = cmd.ExecuteScalar().ToString();

            con.Close();
            return s;
        }

        public SqlDataReader fn_reader(string sqlquery)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }

            cmd = new SqlCommand(sqlquery, con);
            con.Open();

            SqlDataReader dr = cmd.ExecuteReader();

            return dr;
        }

        public DataSet fn_adapter(string sqlquery)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }

            SqlDataAdapter da = new SqlDataAdapter(sqlquery, con);
            DataSet ds = new DataSet();

            da.Fill(ds);

            return ds;
        }

        public DataTable fn_adapterTable(string sqlquery)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }

            SqlDataAdapter da = new SqlDataAdapter(sqlquery, con);
            DataTable dt = new DataTable();

            da.Fill(dt);

            return dt;
        }
        public int fn_nonquery(string query, SqlParameter[] parameters)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
            cmd = new SqlCommand(query, con);
            cmd.Parameters.AddRange(parameters);
            con.Open();
            int i = cmd.ExecuteNonQuery();
            con.Close();
            return i;
        }
    }
}