#!/usr/bin/env ruby

require 'profile'
require 'securerandom'

10.times do |i|
  str = SecureRandom.hex(10)
  puts str.upcase
end
