using System;
using System.Collections.Generic;

namespace PitRadio.Api.Data.Model
{
    public class Album
    {
        public Album(string title, ushort year, string artist, IEnumerable<Song> songs)
        {
            UUID = Guid.NewGuid().ToString();
            Title = title;
            Year = year;
            Artist = artist;
            Songs = songs;
        }

        public string UUID { get; }
        public string Title { get; }
        public ushort Year { get; }
        public string Artist { get; }
        public IEnumerable<Song> Songs { get; }
    }
}
