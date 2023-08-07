using System;

namespace Chess_App
{
    public class Message
    {
        public int MessageId { get; set; }
        public int SenderId { get; set; }
        public int RecipientId { get; set; }
        public string Content { get; set; }
        public DateTime Timestamp { get; set; }
        public string FormattedTimestamp { get; set; }
        public int MessageType { get; set; }
        public bool? IsAccepted { get; set; }
        public bool IsNewMessage { get; set; }

        public Message(int messageId, int senderId, int recipientId, string content, DateTime timestamp, int messageType, bool? isAccepted, bool isNewMessage)
        {
            MessageId = messageId;
            SenderId = senderId;
            RecipientId = recipientId;
            Content = content;
            Timestamp = timestamp;
            MessageType = messageType;
            IsAccepted = isAccepted;
            IsNewMessage = isNewMessage;
            // Format the Timestamp property to a string with the format "h:mm tt"
            FormattedTimestamp = Timestamp.ToString("h:mm tt");
        }
    }
}