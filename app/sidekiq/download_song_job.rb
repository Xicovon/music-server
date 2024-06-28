class DownloadSongJob
  include Sidekiq::Job

  OUTPUT_DIRECTORY = "/media/bowen/4bda08cd-11f8-4fdf-a496-2e21e1d3c1b5/musicserver_data"

  def perform(*guests)
    songs_to_download = SongDownloadQueue.all

    songs_to_download.each do |song|
      response = YoutubeApi.list_video_by_id(song.video_id)

      if(response.fetch("items").count == 0)
        YoutubeApi.delete_playlist_item(song.playlist_item_id)
        song.destroy
        next
      end

      channel_title = response.dig("items").first.dig("snippet", "channelTitle")
      title = response.dig("items").first.dig("snippet", "title")

      output_path = "#{OUTPUT_DIRECTORY}/#{song.video_id}"

      state = YoutubeDL.download("https://www.youtube.com/watch?v=#{song.video_id}", extract_audio: true, output: output_path).call
      if state.error?
        next
      end

      File.delete(state.info_json)

      if File.file?("#{output_path}.opus")
        s = Song.new(original_title: title, title: title, path: "#{output_path}.opus", uploader: channel_title)
        s.save

        song.destroy
      end
    end
  end
end
