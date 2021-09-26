using System;
using System.Collections.Generic;

namespace PitRadio.Api.Data.Model
{
    public class Album
    {
        public Album(string uuid, string title, ushort year, string artist, string folder, IEnumerable<Song> songs)
        {
            UUID = uuid;
            Title = title;
            Year = year;
            Artist = artist;
            Folder = folder;
            Songs = songs;
        }

        public string UUID { get; }
        public string Title { get; }
        public ushort Year { get; }
        public string Artist { get; }
        public string Folder { get; }
        public IEnumerable<Song> Songs { get; }
    }
}
