class CreateSongDownloadQueue < ActiveRecord::Migration[7.2]
  def change
    create_table :song_download_queues do |t|
      t.string :playlist_item_id
      t.string :url
      t.timestamps
    end
    add_index :song_download_queues, :playlist_item_id, unique: true
  end
end
