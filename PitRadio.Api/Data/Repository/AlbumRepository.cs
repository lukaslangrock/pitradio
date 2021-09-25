using Newtonsoft.Json;
using PitRadio.Api.Data.Model;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

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

        public Album GetAlbumBySong(string filepath)
        {
            return _albums.FirstOrDefault(album => album.Songs.FirstOrDefault(song => song.File == filepath) != default(Song));
        }
    }
}
