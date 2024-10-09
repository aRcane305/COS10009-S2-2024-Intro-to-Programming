# frozen_string_literal: true

class Track
  attr_accessor :track_name, :track_location, :track_duration

  def initialize(track_name, track_location, track_duration)
    @track_name = track_name
    @track_location = track_location
    @track_duration = track_duration
  end
end