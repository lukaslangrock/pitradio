using Microsoft.AspNetCore.Mvc;
using PitRadio.Api.Data.Model;
using PitRadio.Api.Data.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace PitRadio.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PlaylistController : ControllerBase
    {
        private readonly IPlaylistRepository _playlistRepository;

        public PlaylistController(IPlaylistRepository playlistRepository)
        {
            _playlistRepository = playlistRepository;
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
        public IEnumerable<Song> AddSongToQueue(Song song)
        {
            _playlistRepository.AddSongToQueue(song);
            return _playlistRepository.GetSongsInQueue();
        }
    }
}
