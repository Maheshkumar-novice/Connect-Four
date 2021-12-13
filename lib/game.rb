#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './board'
require_relative './player'

# class game
class Game
  def initialize(player1, player2, board)
    @player1 = player1
    @player2 = player2
    @board = board
    @current_player, @other_player = [@player1, @player2].shuffle
    @markers = [':red', ':blue', ':green', ':yellow']
  end

  def update_player_data
    update_player1_data
    update_player2_data
  end

  def update_player1_data
    @player1.name = create_player_name
    @player1.marker = create_player_marker
  end

  def update_player2_data
    @player2.name = create_player_name
    @player2.marker = create_player_marker
  end

  def create_player_name
    name = gets.chomp
    until @player1.valid_name?(name)
      puts 'Invalid Name!'
      print '> '
      name = gets.chomp
    end
    name
  end

  def create_player_marker
    list_markers
    marker = gets.chomp
    until @markers.include?(marker)
      puts 'Invalid Symbol!'
      print '> '
      marker = gets.chomp
    end
    marker
  end

  def list_markers
    pp @markers
  end
end
