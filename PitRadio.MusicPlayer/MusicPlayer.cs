using System;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace PitRadio.MusicPlayer
{
    public class MusicPlayer
    {
        private ProcessStartInfo FplayStartInfo { get; set; } = new ProcessStartInfo { FileName = "ffplay" };
        private ProcessStartInfo OpusinfoStartInfo { get; set; } = new ProcessStartInfo { FileName = "opusinfo", UseShellExecute = false, RedirectStandardOutput = true, CreateNoWindow = true };

        private static Regex Regex { get; set; } = new Regex("Playback length: (.*)");

        private Process Process { get; set; }

        public DateTime StartTime { get; private set; }
        public TimeSpan SongDuration { get; private set; }
        public TimeSpan TimeLeft { get { return SongDuration - (DateTime.Now - StartTime); } }

        public MusicPlayer()
        { }

        public void PlaySong(string filePath)
        {
            SongDuration = GetSongDuration(filePath);
            ResetProcess();

            FplayStartInfo.Arguments = filePath;
            Process = new() { StartInfo = FplayStartInfo };
            Process.Start();

            StartTime = DateTime.Now;
        }

        private TimeSpan GetSongDuration(string filePath)
        {
            var songInfo = GetSongInfo(filePath);

            var playbackLength = Regex
                .Match(songInfo)
                .Groups
                .Values
                .LastOrDefault();

            if (playbackLength == default(Group) || playbackLength is null)
                throw new Exception("Could not find a match in song info.");

            var playbackLengthAsString = playbackLength
                .ToString()
                .Replace("\t", "")
                .Replace("\r", "")
                .Replace("\n", "");

            var playbackLengthSplit = playbackLengthAsString.Split(':');

            var minutes = GetValueAsDouble(playbackLengthSplit, "m");
            var seconds = GetValueAsDouble(playbackLengthSplit, "s");

            return TimeSpan.FromSeconds(minutes * 60 + seconds);
        }

        private string GetSongInfo(string filePath)
        {
            OpusinfoStartInfo.Arguments = filePath;

            Process = new() { StartInfo = OpusinfoStartInfo };

            Process.Start();

            var sb = new StringBuilder();

            while (!Process.StandardOutput.EndOfStream)
            {
                sb.Append(Process.StandardOutput.ReadLine());
                sb.Append(Environment.NewLine);
            }

            return sb.ToString();
        }

        public void StopSong()
        {
            ResetProcess();
            StartTime = DateTime.MinValue;
        }

        private void ResetProcess()
        {
            Process?.Kill();
            Process?.Dispose();
        }

        private static double GetValueAsDouble(string[] input, string indicator) => double.Parse(input.First(elem => elem.EndsWith(indicator)).Replace(indicator, ""));
    }
}
