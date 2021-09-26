using System;
using PitRadio.Api.Data.Model;
using System.Collections.Generic;

namespace PitRadio.Api.Data.Repository
{
    public class PlaylistRepository : IPlaylistRepository
    {
        private List<Song> Playlist;

        public PlaylistRepository()
        {
            Playlist = new()
            {
                new Song("test1", "test1", Guid.NewGuid().ToString()),
                new Song("test2", "test2", Guid.NewGuid().ToString()),
                new Song("test3", "test3", Guid.NewGuid().ToString())
            };
        }

        public IEnumerable<Song> GetSongsInQueue()
        {
            return Playlist;
        }

        public void AddSongToQueue(Song song)
        {
            Playlist.Add(song);
        }
    }
}
