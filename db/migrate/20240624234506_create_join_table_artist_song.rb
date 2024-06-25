class CreateJoinTableArtistSong < ActiveRecord::Migration[7.2]
  def change
    create_join_table :artist, :song do |t|
      t.references :artist, foreign_key: true
      t.references :song, foreign_key: true
    end
  end
end
