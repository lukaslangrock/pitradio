using PitRadio.Api.Data.Model;
using System.Collections.Generic;

namespace PitRadio.Api.Data.Repository
{
    public interface IPlaylistRepository
    {
        IEnumerable<Song> GetSongsInQueue();
        void AddSongToQueue(Song song);
    }
}