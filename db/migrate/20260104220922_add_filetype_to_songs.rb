class AddFiletypeToSongs < ActiveRecord::Migration[7.2]
  def change
    add_column :songs, :filetype, :string
  end
end
