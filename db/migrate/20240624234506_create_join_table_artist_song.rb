class CreateJoinTableArtistSong < ActiveRecord::Migration[7.2]
  def change
    create_join_table :artists, :songs do |t|
      t.references :artists, foreign_key: true
      t.references :songs, foreign_key: true
    end
  end
end
