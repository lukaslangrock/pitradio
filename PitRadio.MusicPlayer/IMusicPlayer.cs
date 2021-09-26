using System;

namespace PitRadio.MusicPlayer
{
    public interface IMusicPlayer
    {
        TimeSpan SongDuration { get; }
        DateTime StartTime { get; }
        TimeSpan TimeLeft { get; }

        void PlaySong(string filePath);
        void StopSong();
        void Pause();
        void Resume();
    }
}