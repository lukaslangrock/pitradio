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

		private IEnumerable<Song> Playlist {
			get; set;
		}

		private IEnumerable<Song> _pastSongs;
		private IEnumerable<Song> _comingSongs;
		private Song _currentSong;

		public PlaylistController()
		{
			_pastSongs = new List<Song>();
			_comingSongs = new List<Song>();
			_currentSong = null;
		}

		[HttpGet(nameof(AddVote))]
		public void AddVote(Song song, bool vote)
		{
			song = Playlist.ToList().Find(x => x.File == song.File);
			song.Votes.Add(vote);
		}

		[HttpGet(nameof(GetSongsInQueue))]
		public IEnumerable<Song> GetSongsInQueue()
		{
			return Playlist;
		}

		[HttpGet(nameof(GetCurrentSong))]
		public Song GetCurrentSong()
		{
			return _currentSong;
		}

		[HttpPost(nameof(AddSongToQueue))]
		public void AddSongToQueue(Song song)
		{
			_comingSongs.Append(song);
		}
		private void UpdatePlaylist()
		{
			IEnumerable<Song> outList = new List<Song>();
			outList = outList.Concat(_pastSongs);
			outList.Append(_currentSong);
			outList = outList.Concat(_comingSongs);
			Playlist = outList;
		}

		private void SortComingSongs()
		{
			_comingSongs.ToList().ToList().Sort(delegate(Song x, Song y)
			{
				return GetScore(y)-GetScore(x);
			});
			UpdatePlaylist();
		}

		private void SkipSong()
		{
			_pastSongs.Append(_currentSong);
			_currentSong = _comingSongs.FirstOrDefault();
			_comingSongs.ToList().RemoveAt(0);
			UpdatePlaylist();
		}

		private int GetScore(Song song)
		{
			song = Playlist.ToList().Find(x => x.File == song.File);
			int score = 0;
			foreach (bool vote in song.Votes)
			{
				if(vote)
					score++;
				else
					score--;
			}
			return score;
		}

		private void RevertSong()
		{
			_comingSongs.Append(_currentSong);
			SortComingSongs();

			_currentSong = _pastSongs.LastOrDefault();
			_pastSongs.ToList().RemoveAt(_pastSongs.Count() - 1);
			UpdatePlaylist();
		}
	}
}
