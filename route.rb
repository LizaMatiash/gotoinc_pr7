# frozen_string_literal: true

# dd
class Route
  attr_accessor :route
  attr_reader :start, :finish

  def initialize(start, finish)
    @start = start
    @finish = finish
    @route = []
    @full_way = []
    @full_way.push(start, finish)
  end

  def add(station)
    route << station
  end

  def delete(station)
    route.delete(station)
  end

  def show
    puts "Your route is #{start}, #{route.join(', ')}, #{finish}"
  end
end
