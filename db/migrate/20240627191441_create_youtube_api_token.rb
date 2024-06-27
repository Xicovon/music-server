class CreateYoutubeApiToken < ActiveRecord::Migration[7.2]
  def change
    create_table :youtube_api_tokens do |t|
      t.string :token
      t.timestamps
    end
  end
end
