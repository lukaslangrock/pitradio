using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace PitRadio.Api.Data.Model
{
    public class Song
    {
        public Song(string title, string file)
        {
            Title = title;
            File = file;
            Votes = new List<bool>();
        }

        public string Title { get; }
        public string File { get; }
        [JsonIgnore]
        public List<bool> Votes { get; set; }
    }
}
