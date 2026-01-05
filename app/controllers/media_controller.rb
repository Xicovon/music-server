class MediaController < ApplicationController
  def audio
    file_path = params[:id]
    send_file("/media/bowen/musicserver_data/#{file_path}.opus",
      :filename => file_path,
      :type => "audio/ogg")
  end

  def image
    file_path = params[:id]
    send_file("/media/bowen/musicserver_data/#{file_path}.jpg",
      :filename => file_path,
      :type => "image/jpg")
  end
end
