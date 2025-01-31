class DownloadSongJob
  include Sidekiq::Job
  require 'open-uri'

  OUTPUT_DIRECTORY = "/media/bowen/musicserver_data"

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
      video_id = response.dig("items").first.dig("id")
      output_path = "#{OUTPUT_DIRECTORY}/#{video_id}"

      # Skip if the file has already been downloaded
      if File.file?("#{output_path}.opus")
        YoutubeApi.delete_playlist_item(song.playlist_item_id)
        song.destroy
        next
      end

      state = YoutubeDL.download("https://www.youtube.com/watch?v=#{song.video_id}", extract_audio: true, output: output_path).call
      if state.error?
        File.delete(state.info_json)
        next
      end

      File.delete(state.info_json)

      if File.file?("#{output_path}.opus")
        s = Song.new(video_id: video_id, original_title: title, title: title, path: "#{output_path}.opus", uploader: channel_title)
        s.save

        download_thumbnail(song.thumbnail_url, "#{output_path}.jpg")

        YoutubeApi.delete_playlist_item(song.playlist_item_id)
        song.destroy
      end
    end
  end

  def download_thumbnail(url, output)
    download = URI.open(url)
    IO.copy_stream(download, output)
  end
end
