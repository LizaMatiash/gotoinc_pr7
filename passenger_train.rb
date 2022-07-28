# frozen_string_literal: true

# hhhhhh
class PassangerTrain < Train
  attr_accessor :type

  @@all_passanger_trains = []

  def initialize(number)
    super
    @type = 'passanger'
    @@all_passanger_trains << self
  end

  def self.all_passanger_trains
    @@all_passanger_trains
  end

  def hook(vagon)
    @speed.zero? && vagon.type == 'passanger' ? size << vagon : (puts 'Can`t hook vagon')
  end

  def unhook
    @speed.zero? && size.any? ? size.pop : (puts 'Can`t unhook vagon')
  end
end
