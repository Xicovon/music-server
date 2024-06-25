class Artist < ApplicationRecord
  has_many :alternate_artist_names
  has_many :artist_songs
  has_many :songs, :through => :artist_songs
end
