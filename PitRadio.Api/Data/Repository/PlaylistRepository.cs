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
            Playlist = new();
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
