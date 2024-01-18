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

        // Store recovery code in database
        public static void StoreRecoveryCode(string email, string code)
        {
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ChessAppDbConnectionString"].ConnectionString))
            {
                using (SqlCommand command = new SqlCommand("InsertOrUpdateRecoveryCode", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@Email", email);
                    command.Parameters.AddWithValue("@Code", code);
                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
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
        }

        // ValidateCode 
        public static bool VerifyRecoveryCode(string email, string code)
        {
            bool isValid = false;
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ChessAppDbConnectionString"].ConnectionString))
            {
                using (SqlCommand command = new SqlCommand("VerifyRecoveryCode", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@Email", email);
                    command.Parameters.AddWithValue("@Code", code);
                    command.Parameters.Add("@IsValid", SqlDbType.Bit).Direction = ParameterDirection.Output;
                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        isValid = (bool)command.Parameters["@IsValid"].Value;
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
            return isValid;
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

                        // Set the parameter values
                        command.Parameters.AddWithValue("@Username", newUserAccount.Username);

                        command.Parameters.AddWithValue("@Email", newUserAccount.Email);

                        command.Parameters.AddWithValue("@PasswordHash", newUserAccount.PasswordData[0]);
                        command.Parameters.AddWithValue("@Salt", newUserAccount.PasswordData[1]);

                        command.ExecuteNonQuery();
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
                        command.Parameters.AddWithValue("@Username", username);

                        SqlDataReader reader = command.ExecuteReader();
                        if (reader.HasRows)
                        {
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
                        command.Parameters.AddWithValue("@Username", username);
                        command.Parameters.AddWithValue("@PrimaryColor", theme.PrimaryColor);
                        command.Parameters.AddWithValue("@BackgroundColor", theme.BackgroundColor);
                        command.Parameters.AddWithValue("@StatusColor", theme.StatusColor);
                        command.ExecuteNonQuery();
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
                        command.Parameters.AddWithValue("@username", username);
                        command.Parameters.AddWithValue("@newUsername", newUsername);
                        command.Parameters.AddWithValue("@newEmail", newEmail);
                        command.Parameters.AddWithValue("@newProfilePicture", imageBytes);
                        command.ExecuteNonQuery();
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
                        command.Parameters.Add("@Username", SqlDbType.VarChar, 50).Value = username;
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.HasRows)
                            {
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
                        command.Parameters.AddWithValue("@Username", username);
                        command.Parameters.AddWithValue("@PasswordHash", hashedPassword);
                        command.Parameters.AddWithValue("@Salt", salt);

                        command.ExecuteNonQuery();
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
                        }
                    }
                }
            }
        }

        // GetUsernameFromEmail
        public static string GetUsernameFromEmail(string email)
        {
            string username = null;
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ChessAppDbConnectionString"].ConnectionString))
            {
                using (SqlCommand command = new SqlCommand("GetUsernameFromEmail", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    try
                    {
                        connection.Open();
                        command.Parameters.Add("@Email", SqlDbType.VarChar, 50).Value = email;
                        SqlParameter usernameParameter = new SqlParameter("@Username", SqlDbType.NVarChar, 50);
                        usernameParameter.Direction = ParameterDirection.Output;
                        command.Parameters.Add(usernameParameter);

                        command.ExecuteNonQuery();

                        // Retrieve the result from the output parameter
                        username = usernameParameter.Value != DBNull.Value ? (string)usernameParameter.Value : null;
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine(ex.Message);
                    }
                }
            }
            return username;
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
            return imageBytes;
        }


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
                        command.Parameters.AddWithValue("@Username", username);
                        command.Parameters.AddWithValue("@Status", status);
                        command.ExecuteNonQuery();

                        Debug.WriteLine("SetOnlineStatus: " + username + " " + status);
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
                        command.Parameters.AddWithValue("@SearchString", searchString);
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.HasRows)
                            {
                                while (reader.Read())
                                {
                                    // Retrieve the data from the reader and populate the PlayerAccount objects

                                    int id = (int)reader["ID"];
                                    string userName = reader["UserName"].ToString();
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
                        command.Parameters.AddWithValue("@Username", username);
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.HasRows)
                            {
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
                        command.Parameters.AddWithValue("@CurrentUserId", currentUserId);
                        command.Parameters.AddWithValue("@PotentialFriendId", potentialFriendId);

                        // Use ExecuteScalar to get the single value returned by the stored procedure
                        object result = command.ExecuteScalar();

                        if (result != null && result != DBNull.Value)
                        {
                            friendshipStatus = Convert.ToInt32(result);
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
                        }
                    }
                }
            }

            return friendshipStatus;
        }

        // send friend request
        public static void SendFriendRequest(int currentUserId, int potentialFriendId)
        {
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ChessAppDbConnectionString"].ConnectionString))
            {
                using (SqlCommand command = new SqlCommand("dbo.SendFriendRequest", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    try
                    {
                        connection.Open();
                        command.Parameters.AddWithValue("@SenderUserId", currentUserId);
                        command.Parameters.AddWithValue("@ReceiverFriendId", potentialFriendId);
                        command.ExecuteNonQuery();
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
                        }
                    }
                }
            }
        }

        // handle friend request
        public static void HandleFriendRequest(int currentUserId, int potentialFriendId, int isAccepted, int messageId)
        {
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ChessAppDbConnectionString"].ConnectionString))
            {
                using (SqlCommand command = new SqlCommand("dbo.HandleFriendRequest", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    try
                    {
                        connection.Open();
                        command.Parameters.AddWithValue("@CurrentUserId", currentUserId);
                        command.Parameters.AddWithValue("@PotentialFriendId", potentialFriendId);
                        command.Parameters.AddWithValue("@Accept", isAccepted);
                        command.Parameters.AddWithValue("@MessageId", messageId);
                        command.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine("Sql Error "+ex.Message);
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
        }

        // remove friend
        public static void RemoveFriend(int currentUserId, int potentialFriendId)
        {
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ChessAppDbConnectionString"].ConnectionString))
            {
                using (SqlCommand command = new SqlCommand("dbo.RemoveFriend", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    try
                    {
                        connection.Open();
                        command.Parameters.AddWithValue("@CurrentUserId", currentUserId);
                        command.Parameters.AddWithValue("@PotentialFriendId", potentialFriendId);
                        command.ExecuteNonQuery();
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
                        }
                    }
                }
            }
        }

        // get friends
        public static List<PlayerAccount> GetFriends(int currentUserId)
        {
            List<PlayerAccount> friends = new List<PlayerAccount>();
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ChessAppDbConnectionString"].ConnectionString))
            {
                using (SqlCommand command = new SqlCommand("dbo.GetFriends", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@CurrentUserId", currentUserId);
                    try
                    {
                        connection.Open();

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                int friendshipId = (int)reader["ID"];
                                string userName = (string)reader["UserName"];
                                byte[] profilePicture = (byte[])reader["ProfilePicture"];
                                bool onlineStatus = (bool)reader["OnlineStatus"];

                                PlayerAccount friend = new PlayerAccount(friendshipId, userName, profilePicture, onlineStatus);
                                friends.Add(friend);
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
                        }
                    }
                }
            }
            return friends;
        }

        // Send Message
        public static void SendMessage(string message, int senderId, int receiverId, int messageType, bool? isAccepted = null)
        {
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ChessAppDbConnectionString"].ConnectionString))
            {
                using (SqlCommand command = new SqlCommand("dbo.SendMessage", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    try
                    {
                        connection.Open();
                        command.Parameters.AddWithValue("@SenderId", senderId);
                        command.Parameters.AddWithValue("@ReceiverId", receiverId);
                        command.Parameters.AddWithValue("@Message", message);
                        command.Parameters.AddWithValue("@MessageType", messageType);

                        // Handle specific cases based on MessageType
                        switch (messageType)
                        {
                            case 0: // Simple text message
                                    // No additional action needed
                                break;

                            case 1: // Friend request
                                command.Parameters.AddWithValue("@IsAccepted", isAccepted);
                                break;

                            case 2: // Challenge to a match
                                command.Parameters.AddWithValue("@IsAccepted", isAccepted);
                                break;

                            default:
                                throw new ArgumentException("Invalid MessageType. Supported values: 0, 1, 2");
                        }

                        command.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine("Error SendMessage: " + ex.Message);
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
        }

        // RetrieveAccountMessages
        public static List<PlayerAccount> RetrieveLastAccountMessagesWithUserInfo(int userId)
        {
            List<PlayerAccount> accountMessages = new List<PlayerAccount>();
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ChessAppDbConnectionString"].ConnectionString))
            {
                using (SqlCommand command = new SqlCommand("dbo.RetrieveLastAccountMessagesWithUserInfo", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    try
                    {
                        connection.Open();
                        command.Parameters.AddWithValue("@UserId", userId);
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                int ConversationPartnerId = (int)reader["ConversationPartnerId"];
                                string Username = (string)reader["Username"];
                                bool OnlineStatus = (bool)reader["OnlineStatus"];
                                byte[] ProfilePicture = (byte[])reader["ProfilePicture"];
                                bool IsNewMessage = (bool)reader["IsNewMessage"];
                                int MessageType = int.Parse((string)reader["MessageType"]);
                                string Content = (string)reader["Content"];
                                DateTime Timestamp = (DateTime)reader["Timestamp"];
                                //Debug.WriteLine("PlayerAccount( ConversationPartnerId: " + ConversationPartnerId
                                //    + ", Username: " + Username
                                //    + ", OnlineStatus: " + OnlineStatus
                                //    + ", ProfilePicture: " + ProfilePicture
                                //    + ", IsNewMessage: " + IsNewMessage
                                //    + ", MessageType: " + MessageType
                                //    + ", Content: " + Content
                                //    + ", Timestamp: " + Timestamp
                                //    + " )"); 
                                PlayerAccount message = new PlayerAccount(ConversationPartnerId, Username, OnlineStatus, ProfilePicture, IsNewMessage, MessageType, Content, Timestamp);
                                accountMessages.Add(message);
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        Debug.WriteLine("Error RetrieveLastAccountMessagesWithUserInfo: " + ex);
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
            return accountMessages;
        }
        public static List<Message> GetMessagesBetweenUsers(int currentUserId, int targetRecipientId)
        {
            List<Message> messages = new List<Message>();
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ChessAppDbConnectionString"].ConnectionString))
            {
                using (SqlCommand command = new SqlCommand("dbo.GetMessagesBetweenUsers", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    try
                    {
                        connection.Open();
                        command.Parameters.AddWithValue("@CurrentUserId", currentUserId);
                        command.Parameters.AddWithValue("@RecipientId", targetRecipientId); // Use targetRecipientId as the parameter name
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                int messageId = (int)reader["MessageId"];
                                //Debug.WriteLine("MessageId: " + messageId);
                                int senderId = (int)reader["SenderId"];
                                //Debug.WriteLine("SenderId: " + senderId);
                                int recipientId = (int)reader["RecipientId"];
                                //Debug.WriteLine("RecipientId: " + recipientId);
                                string content = (string)reader["Content"];
                                //Debug.WriteLine("Content: " + content);
                                DateTime timestamp = (DateTime)reader["Timestamp"];
                                //Debug.WriteLine("Timestamp: " + timestamp);
                                int messageType = int.Parse((string)reader["MessageType"]);
                                //Debug.WriteLine("MessageType: " + messageType);
                                bool? isAccepted = Convert.IsDBNull(reader["IsAccepted"]) ? null : (bool?)reader["IsAccepted"];
                                //Debug.WriteLine("IsAccepted: " + isAccepted);
                                bool isNewMessage = (bool)reader["IsNewMessage"];
                                //Debug.WriteLine("IsNewMessage: " + isNewMessage);

                                Message message = new Message(messageId, senderId, recipientId, content, timestamp, messageType, isAccepted, isNewMessage);
                                messages.Add(message);
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        Debug.WriteLine("Error in GetMessagesBetweenUsers: " + ex.Message);
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
            return messages;
        }
    }
}


