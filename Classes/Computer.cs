using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Chess_App.Classes
{
    public class Computer
    {
        public int Difficulty { get; set; }
        public Computer(int difficulty)
        {
            Difficulty = difficulty;
        }
    }
}