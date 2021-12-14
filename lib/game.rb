#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './board'
require_relative './player'

# class game
class Game
  def initialize(player1 = Player.new, player2 = Player.new, board = Board.new)
    @player1 = player1
    @player2 = player2
    @board = board
    @current_player, @other_player = [@player1, @player2].shuffle
    @markers = [':red', ':blue', ':green', ':yellow']
  end

  def play
    introduction
    update_player_data
    game_loop
    @board.print_board
    announce_result
  end

  def game_loop
    loop do
      current_player_data
      @board.print_board
      @board.add_disc(move, @current_player.marker)
      break if @board.game_over?

      switch_players
    end
  end

  def switch_players
    @current_player, @other_player = @other_player, @current_player
  end

  def move
    move = gets.chomp
    until @board.valid_move?(move)
      puts 'Invalid Move!'
      print '> '
      move = gets.chomp
    end
    move.to_i
  end

  def introduction
    puts <<~INTRO
      Connect Four!
    INTRO
  end

  def current_player_data
    puts @current_player.name.to_s
    puts @current_player.marker.to_s
  end

  def announce_result
    puts @board.result.to_s
  end

  def update_player_data
    update_player1_data
    @markers.delete(@player1.marker.to_s)
    update_player2_data
  end

  def update_player1_data
    puts 'Enter Name > '
    @player1.name = create_player_name
    puts 'Enter Marker > '
    @player1.marker = create_player_marker
  end

  def update_player2_data
    puts 'Enter Name > '
    @player2.name = create_player_name
    puts 'Enter Marker > '
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
