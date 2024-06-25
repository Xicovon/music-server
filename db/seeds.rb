# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

a = Artist.find_or_create_by!(name:"temp artist name 1")
s = Song.find_or_create_by!(original_title: "temp song original title 1", title: "temp song title 1", path: "file path")
a.songs << s
a.save!
an = AlternateArtistName.new(alt_name: "alt name")
an.artist = a
an.save