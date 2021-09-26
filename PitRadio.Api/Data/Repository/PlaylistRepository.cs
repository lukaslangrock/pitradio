using System;
using PitRadio.Api.Data.Model;
using System.Collections.Generic;

namespace PitRadio.Api.Data.Repository
{
    public class PlaylistRepository : IPlaylistRepository
    {
        private List<Song> Playlist = new() { new Song(Guid.NewGuid().ToString(), "test1", "test1"), new Song(Guid.NewGuid().ToString(), "test2", "test2"), new Song(Guid.NewGuid().ToString(), "test3", "test3") };

        public PlaylistRepository()
        { }

        public IEnumerable<Song> GetSongsInQueue()
        {
            return Playlist;
        }

        public void AddSongToQueue(Song song)
        {
            if (!(string.IsNullOrWhiteSpace(song.Title) || string.IsNullOrWhiteSpace(song.File)))
                Playlist.Add(song);
        }
    }
}
