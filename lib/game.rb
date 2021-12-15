#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './board'
require_relative './player'
require_relative './display'

# class game
class Game
  include Display

  def initialize(player1 = Player.new, player2 = Player.new, board = Board.new)
    @player1 = player1
    @player2 = player2
    @board = board
    @current_player, @other_player = [@player1, @player2].shuffle
    @markers = %w[red blue green yellow]
  end

  def play
    introduction
    rules
    update_player_data
    game_loop
    @board.print_board
    announce_result
  end

  def update_player_data
    update_player1_data
    remove_player1_marker_from_list
    update_player2_data
  end

  def remove_player1_marker_from_list
    @markers.delete(@player1.marker.to_s)
  end

  def update_player1_data
    player1_name_prompt
    @player1.name = create_player_name
    player1_marker_prompt
    @player1.marker = create_player_marker
  end

  def update_player2_data
    player2_name_prompt
    @player2.name = create_player_name
    player2_marker_prompt
    @player2.marker = create_player_marker
  end

  def create_player_name
    name = gets.chomp
    until @player1.valid_name?(name)
      print_invalid('name')
      print_prompt
      name = gets.chomp
    end
    name
  end

  def create_player_marker
    list_markers
    marker = gets.chomp
    until @markers.include?(marker.downcase)
      print_invalid('marker')
      print_prompt
      marker = gets.chomp
    end
    marker.downcase
  end

  def game_loop
    loop do
      print_current_player_data
      @board.print_board
      print_column_number_prompt
      @board.add_disc(move, @current_player.marker)
      break if @board.game_over?

      switch_players
    end
  end

  def move
    move = gets.chomp
    until @board.valid_move?(move)
      print_invalid('move')
      print_prompt
      move = gets.chomp
    end
    move.to_i
  end

  def switch_players
    @current_player, @other_player = @other_player, @current_player
  end

  def announce_result
    result = @board.result

    announce_winner(@current_player) if result == :win
    announce_draw if result == :draw
  end
end
