# frozen_string_literal: true

# fff
class VagonPassanger < Vagon
  attr_accessor :type, :all_seats, :available_seats, :id

  @@all = []
  def initialize(seats)
    super
    @type = 'passanger'
    @all_seats = seats
    @available_seats = seats
    @@all << 1
    @id = @@all.length
  end

  def take_seat
    available_seats.positive? ? self.available_seats -= 1 : (puts 'There is no free seats')
  end

  def taken_seats
    puts "There are #{all_seats - available_seats} taken seats"
  end

  def free_seats
    puts "There are #{available_seats} free seats"
  end
end
