#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './game'

loop do
  Game.new.play

  puts 'Do you want play again? (y)'
  choice = gets.chomp
  break unless choice.downcase == 'y'

  system('clear')
end
