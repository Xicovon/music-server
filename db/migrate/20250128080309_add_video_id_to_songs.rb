class AddVideoIdToSongs < ActiveRecord::Migration[7.2]
  def change
    add_column :songs, :video_id, :string
    add_index :songs, :video_id, unique: true
  end
end
