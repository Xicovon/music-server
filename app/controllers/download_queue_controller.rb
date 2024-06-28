class DownloadQueueController < ApplicationController
  def index
    pending_downloads = SongDownloadQueue.all

    respond_to do |format|
      format.html { render :index, locals: { pending_downloads: pending_downloads } }
    end
  end
end
