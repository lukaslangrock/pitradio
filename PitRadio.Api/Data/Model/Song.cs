using System;

namespace PitRadio.Api.Data.Model
{
    public class Song
    {
        public Song(string title, string file)
        {
            UUID = Guid.NewGuid().ToString();
            Title = title;
            File = file;
        }

        public string UUID { get; }
        public string Title { get; }
        public string File { get; }
    }
}
