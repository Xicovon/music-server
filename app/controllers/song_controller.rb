class SongController < ApplicationController
  def index
    songs = Song.all

    respond_to do |format|
      format.html { render :index, locals: { songs: songs } }
    end
  end

  def show
  end

  def edit
  end

  def delete
  end
end
