using Microsoft.AspNetCore.Mvc;
using PitRadio.Api.Data.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace PitRadio.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PlaylistController : ControllerBase
    {
        private Queue<Song> Playlist { get; set; } = new Queue<Song>(new[] { new Song("test1", "test1"), new Song("test2", "test2"), new Song("test3", "test3") });

        public PlaylistController()
        { }

        [HttpGet(nameof(GetSongsInQueue))]
        public IEnumerable<Song> GetSongsInQueue()
        {
            return Playlist.AsEnumerable();
        }

        [HttpGet(nameof(GetCurrentSong))]
        public Song GetCurrentSong()
        {
            return Playlist.FirstOrDefault();
        }

        [HttpPost(nameof(AddSongToQueue))]
        public IEnumerable<Song> AddSongToQueue(Song song)
        {
            Playlist.Enqueue(song);
            return Playlist;
        }
    }
}
