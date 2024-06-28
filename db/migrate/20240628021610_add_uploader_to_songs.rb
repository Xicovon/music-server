class AddUploaderToSongs < ActiveRecord::Migration[7.2]
  def change
    add_column :songs, :uploader, :string
  end
end
