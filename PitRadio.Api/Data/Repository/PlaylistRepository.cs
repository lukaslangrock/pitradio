using System;
using PitRadio.Api.Data.Model;
using System.Collections.Generic;
using System.Linq;

namespace PitRadio.Api.Data.Repository
{
    public class PlaylistRepository : IPlaylistRepository
    {
        private readonly List<Song> Playlist = new() { new Song(Guid.NewGuid().ToString(), "test1", "test1"), new Song(Guid.NewGuid().ToString(), "test2", "test2"), new Song(Guid.NewGuid().ToString(), "test3", "test3") };

        public event EventHandler SkipSong;

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

        public void RemoveFirstSong()
        {
            var elem = Playlist.FirstOrDefault();
            if (elem != default(Song) && elem != null)
                Playlist.RemoveAt(0);
        }

        public void RemoveSongFromQueueByUuid(string uuid)
        {
            Playlist.Remove(Playlist.First(song => song.UUID == uuid));
        }

        public void AddVoteToFirstSongOccurrence(string uuid, bool vote)
        {
            Playlist.First(song => song.UUID == uuid).Votes.Add(vote);
        }

        public Song GetFirstSongInQueueByUuid(string uuid)
        {
            throw new NotImplementedException();
        }

        public bool SkipCurrentSongIfNecessary()
        {
            throw new NotImplementedException();
        }

        public void RemoveSong(string uuid)
        {
            throw new NotImplementedException();
        }
    }
}
