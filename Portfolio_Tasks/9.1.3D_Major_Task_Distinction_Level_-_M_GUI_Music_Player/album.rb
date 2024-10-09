# frozen_string_literal: true

class Album
  attr_accessor :album_title, :album_artist, :album_record_label, :album_cover, :album_year, :album_genre, :album_tracks

  def initialize(album_title, album_artist, album_record_label, album_cover, album_year, album_genre, album_tracks)
    @album_title = album_title
    @album_artist = album_artist
    @album_record_label = album_record_label
    @album_cover = album_cover
    @album_year = album_year
    @album_genre = album_genre
    @album_tracks = album_tracks
  end
end