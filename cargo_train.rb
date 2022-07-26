# frozen_string_literal: true

# gggg
class CargoTrain < Train
  attr_accessor :type

  def initialize(number)
    super
    @type = 'cargo'
  end

  def hook(vagon)
    @speed.zero? && vagon.type == 'cargo' ? size << vagon : (puts 'Can`t hook vagon')
  end

  def unhook
    @speed.zero? && size.any? ? size.pop : (puts 'Can`t unhook vagon')
  end
end
