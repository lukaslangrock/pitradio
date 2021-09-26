using System;

namespace PitRadio.Api.Data.Model
{
    public class Song
    {
        public Song(string uuid, string title, string file)
        {
            UUID = uuid;
            Title = title;
            File = file;
        }

        public string UUID { get; }
        public string Title { get; }
        public string File { get; }
    }
}
