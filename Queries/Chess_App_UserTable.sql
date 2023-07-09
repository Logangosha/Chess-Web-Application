CREATE TABLE [User] (
ID INT IDENTITY(1,1) PRIMARY KEY,
Username VARCHAR(50) NOT NULL,
Email VARCHAR(100) UNIQUE,
PasswordHash VARBINARY(64) NOT NULL,
Salt VARBINARY(16) NOT NULL,
PrimaryColor CHAR(7) NOT NULL DEFAULT '#00ff15',
BackgroundColor CHAR(7) NOT NULL DEFAULT '#000000',
StatusColor CHAR(7) NOT NULL DEFAULT '#066100',
)

ALTER PROCEDURE dbo.InsertNewUser
    @Username VARCHAR(50),
    @Email VARCHAR(100),
    @PasswordHash VARBINARY(64),
    @Salt VARBINARY(16)
AS
BEGIN
    INSERT INTO [User] (Username, Email, PasswordHash, Salt)
    VALUES (@Username, @Email, @PasswordHash, @Salt);
END;