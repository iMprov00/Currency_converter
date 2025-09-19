require_relative 'keybord'
require 'colorize'

class Convertor

  def initialize
    @currencies = Currencies.new.hash_currencies
  end

  def convert(options={})
    currencie_1 = options[:currencie_1].to_sym
    currencie_2 = options[:currencie_2].to_sym
    sum = options[:sum]

    result = (sum * @currencies[currencie_1]) / @currencies[currencie_2]
    
    result.round(2)
  end
end

class Currencies
  def hash_currencies
    {
      RUB: 1,
      USD: 83.17,
      EUR: 98.98,
      CNY: 11.67,
      KZT: 0.15,
      TRY: 2.02
    }
  end
end 

class ViewCurrencies
  def initialize
    @currencies = Currencies.new.hash_currencies
  end

  def view_currencies
    @currencies.each do |key, value|
      puts key
    end
  end
end

module Helper
  module_function 

  def true?(input) 
    currencies = Currencies.new.hash_currencies

    currencies.has_key?(input.to_sym)
  end

  def clear_screen
    print "\e[H\e[2J"
  end
end

view = ViewCurrencies.new
convertor = Convertor.new

loop do
  Helper.clear_screen

  view.view_currencies

  print "Укажите какую валюту хотите конвертировать: "
  input_1 = gets.chomp.upcase

  if Helper.true?(input_1)
    Helper.clear_screen
    print "Укажите сумму для валюты #{input_1}: "
    sum = gets.chomp.to_f

    loop do
      Helper.clear_screen

      view.view_currencies
      print "Укажите в какую валюту хотите конвертировать: "
      input_2 = gets.chomp.upcase

      if Helper.true?(input_2)
        Helper.clear_screen

        options = {currencie_1: input_1, currencie_2: input_2, sum: sum}

        puts "Ваш результат конвертации #{input_1} с суммой #{sum} в #{input_2}: #{convertor.convert(options)}"
        print "Нажмите любую кнопку чтобы продолжить..."
        gets
        break

      else
        Helper.clear_screen
        puts "Такой валюты нет!"
        sleep(2)
      end
    end
  else
    Helper.clear_screen
    puts "Такой валюты нет!"
    sleep(2)
  end
end