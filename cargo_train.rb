# frozen_string_literal: true

# gggg
class CargoTrain < Train
  attr_accessor :type

  @@all_cargo_trains = []

  def initialize(number)
    super
    @type = 'cargo'
    @@all_cargo_trains << self
  end

  def self.all_cargo_trains
    @@all_cargo_trains
  end

  def hook(vagon)
    @speed.zero? && vagon.type == 'cargo' ? size << vagon : (puts 'Can`t hook vagon')
  end

  def unhook
    @speed.zero? && size.any? ? size.pop : (puts 'Can`t unhook vagon')
  end
end
