# frozen_string_literal: true

class Album
  attr_accessor :album_artist, :album_title, :album_label, :album_genre, :album_tracks

  def initialize(album_artist, album_title, record_label, album_genre, album_tracks)
    @album_artist = album_artist
    @album_title = album_title
    @album_label = record_label
    @album_genre = album_genre
    @album_tracks = album_tracks
  end
end
