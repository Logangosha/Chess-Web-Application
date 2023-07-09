using System;
using System.Security.Cryptography;
using System.Linq;
using System.Text;
using Chess_App;

public static class PasswordHashHelper
{
    // Generate a random salt
    public static byte[] GenerateSalt()
    {
        byte[] salt = new byte[16]; // Generate a 16-byte salt (adjust the size as needed)
        using (var rng = new RNGCryptoServiceProvider())
        {
            rng.GetBytes(salt);
        }
        return salt;
    }
    // Take a password and salt and return a salted hash of the password
    public static byte[] CreatePasswordHash(string password, byte[] salt)
    {
        using (var pbkdf2 = new Rfc2898DeriveBytes(password, salt, 10000)) // Adjust the iteration count as needed
        {
            return pbkdf2.GetBytes(32); // Generate a 32-byte hash (adjust the size as needed)
        }
    }
    // Check if a password and a salt matches a hash
    public static bool VerifyPassword(string password, byte[] salt, byte[] hash)
    {
        byte[] computedHash = CreatePasswordHash(password, salt);
        return computedHash.SequenceEqual(hash);
    }
}
