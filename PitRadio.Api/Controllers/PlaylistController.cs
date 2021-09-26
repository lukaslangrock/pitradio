﻿using Microsoft.AspNetCore.Mvc;
using PitRadio.Api.Data.Model;
using PitRadio.Api.Data.Repository;
using System.Collections.Generic;
using System.Linq;

namespace PitRadio.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PlaylistController : ControllerBase
    {
        //private Queue<Song> Playlist { get; set; } = new Queue<Song>(new[] { new Song("test1", "test1"), new Song("test2", "test2"), new Song("test3", "test3") });
        private readonly IPlaylistRepository _playlistRepository;
        private readonly IAlbumRepository _albumRepository;

        public PlaylistController(IPlaylistRepository playlistRepository, IAlbumRepository albumRepository)
        {
            _playlistRepository = playlistRepository;
            _albumRepository = albumRepository;
        }

        [HttpGet(nameof(GetSongsInQueue))]
        public IEnumerable<Song> GetSongsInQueue()
        {
            return _playlistRepository.GetSongsInQueue();
        }

        [HttpGet(nameof(GetCurrentSong))]
        public Song GetCurrentSong()
        {
            return _playlistRepository.GetSongsInQueue().FirstOrDefault();
        }

        [HttpPost(nameof(AddSongToQueue))]
        public IEnumerable<Song> AddSongToQueue(string uuid)
        {
            _playlistRepository.AddSongToQueue(_albumRepository.GetSongBySongUUID(uuid));
            return _playlistRepository.GetSongsInQueue();
        }
    }
}
