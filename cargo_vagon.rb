# frozen_string_literal: true

# fff
class VagonCargo < Vagon
  attr_accessor :type, :all_capacity, :available_capacity, :id

  @@all = []
  def initialize(capacity)
    super
    @type = 'cargo'
    @all_capacity = capacity
    @available_capacity = capacity
    @@all << 1
    @id = @@all.length
  end

  def take_capacity(cap)
    (available_capacity - cap).positive? ? self.available_capacity -= cap : (puts 'There is no enought capacity')
  end

  def taken_capacity
    puts "There are #{all_capacity - available_capacity} m^3 taken capacity"
  end

  def free_capacity
    puts "There are #{available_capacity} m^3 free capacity"
  end
end
