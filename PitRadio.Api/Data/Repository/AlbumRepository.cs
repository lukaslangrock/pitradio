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

        public Album GetAlbumBySongName(string name)
        {
            return _albums.FirstOrDefault(album => album.Songs.FirstOrDefault(song => song.Title == name) != default(Song));
        }

        public Album GetAlbumBySongUUID(string uuid)
        {
            return _albums.FirstOrDefault(album => album.Songs.FirstOrDefault(song => song.UUID == uuid) != default(Song));
<<<<<<< HEAD
=======
        }

        public Album GetAlbumByAlbumName(string name)
        {
            return _albums.FirstOrDefault(album => album.Title == name);
        }

        public Album GetAlbumByAlbumUUID(string uuid)
        {
            return _albums.FirstOrDefault(album => album.UUID == uuid);
        }

        public byte[] GetAlbumArtworkByAlbumName(string name)
        {
            Album album = GetAlbumByAlbumName(name);
            return File.ReadAllBytes(Path.Join(Environment.CurrentDirectory, "Resources", "musicdb", album.Folder, "cover.jpg"));
        }

        public byte[] GetAlbumArtworkByAlbumUUID(string uuid)
        {
            Album album = GetAlbumByAlbumUUID(uuid);
            return File.ReadAllBytes(Path.Join(Environment.CurrentDirectory, "Resources", "musicdb", album.Folder, "cover.jpg"));
        }

        public Song GetSongBySongUUID(string uuid)
        {
            Album temp = _albums.FirstOrDefault(album => album.Songs.FirstOrDefault(song => song.UUID == uuid) != default(Song));
            return temp.Songs.FirstOrDefault(album => album.UUID == uuid);
>>>>>>> d781e3f683cd2be829ed8dd0bda3b7f201feb675
        }
    }
}
