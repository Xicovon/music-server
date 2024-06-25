class CreateSongs < ActiveRecord::Migration[7.2]
  def change
    create_table :songs do |t|
      t.string :original_title
      t.string :title
      t.string :path
      t.timestamps
    end
  end
end
