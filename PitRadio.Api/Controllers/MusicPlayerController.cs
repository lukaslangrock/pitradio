using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using PitRadio.Api.Data.Repository;
using PitRadio.MusicPlayer;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace PitRadio.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MusicPlayerController : ControllerBase
    {
        private readonly IMusicPlayer _musicPlayer;
        private readonly IAlbumRepository _albumRepository;

        public MusicPlayerController(IMusicPlayer musicPlayer, IAlbumRepository albumRepository)
        {
            _musicPlayer = musicPlayer;
            _albumRepository = albumRepository;
        }

        [HttpPost(nameof(PlaySongByUuid) + "/{uuid}")]
        public void PlaySongByUuid(string uuid) => _musicPlayer.PlaySong(_albumRepository.GetSongBySongUUID(uuid).File);

        [HttpPost(nameof(Stop))]
        public void Stop() => _musicPlayer.StopSong();

        [HttpPost(nameof(Pause))]
        public void Pause() => _musicPlayer.Pause();

        [HttpPost(nameof(Resume))]
        public void Resume() => _musicPlayer.Resume();
    }
}
