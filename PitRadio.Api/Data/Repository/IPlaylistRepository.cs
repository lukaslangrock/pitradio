using PitRadio.Api.Data.Model;
using System;
using System.Collections.Generic;

namespace PitRadio.Api.Data.Repository
{
    public interface IPlaylistRepository
    {
        public event EventHandler SkipSong;

        IEnumerable<Song> GetSongsInQueue();
        void AddSongToQueue(Song song);
        void AddVoteToFirstSongOccurrence(string uuid, bool vote);
        Song GetFirstSongInQueueByUuid(string uuid);
        bool SkipCurrentSongIfNecessary();
        void RemoveSong(string uuid);
    }
}