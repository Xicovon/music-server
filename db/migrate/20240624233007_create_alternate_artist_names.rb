class CreateAlternateArtistNames < ActiveRecord::Migration[7.2]
  def change
    create_table :alternate_artist_names do |t|
      t.string :alt_name
      t.timestamps
    end
    add_reference :alternate_artist_names, :artist, foreign_key: true
  end
end
