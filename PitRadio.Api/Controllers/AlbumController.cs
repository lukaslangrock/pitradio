using Microsoft.AspNetCore.Mvc;
using PitRadio.Api.Data.Model;
using PitRadio.Api.Data.Repository;
using System.Collections.Generic;

namespace PitRadio.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AlbumController : ControllerBase
    {
        private readonly IAlbumRepository _albumRepository;

        public AlbumController(IAlbumRepository albumRepository)
        {
            _albumRepository = albumRepository;
        }

        [HttpGet(nameof(GetAllAlbums))]
        public IEnumerable<Album> GetAllAlbums()
        {
            return _albumRepository.GetAllAlbums();
        }

        [HttpGet(nameof(GetAlbumBySongName) + "/{name}")]
        public Album GetAlbumBySongName(string name)
        {
            return _albumRepository.GetAlbumBySongName(name);
        }

        [HttpGet(nameof(GetAlbumBySongUUID) + "/{uuid}")]
        public Album GetAlbumBySongUUID(string uuid)
        {
            return _albumRepository.GetAlbumBySongUUID(uuid);
        }

        [HttpGet(nameof(GetAlbumByAlbumName) + "/{name}")]
        public Album GetAlbumByAlbumName(string name)
        {
            return _albumRepository.GetAlbumByAlbumName(name);
        }

        [HttpGet(nameof(GetAlbumByAlbumUUID) + "/{uuid}")]
        public Album GetAlbumByAlbumUUID(string uuid)
        {
            return _albumRepository.GetAlbumByAlbumUUID(uuid);
        }

        [HttpGet(nameof(GetAlbumArtworkByAlbumName) + "/{name}")]
        public IActionResult GetAlbumArtworkByAlbumName(string name)
        {
            byte[] b = _albumRepository.GetAlbumArtworkByAlbumName(name);
            return File(b, "image/jpeg");
        }

        [HttpGet(nameof(GetAlbumArtworkByAlbumUUID) + "/{uuid}")]
        public IActionResult GetAlbumArtworkByAlbumUUID(string uuid)
        {
            byte[] b = _albumRepository.GetAlbumArtworkByAlbumUUID(uuid);
            return File(b, "image/jpeg");
        }
    }
}
