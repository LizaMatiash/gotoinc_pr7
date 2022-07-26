# frozen_string_literal: true

# fff
class Train
  include Company
  attr_reader :speed, :size, :route, :station, :number
  attr_writer :speed, :size, :route, :station, :number

  VALIDATION = /^[a-z 0-9]{3}-?[a-z 0-9]{2}$/i

  @@all = []
  def initialize(number)
    @number = number
    validate!
    @size = []
    @speed = 0
    @route = nil
    @station = nil
    @@all << number
    puts "Train #{number} was created!"
  end

  def new_speed(nss)
    self.speed = nss
  end

  def brake
    self.speed = 0
  end

  def current_speed
    puts "Current speed is #{speed}"
  end

  def current_size
    puts "Current size is #{size}"
  end

  def get_route(route)
    self.route = route
    puts "Your route is #{route.join(', ')}"
  end

  def move_to_next_station
    self.station = route[0] if station.nil?
    self.station = route[route.index(station) + 1] if route.index(station) + 1 < route.size
    puts "Your station is: #{station}"
  end

  def station_route
    self.station = route[0] if station.nil?
    if station == route[0]
      puts "You are on first station #{station}, next #{route[route.index(station) + 1]}"
    elsif station == route[route.size - 1]
      puts "You are on last station #{station}, prev #{route[route.index(station) - 1]}"
    else
      puts "Your station: #{station}, prev #{route[route.index(station) - 1]}, next #{route[route.index(station) + 1]}"
    end
  end

  def self.find(num)
    puts @@all.include?(num) ? "Train #{num} founded" : nil
  end

  def valid?
    validate!
  rescue
    false
  end

  def all_vagons(&show_vagons)
    puts "All vagons in #{number} train are:"
    size.each {|vagon| show_vagons.call(vagon)}
  end

  protected

  def validate!
    raise "Number can't be that" if number !~ VALIDATION
    true
  end
end
