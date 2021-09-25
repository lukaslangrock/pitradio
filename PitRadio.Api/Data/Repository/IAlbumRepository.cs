using PitRadio.Api.Data.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace PitRadio.Api.Data.Repository
{
    public interface IAlbumRepository
    {
        IEnumerable<Album> GetAllAlbums();
        Album GetAlbumBySong(string songname);
    }
}
