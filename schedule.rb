#!/usr/bin/env ruby -w
# schedule.rb - a script to give me today's schedule in the terminal
require 'date'
require 'optparse'
require File.join(File.dirname(__FILE__), 'marymount')
include Marymount

#now = DateTime.now
#month, num, name = now.strftime( "%b-%d-%a").split(/-/)

raw_dates = []
set_days  = []

optparse = OptionParser.new do |opts|
  opts.banner = "Usage: schedule [options]"

  opts.on( '-t', 'Get tomorrow\'s schedule today.') do
    raw_dates << DateTime.now.next_day
  end
  opts.on( '-a', '-aweek day', String, "A week schedule") do |name|
    name = name.downcase.capitalize
    set_days << A[name]
  end
  opts.on( '-b', '-bweek day', String, 'B week schedule') do |name|
    name = name.downcase.capitalize
    set_days << B[name]
  end
end

raw_dates << DateTime.now if ARGV.empty?
optparse.parse!(ARGV)

def find_schedule( month, num, name )
  if month.eql? 'Sep'
    if num.between?(7, 16)
      A[name]
    elsif num.between?(19, 23)
      B[name]
    elsif num.between?(26, 30)
      A[name]
    end
  elsif month.eql? 'Oct'
    if num == 1
      A[name]
    elsif num.between?(3, 7)
      B[name]
    elsif num.between?(10, 14)
      A[name]
    elsif num.between?(17, 21)
      B[name]
    elsif num.between?(23, 28)
      A[name]
    else
      B[name]
    end
  elsif month.eql? 'Nov'
    if num.between?(1, 4)
      B[name]
    elsif num.between?(7, 11)
      A[name]
    elsif num.between?(14, 18)
      B[name]
    elsif num.between?(21, 25)
      A[name]
    else
      B[name]
    end
  elsif month.eql? 'Dec'
    if num.between?(1, 2)
      B[name]
    elsif num.between?(5, 9)
      A[name]
    elsif num.between?(12, 16)
      B[name]
    else
      show_christmas
    end
  elsif month.eql? 'Jan'
    if num.between?(3, 6)
      A[name]
    elsif num.between?(9, 13)
      B[name]
    elsif num.between?(16, 20)
      A[name]
    elsif num.between?(23, 27)
      B[name]
    else
      A[name]
    end
  elsif month.eql? 'Feb'
    if num.between?(1, 3)
      A[name]
    elsif num.between?(6, 10)
      B[name]
    elsif num.between?(13, 17)
      A[name]
    elsif num.between?(20, 24)
      B[name]
    else
      A[name]
    end
  elsif month.eql? 'Mar'
    if num.between?(1, 2)
      A[name]
    elsif num.between?(5, 9)
      B[name]
    elsif num.between?(12, 16)
      A[name]
    else
      vacation[:spring]
    end
  elsif month.eql? 'Apr'
    if num.between?(2, 6)
      B[name]
    elsif num.between?(9, 13)
      A[name]
    elsif num.between?(16, 20)
      B[name]
    elsif num.between(23, 27)
      A[name]
    else
      B[name]
    end
  elsif month.eql? 'May'
    if num.between?(1, 4)
      B[name]
    elsif num.between?(7, 11)
      A[name]
    elsif num.between?(14, 18)
      B[name]
    elsif num.between?(21, 25)
      A[name]
    else
      B[name]
    end
  end
end

raw_dates.each do |date|
  month, name = date.strftime('%b-%a').split('-')
  num = date.strftime('%d').to_i

  if name.eql? 'Sat' or name.eql? 'Sun'
    puts "Dude, it's the weekend. Chill out"
  else
    print find_schedule( month, num, name )
  end
end

set_days.each do |hash|
  print hash
end
