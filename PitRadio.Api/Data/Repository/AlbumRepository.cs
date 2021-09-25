using Newtonsoft.Json;
using PitRadio.Api.Data.Model;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace PitRadio.Api.Data.Repository
{
    public class AlbumRepository : IAlbumRepository
    {
        private readonly IEnumerable<Album> _albums;

        public AlbumRepository()
        {
            var fileContent = File.ReadAllText(Path.Join(Environment.CurrentDirectory, "Resources", "musicdb.json"));
            _albums = JsonConvert.DeserializeObject<IEnumerable<Album>>(fileContent);
        }

        public IEnumerable<Album> GetAllAlbums()
        {
            return _albums;
        }

        public Album GetAlbumBySong(string songname)
        {
            return _albums.FirstOrDefault(album => album.Songs.FirstOrDefault(song => song.Title == songname) != default(Song));
        }

        public Album GetAlbumByUUID(string uuid)
        {
            return _albums.FirstOrDefault(album => album.Songs.FirstOrDefault(song => song.Title == uuid) != default(Song));
        }
    }
}
