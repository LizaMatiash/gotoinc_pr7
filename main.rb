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

# main class
class MainClass
  attr_accessor :station, :station_list, :cargo_train_list, :passanger_train_list

  def initialize
    @station_list = []
    @passanger_train_list = []
    @cargo_train_list = []
    @station = nil
    @train = nil
  end

  def add_station
    begin
      puts MESSAGE[:enter_station_name]
      name = gets.chomp
      station = Station.new(name)
    rescue
      puts MESSAGE[:error_station_name]
      retry
    end
    station_list << station
  end

  def add_train
    puts MESSAGE[:enter_train_choise]
    tr_choise = gets.chomp.to_i
    begin
      puts MESSAGE[:enter_train_number]
      number = gets.chomp
      case tr_choise
      when 1
        train = PassangerTrain.new(number)
        passanger_train_list << train
      when 2
        train = CargoTrain.new(number)
        cargo_train_list << train
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
    when 1 then hook_vagon(passanger_train_list)
    when 2 then hook_vagon(cargo_train_list)
    else puts MESSAGE[:error_input]
    end
  end

  def delete_vagon
    puts MESSAGE[:enter_train_choise]
    tr_choise = gets.chomp.to_i
    case tr_choise
    when 1 then unhook_vagon(passanger_train_list)
    when 2 then unhook_vagon(cargo_train_list)
    else puts MESSAGE[:error_input]
    end
  end

  def train_on_station
    puts MESSAGE[:enter_train_choise]
    tr_choise = gets.chomp.to_i
    case tr_choise
    when 1 then train_to_station(station_list, passanger_train_list)
    when 2 then train_to_station(station_list, cargo_train_list)
    else puts MESSAGE[:error_input]
    end
  end

  def vagon_list
    puts MESSAGE[:enter_train_choise]
    tr_choise = gets.chomp.to_i
    case tr_choise
    when 1
      puts MESSAGE[:list_of_trains]
      passanger_train_list.each { |tr| puts tr.number }
      puts MESSAGE[:enter_train_number]
      number = gets.chomp
      passanger_train_list.each { |tr| tr.all_vagons { |vag| puts vag } if number == tr.number }
    when 2
      puts MESSAGE[:list_of_trains]
      cargo_train_list.each { |tr| puts tr.number }
      puts MESSAGE[:enter_train_number]
      number = gets.chomp
      cargo_train_list.each { |tr| tr.all_vagons { |vag| puts vag } if number == tr.number }
    else
      puts MESSAGE[:error_input]
    end
  end

  # def show_all
  #   station_list.each { |st| puts "Station name: #{st.show_all} #{st.name} " }
  # end

  def show_all
    station_list.each { |st| st.all_trains { |train| puts train } }
  end

  def take_place
    puts MESSAGE[:enter_train_choise]
    tr_choise = gets.chomp.to_i
    case tr_choise
    when 1 then choose_vagon(passanger_train_list, 'pas')
    when 2 then choose_vagon(cargo_train_list, 'carg')
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
    number = gets.chomp.to_i
    list.each { |tr| tr.unhook if number == tr.number }
  end

  def train_to_station(station_list, train_list)
    puts MESSAGE[:list_of_stations]
    station_list.each { |st| puts "#{station_list.index(st)} - #{st.name}" }
    puts MESSAGE[:enter_station_number]
    station = gets.chomp.to_i
    puts MESSAGE[:list_of_trains]
    train_list.each { |tr| puts tr.number }
    puts MESSAGE[:enter_train_number]
    number = gets.chomp
    train_list.each { |tr| station_list[station].coming(tr) if number == tr.number }
  end
end

# ----------------------------------------------------------------------------------------
main = MainClass.new

loop do
  puts MESSAGE[:interfase]
  fin = false
  choise = gets.chomp.to_i
  case choise

  when 1 then main.send :add_station
  when 2 then main.send :add_train
  when 3 then main.send :add_vagon
  when 4 then main.send :delete_vagon
  when 5 then main.send :train_on_station
  when 6 then main.send :vagon_list
  when 7 then main.send :show_all
  when 8 then main.send :take_place
  else
    fin = true
  end

  break if fin
end

# vagon = VagonPassanger.new(7)
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
