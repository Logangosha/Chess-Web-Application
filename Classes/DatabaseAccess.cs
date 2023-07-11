using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;

namespace Chess_App.Classes
{
    public static class DatabaseAccess
    {
        public static bool IsUsernameTaken(string username)
        {
            bool isTaken = false;

            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ChessAppDbConnectionString"].ConnectionString))
            {
                using (SqlCommand command = new SqlCommand("CheckUsernameExistence", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.AddWithValue("@Username", username);
                    command.Parameters.Add("@Exists", SqlDbType.Bit).Direction = ParameterDirection.Output;

                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();

                        isTaken = (bool)command.Parameters["@Exists"].Value;
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine("An exception occurred: " + ex.ToString());
                    }
                    finally
                    {
                        if (connection.State == ConnectionState.Open)
                        {
                            connection.Close();
                        }
                    }
                }
            }

            return isTaken;
        }

        // check if email exists
        public static bool IsEmailTaken(string email)
        {
            bool isTaken = false;

            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ChessAppDbConnectionString"].ConnectionString))
            {
                using (SqlCommand command = new SqlCommand("CheckEmailExistence", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.AddWithValue("@Email", email);
                    command.Parameters.Add("@Exists", SqlDbType.Bit).Direction = ParameterDirection.Output;

                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();

                        isTaken = (bool)command.Parameters["@Exists"].Value;
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine("An exception occurred: " + ex.ToString());
                    }
                    finally
                    {
                        if (connection.State == ConnectionState.Open)
                        {
                            connection.Close();
                        }
                    }
                }
            }

            return isTaken;
        }

        // Insert new user into database 
        public static void InsertNewUser(PlayerAccount newUserAccount)
        {

            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ChessAppDbConnectionString"].ConnectionString))
            {
                using (SqlCommand command = new SqlCommand("dbo.InsertNewUser", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    try
                    {
                        connection.Open();
                        System.Diagnostics.Debug.WriteLine("Connection Opened");

                        // Set the parameter values
                        System.Diagnostics.Debug.WriteLine(newUserAccount.Username);
                        command.Parameters.AddWithValue("@Username", newUserAccount.Username);

                        System.Diagnostics.Debug.WriteLine(newUserAccount.Email);
                        command.Parameters.AddWithValue("@Email", newUserAccount.Email);

                        //System.Diagnostics.Debug.WriteLine(newUserAccount.PasswordData[0]);
                        command.Parameters.AddWithValue("@PasswordHash", newUserAccount.PasswordData[0]);
                        command.Parameters.AddWithValue("@Salt", newUserAccount.PasswordData[1]);

                        command.ExecuteNonQuery();
                        System.Diagnostics.Debug.WriteLine("InsertNewUser Executed");
                    }
                    catch (Exception ex)
                    {
                        // Handle the exception
                        System.Diagnostics.Debug.WriteLine(ex.Message);
                    }
                    finally
                    {
                        // Close the connection in the finally block to ensure it gets closed regardless of whether an exception occurred or not
                        if (connection.State == ConnectionState.Open)
                        {
                            connection.Close();
                            System.Diagnostics.Debug.WriteLine("Connection Closed");
                        }
                    }
                }
            }
        }

        // Check if the username and password combination is valid
        public static PlayerAccount GetUserAccount(string username, string password)
        {
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ChessAppDbConnectionString"].ConnectionString))
            {
                using (SqlCommand command = new SqlCommand("dbo.GetUserAccount", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    try
                    {
                        connection.Open();
                        System.Diagnostics.Debug.WriteLine("Connection Opened");
                        command.Parameters.AddWithValue("@Username", username);

                        SqlDataReader reader = command.ExecuteReader();
                        if (reader.HasRows)
                        {
                            System.Diagnostics.Debug.WriteLine("username match");
                            // If a record is found, read the data and create a PlayerAccount object
                            while (reader.Read())
                            {
                                string email = reader["Email"].ToString();
                                byte[] hashedPassword = (byte[])reader["PasswordHash"];
                                byte[] salt = (byte[])reader["Salt"];
                                Theme theme = new Theme(reader["PrimaryColor"].ToString(), reader["BackgroundColor"].ToString(), reader["StatusColor"].ToString());

                                if (PasswordHashHelper.VerifyPassword(password, salt, hashedPassword))
                                {
                                    PlayerAccount playerAccount = new PlayerAccount(username, email, theme);
                                    return playerAccount;
                                }
                                else
                                {
                                    System.Diagnostics.Debug.WriteLine("password does not match");
                                    return null;
                                }
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine(ex.Message);
                    }
                    finally
                    {
                        if (connection.State == ConnectionState.Open)
                        {
                            connection.Close();
                            System.Diagnostics.Debug.WriteLine("Connection Closed");
                        }
                    }
                }
            }

            return null;
        }

        // Save the user's theme settings
        public static void SaveThemeSettings(string username, Theme theme)
        {
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ChessAppDbConnectionString"].ConnectionString))
            {
                using (SqlCommand command = new SqlCommand("dbo.SaveThemeSettings", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    try
                    {
                        connection.Open();
                        System.Diagnostics.Debug.WriteLine("Connection Opened");
                        System.Diagnostics.Debug.WriteLine(username);
                        System.Diagnostics.Debug.WriteLine(theme.PrimaryColor);
                        System.Diagnostics.Debug.WriteLine(theme.BackgroundColor);
                        System.Diagnostics.Debug.WriteLine(theme.StatusColor);
                        command.Parameters.AddWithValue("@Username", username);
                        command.Parameters.AddWithValue("@PrimaryColor", theme.PrimaryColor);
                        command.Parameters.AddWithValue("@BackgroundColor", theme.BackgroundColor);
                        command.Parameters.AddWithValue("@StatusColor", theme.StatusColor);
                        command.ExecuteNonQuery();
                        System.Diagnostics.Debug.WriteLine("SaveThemeSettings Executed");
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine(ex.Message);
                    }
                    finally
                    {
                        if (connection.State == ConnectionState.Open)
                        {
                            connection.Close();
                            System.Diagnostics.Debug.WriteLine("Connection Closed");
                        }
                    }
                }
            }
        }

        // Save the user's new Username / Email
        public static void SaveNewAccountInfo(string username, string newUsername, string newEmail)
        {
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ChessAppDbConnectionString"].ConnectionString))
            {
                using (SqlCommand command = new SqlCommand("dbo.SaveNewAccountInfo", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    try
                    {
                        connection.Open();
                        System.Diagnostics.Debug.WriteLine("Connection Opened");
                        System.Diagnostics.Debug.WriteLine(username);
                        System.Diagnostics.Debug.WriteLine(newUsername);
                        System.Diagnostics.Debug.WriteLine(newEmail);
                        command.Parameters.AddWithValue("@Username", username);
                        command.Parameters.AddWithValue("@NewUsername", newUsername);
                        command.Parameters.AddWithValue("@NewEmail", newEmail);
                        command.ExecuteNonQuery();
                        System.Diagnostics.Debug.WriteLine("SaveAccountSettings Executed");
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine(ex.Message);
                    }
                    finally
                    {
                        if (connection.State == ConnectionState.Open)
                        {
                            connection.Close();
                            System.Diagnostics.Debug.WriteLine("Connection Closed");
                        }
                    }
                }
            }
        }
    }
}
