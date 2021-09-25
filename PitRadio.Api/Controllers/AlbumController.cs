﻿using Microsoft.AspNetCore.Mvc;
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

        [HttpGet(nameof(GetAlbumBySong) + "/{songname}")]
        public Album GetAlbumBySong(string songname)
        {
            return _albumRepository.GetSong(songname);
        }
    }
}
