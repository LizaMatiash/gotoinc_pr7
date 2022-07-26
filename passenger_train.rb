# frozen_string_literal: true

# hhhhhh
class PassangerTrain < Train
  attr_accessor :type

  def initialize(number)
    super
    @type = 'passanger'
  end

  def hook(vagon)
    @speed.zero? && vagon.type == 'passanger' ? size << vagon : (puts 'Can`t hook vagon')
  end

  def unhook
    @speed.zero? && size.any? ? size.pop : (puts 'Can`t unhook vagon')
  end
end
