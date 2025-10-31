class RetrieveSongUrlsJob
  include Sidekiq::Job

  PLAYLIST_ID = "PLDhY58bJKzLDfJxzHlHlbgfhAAnB-jXN2"

  def perform(*guests)
    next_page_token = nil

    loop do
      response = YoutubeApi.list_playlist_items(PLAYLIST_ID, next_page_token)

      if response.key?("nextPageToken")
        next_page_token = response.fetch("nextPageToken")
      end
      items = response.fetch("items")

      items.each do |i|
        item_id = i.fetch("id")
        thumbnail_url = i.dig("snippet", "thumbnails", "maxres", "url")
        if thumbnail_url.nil?
          thumbnail_url = i.dig("snippet", "thumbnails", "standard", "url")
        end
        if thumbnail_url.nil?
          thumbnail_url = i.dig("snippet", "thumbnails", "default", "url")
        end
        video_id = i.dig("contentDetails", "videoId")
        SongDownloadQueue.find_or_create_by!(playlist_item_id: item_id, video_id: video_id, thumbnail_url: thumbnail_url)
      end

      break if not response.key?("nextPageToken")
    end

    # queue job to download files

    download_job = DownloadSongJob.new
    download_job.perform
    RetrieveSongUrlsJob.perform_at(30.minutes.from_now)
  end
end
