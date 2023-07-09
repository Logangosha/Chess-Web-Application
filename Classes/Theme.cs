using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Chess_App.Classes
{
    public class Theme
    {
        public string PrimaryColor { get; set; }
        public string BackgroundColor { get; set; }
        public string StatusColor { get; set; }

        public Theme(string primaryColor, string backgroundColor, string statusColor)
        {
            PrimaryColor = primaryColor;
            BackgroundColor = backgroundColor;
            StatusColor = statusColor;
        }
    }
}