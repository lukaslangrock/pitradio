using System;
using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace PitRadio.Api.Data.Model
{
    public class Song
    {
        public Song(string uuid, string title, string file, List<bool> votes = null)
        {
            UUID = uuid;
            Title = title;
            File = file;
            Votes = votes ?? new();
        }

        public string UUID { get; }
        public string Title { get; }
        public string File { get; }
        [JsonIgnore]
        public List<bool> Votes { get; }
    }
}
