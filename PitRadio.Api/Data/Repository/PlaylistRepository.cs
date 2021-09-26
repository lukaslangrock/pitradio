using PitRadio.Api.Data.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace PitRadio.Api.Data.Repository
{
    public class PlaylistRepository : IPlaylistRepository
    {
        private List<Song> Playlist = new() { new Song("test1", "test1"), new Song("test2", "test2"), new Song("test3", "test3") };

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
