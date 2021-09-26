using PitRadio.Api.Data.Model;
using System.Collections.Generic;

namespace PitRadio.Api.Data.Repository
{
    public interface IAlbumRepository
    {
        IEnumerable<Album> GetAllAlbums();
        Album GetAlbumBySongName(string songname);
        Album GetAlbumBySongUUID(string uuid);
        Album GetAlbumByAlbumName(string songname);
        Album GetAlbumByAlbumUUID(string uuid);
        byte[] GetAlbumArtworkByAlbumName(string songname);
        byte[] GetAlbumArtworkByAlbumUUID(string uuid);
        Song GetSongBySongUUID(string uuid);
    }
}
