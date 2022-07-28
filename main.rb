# frozen_string_literal: true

require_relative 'company'
require_relative 'route'
require_relative 'train'
require_relative 'station'
require_relative 'vagon'
require_relative 'passenger_train'
require_relative 'passanger_vagon'
require_relative 'cargo_train'
require_relative 'cargo_vagon'

# main class
class MainClass
  MESSAGE = {
    interfase: "\nEnter num(or anything to finish):  \n1 - add new station \n2 - create new train
3 - hook vagon to train \n4 - unhook vagon \n5 - add train to station \n6 - list of vagons
7 - list of stations and trains \n8 - take place in vagon",
    enter_station_name: 'Enter station name: ',
    enter_train_choise: "Which train you want to edit \n1 - passanger \n2 - cargo",
    enter_train_number: 'Enter train number: ',
    error_input: 'Your input is wrong',
    list_of_trains: 'List of your trains: ',
    enter_type_of_vagon: 'Enter 1 - passanger vagon, 2 - cargo vagon',
    error_vagon_type: 'There is no such type',
    list_of_stations: 'List of your stations: ',
    enter_station_number: 'Enter station index: ',
    error_station_name: 'Station name shoud start with big letter and be only with letters',
    error_train_name: 'Train name should look like XXX-XX or XXXXX',
    enter_seats_vagon_value: 'Enter all seats in vagon: ',
    enter_capacity_vagon: 'Enter capacity of vagon: ',
    list_of_vagons: 'List of your vagons: ',
    enter_vagon_id: 'Enter vagon id ',
    enter_taken_place_in_vagon: 'Enter capasity you take '
  }.freeze

  METHOD = {
    1 => :add_station,
    2 => :add_train,
    3 => :add_vagon,
    4 => :delete_vagon,
    5 => :train_on_station,
    6 => :vagon_list,
    7 => :show_all,
    8 => :take_place
  }.freeze

  attr_accessor :station

  def initialize
    @station = nil
    @train = nil
  end

  def start_main
    loop do
      puts MESSAGE[:interfase]
      fin = false
      choise = gets.chomp.to_i

      choise.between?(1, METHOD.length) ? send(METHOD[choise]) : fin = true

      break if fin
    end
  end

  def add_station
    begin
      puts MESSAGE[:enter_station_name]
      name = gets.chomp
      Station.new(name)
    rescue
      puts MESSAGE[:error_station_name]
      retry
    end
  end

  def add_train
    puts MESSAGE[:enter_train_choise]
    tr_choise = gets.chomp.to_i
    begin
      puts MESSAGE[:enter_train_number]
      number = gets.chomp
      case tr_choise
      when 1
        PassangerTrain.new(number)
      when 2
        CargoTrain.new(number)
      else
        puts MESSAGE[:error_input]
      end
    rescue
      puts MESSAGE[:error_train_name]
      retry
    end
  end

  def add_vagon
    puts MESSAGE[:enter_train_choise]
    tr_choise = gets.chomp.to_i
    case tr_choise
    when 1 then hook_vagon(PassangerTrain.all_passanger_trains)
    when 2 then hook_vagon(CargoTrain.all_cargo_trains)
    else puts MESSAGE[:error_input]
    end
  end

  def delete_vagon
    puts MESSAGE[:enter_train_choise]
    tr_choise = gets.chomp.to_i
    case tr_choise
    when 1 then unhook_vagon(PassangerTrain.all_passanger_trains)
    when 2 then unhook_vagon(CargoTrain.all_cargo_trains)
    else puts MESSAGE[:error_input]
    end
  end

  def train_on_station
    puts MESSAGE[:enter_train_choise]
    tr_choise = gets.chomp.to_i
    case tr_choise
    when 1 then train_to_station(PassangerTrain.all_passanger_trains)
    when 2 then train_to_station(CargoTrain.all_cargo_trains)
    else puts MESSAGE[:error_input]
    end
  end

  def vagon_list
    puts MESSAGE[:enter_train_choise]
    tr_choise = gets.chomp.to_i
    case tr_choise
    when 1
      puts MESSAGE[:list_of_trains]
      PassangerTrain.all_passanger_trains.each { |tr| puts tr.number }
      puts MESSAGE[:enter_train_number]
      number = gets.chomp
      PassangerTrain.all_passanger_trains.each { |tr| tr.all_vagons { |vag| puts vag } if number == tr.number }
    when 2
      puts MESSAGE[:list_of_trains]
      CargoTrain.all_cargo_trains.each { |tr| puts tr.number }
      puts MESSAGE[:enter_train_number]
      number = gets.chomp
      CargoTrain.all_cargo_trains.each { |tr| tr.all_vagons { |vag| puts vag } if number == tr.number }
    else
      puts MESSAGE[:error_input]
    end
  end

  # def show_all
  #   station_list.each { |st| puts "Station name: #{st.show_all} #{st.name} " }
  # end

  def show_all
    Station.all.each { |st| st.all_trains { |train| puts train } }
  end

  def take_place
    puts MESSAGE[:enter_train_choise]
    tr_choise = gets.chomp.to_i
    case tr_choise
    when 1 then choose_vagon(PassangerTrain.all_passanger_trains, 'pas')
    when 2 then choose_vagon(CargoTrain.all_cargo_trains, 'carg')
    else puts MESSAGE[:error_input]
    end
  end

  private

  def choose_vagon(train_list, type)
    puts MESSAGE[:list_of_trains]
    train_list.each { |tr| puts tr.number }
    puts MESSAGE[:enter_train_number]
    number = gets.chomp
    puts MESSAGE[:list_of_vagons]
    train_list.each { |tr| tr.all_vagons { |vag| puts "#{vag.id} - #{vag}" } if number == tr.number }
    puts MESSAGE[:enter_vagon_id]
    id = gets.chomp.to_i
    if type == 'pas'
      train_list.each { |tr| tr.size[id - 1].take_seat if number == tr.number }
    else
      puts MESSAGE[:enter_taken_place_in_vagon]
      place = gets.chomp.to_i
      train_list.each { |tr| tr.size[id - 1].take_capacity(place) if number == tr.number }
    end
  end

  def hook_vagon(list)
    puts MESSAGE[:list_of_trains]
    list.each { |tr| puts tr.number }
    puts MESSAGE[:enter_train_number]
    number = gets.chomp
    puts MESSAGE[:enter_type_of_vagon]
    v = gets.chomp.to_i
    case v
    when 1
      puts MESSAGE[:enter_seats_vagon_value]
      seats = gets.chomp.to_i
      vagon ||= VagonPassanger.new(seats)
    when 2
      puts MESSAGE[:enter_capacity_vagon]
      capacity = gets.chomp.to_i
      vagon ||= VagonCargo.new(capacity)
    else
      puts MESSAGE[:error_vagon_type]
    end
    list.each { |tr| tr.hook(vagon) if number == tr.number }
  end

  def unhook_vagon(list)
    puts MESSAGE[:list_of_trains]
    list.each { |tr| puts tr.number }
    puts MESSAGE[:enter_train_number]
    number = gets.chomp
    list.each { |tr| tr.unhook if number == tr.number }
  end

  def train_to_station(train_list)
    puts MESSAGE[:list_of_stations]
    Station.all.each { |st| puts "#{Station.all.index(st)} - #{st.name}" }
    puts MESSAGE[:enter_station_number]
    station = gets.chomp.to_i
    puts MESSAGE[:list_of_trains]
    train_list.each { |tr| puts tr.number }
    puts MESSAGE[:enter_train_number]
    number = gets.chomp
    train_list.each { |tr| Station.all[station].coming(tr) if number == tr.number }
  end
end

# ----------------------------------------------------------------------------------------
MainClass.new.start_main

# tr = PassangerTrain.new('12345')
# vagon = VagonPassanger.new('234')
# tr.hook(vagon)
# vagon = VagonPassanger.new('100')
# tr.hook(vagon)
# vagon = VagonPassanger.new('57')
# tr.hook(vagon)
#
# tr.all_vagons { |vag| puts vag }
#
# tr.unhook
#
# tr.all_vagons { |vag| puts vag }

# station = Station.new('As')
# station = Station.new('Ad')
# station = Station.new('Af')
# station = Station.new('Ag')
# Station.all.each {|x| print Station.all.index(x)}

# tr = CargoTrain.new('12345')
# Station.all[0].coming(tr)
# Train.new('12346')
# PassangerTrain.new('12234')
# CargoTrain.new('23456')
# Train.find('12345')
# Train.find('99999')
# Train.find('23456')
# CargoTrain.all_cargo_trains.each { |train| puts train.type }
# puts PassangerTrain.all_passanger_trains

# vagon = VagonPassanger.new(7)MainClass.start_main
# vagon.take_seat
# vagon.take_seat
# vagon.take_seat
# vagon.taken_seats
# vagon.free_seats

# vagon = VagonCargo.new(70)
# vagon.take_capacity(30)
# vagon.take_capacity(50)
# vagon.take_capacity(1)
# vagon.taken_capacity
# vagon.free_capacity

# station = Station.new('Asdf')
# train = PassangerTrain.new('12345')
# station.coming(train)
# train = PassangerTrain.new('23456')
# station.coming(train)
# train = CargoTrain.new('98765')
# station.coming(train)
# # station.all_trains { |st| puts st }
#
# train_list = []
# #
# train = CargoTrain.new('12345')
# vagon = VagonCargo.new(200)
# train.hook(vagon)
# vagon = VagonCargo.new(300)
# train.hook(vagon)
# vagon = VagonCargo.new(156)
# train.hook(vagon)
# train_list << train
# train.all_vagons { |vag| puts "Id: #{vag.id} - #{vag}" }
# id = 1
# number = '12345'
# place = 56
# # train_list.each { |tr| tr.size[id].take_seat; puts 'AAA' if number == tr.number }
# # train_list.each { |tr| tr.size[id].taken_seats; puts 'AAA' if number == tr.number }
# train_list.each { |tr| tr.size[id].take_capacity(place) if number == tr.number }
# train_list.each { |tr| tr.size[id].taken_capacity if number == tr.number }
