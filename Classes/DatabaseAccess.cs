using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Diagnostics;
using System.IO;
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
                                int ID = (int)reader["ID"];
                                string email = reader["Email"].ToString();
                                byte[] hashedPassword = (byte[])reader["PasswordHash"];
                                byte[] salt = (byte[])reader["Salt"];
                                Theme theme = new Theme(reader["PrimaryColor"].ToString(), reader["BackgroundColor"].ToString(), reader["StatusColor"].ToString());
                                byte[] profilePicture = (byte[])reader["ProfilePicture"];
                                bool OnlineStatus = (bool)reader["OnlineStatus"];

                                if (PasswordHashHelper.VerifyPassword(password, salt, hashedPassword))
                                {
                                    PlayerAccount playerAccount = new PlayerAccount(ID, username, email, theme, profilePicture, OnlineStatus);
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
        public static void SaveNewAccountInfo(string username, string newUsername, string newEmail, byte[] imageBytes)
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
                        command.Parameters.AddWithValue("@username", username);
                        command.Parameters.AddWithValue("@newUsername", newUsername);
                        command.Parameters.AddWithValue("@newEmail", newEmail);
                        command.Parameters.AddWithValue("@newProfilePicture", imageBytes);
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

        // Check if password matches the user's current password
        public static bool CheckCurrentPassword(string username, string password)
        {
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ChessAppDbConnectionString"].ConnectionString))
            {
                using (SqlCommand command = new SqlCommand("dbo.CheckCurrentPassword", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    try
                    {
                        connection.Open();
                        System.Diagnostics.Debug.WriteLine("Connection Opened");
                        command.Parameters.Add("@Username", SqlDbType.VarChar, 50).Value = username;
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.HasRows)
                            {
                                System.Diagnostics.Debug.WriteLine("username match");
                                while (reader.Read())
                                {
                                    byte[] hashedPassword = (byte[])reader["PasswordHash"];
                                    byte[] salt = (byte[])reader["Salt"];
                                    if (PasswordHashHelper.VerifyPassword(password, salt, hashedPassword))
                                    {
                                        return true;
                                    }
                                    else
                                    {
                                        System.Diagnostics.Debug.WriteLine("password does not match");
                                        return false;
                                    }
                                }
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine(ex.Message);
                    }
                }
            }
            return false;
        }

        // Save the user's new password
        public static void SaveNewPassword(string username, string newPassword)
        {
            byte[] salt = PasswordHashHelper.GenerateSalt();
            byte[] hashedPassword = PasswordHashHelper.CreatePasswordHash(newPassword, salt);

            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ChessAppDbConnectionString"].ConnectionString))
            {
                using (SqlCommand command = new SqlCommand("dbo.SaveNewPassword", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    try
                    {
                        connection.Open();
                        System.Diagnostics.Debug.WriteLine("Connection Opened");
                        command.Parameters.AddWithValue("@Username", username);
                        command.Parameters.AddWithValue("@PasswordHash", hashedPassword);
                        command.Parameters.AddWithValue("@Salt", salt);

                        command.ExecuteNonQuery();
                        System.Diagnostics.Debug.WriteLine("SaveNewPassword Executed");
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

        // Delete User
        public static void DeleteUser(string username)
        {
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ChessAppDbConnectionString"].ConnectionString))
            {
                using (SqlCommand command = new SqlCommand("dbo.DeleteUser", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    try
                    {
                        connection.Open();
                        System.Diagnostics.Debug.WriteLine("Connection Opened");
                        command.Parameters.Add("@Username", SqlDbType.VarChar, 50).Value = username;
                        command.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine(ex.Message);
                    }
                }
            }
        }

        public static byte[] GetImageBytes(HttpPostedFile uploadedFile)
        {
            byte[] imageBytes;
            using (var memoryStream = new MemoryStream())
            {
                uploadedFile.InputStream.CopyTo(memoryStream);
                imageBytes = memoryStream.ToArray();
            }
            Debug.WriteLine(imageBytes);
            return imageBytes;
        }
        //byte[] bytes = DatabaseAccess.defaultImageBytes("C:\\Users\\Logan\\OneDrive\\Documents\\GitHub\\Chess_App\\Chess_App\\Images\\DefaultProfilePicture.png");
        //string hexString = BitConverter.ToString(bytes).Replace("-", string.Empty);
        //System.Diagnostics.Debug.WriteLine(hexString);


        // Set users online status to status parameter
        public static void SetOnlineStatus(string username, string status)
        {
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ChessAppDbConnectionString"].ConnectionString))
            {
                using (SqlCommand command = new SqlCommand("dbo.SetOnlineStatus", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    try
                    {
                        connection.Open();
                        System.Diagnostics.Debug.WriteLine("Connection Opened");
                        command.Parameters.AddWithValue("@Username", username);
                        command.Parameters.AddWithValue("@Status", status);
                        command.ExecuteNonQuery();
                        System.Diagnostics.Debug.WriteLine("SetOnlineStatus Executed");
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

        // Get Users that contin the search string
        public static List<PlayerAccount> SearchUsers(string searchString)
        {
            List<PlayerAccount> users = new List<PlayerAccount>();
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ChessAppDbConnectionString"].ConnectionString))
            {
                using (SqlCommand command = new SqlCommand("dbo.SearchUsers", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    try
                    {
                        connection.Open();
                        System.Diagnostics.Debug.WriteLine("Connection Opened");
                        command.Parameters.AddWithValue("@SearchString", searchString);
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.HasRows)
                            {
                                System.Diagnostics.Debug.WriteLine("reader has rows");
                                while (reader.Read())
                                {
                                    // Retrieve the data from the reader and populate the PlayerAccount objects

                                    int id = (int)reader["ID"];
                                    string userName = reader["UserName"].ToString();
                                    Debug.WriteLine(userName);
                                    Theme theme = new Theme(
                                        reader["PrimaryColor"].ToString(),
                                        reader["BackgroundColor"].ToString(),
                                        reader["StatusColor"].ToString()
                                    );
                                    byte[] profilePicture = (byte[])reader["ProfilePicture"];
                                    bool onlineStatus = (bool)reader["OnlineStatus"];

                                    PlayerAccount user = new PlayerAccount(id, userName, theme, profilePicture, onlineStatus);
                                    users.Add(user);
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
            return users;
        }

        // get user id
        public static int GetUserId(string username)
        {
            int id = 0;
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ChessAppDbConnectionString"].ConnectionString))
            {
                using (SqlCommand command = new SqlCommand("dbo.GetUserId", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    try
                    {
                        connection.Open();
                        System.Diagnostics.Debug.WriteLine("Connection Opened");
                        command.Parameters.AddWithValue("@Username", username);
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.HasRows)
                            {
                                System.Diagnostics.Debug.WriteLine("reader has rows");
                                while (reader.Read())
                                {
                                    id = (int)reader["Id"];
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
            return id;
        }

        // check if user is a friend
        public static int IsFriend(int currentUserId, int potentialFriendId)
        {
            int friendshipStatus = 0; // Default value for no friendship

            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ChessAppDbConnectionString"].ConnectionString))
            {
                using (SqlCommand command = new SqlCommand("dbo.IsFriend", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    try
                    {
                        connection.Open();
                        System.Diagnostics.Debug.WriteLine("Connection Opened");
                        command.Parameters.AddWithValue("@CurrentUserId", currentUserId);
                        command.Parameters.AddWithValue("@PotentialFriendId", potentialFriendId);
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.HasRows)
                            {
                                System.Diagnostics.Debug.WriteLine("reader has rows");
                                while (reader.Read())
                                {
                                    int status = Convert.ToInt32(reader["Status"]);
                                    friendshipStatus = status;
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

            return friendshipStatus;
        }
    }
}
