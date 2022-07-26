# frozen_string_literal: true

#  kkkkk
module Company
  attr_accessor :company

  def company_name(name)
    self.company = name
  end

  def company_get
    puts "Company name is #{company}"
  end
end
