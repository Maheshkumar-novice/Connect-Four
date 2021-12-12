#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './board'
require_relative './player'

# class game
class Game
  def initialize
    @player1 = Player.new
    @player2 = Player.new
    @board = Board.new
    @current_player, @other_player = [@player1, @player2].shuffle
    @markers = [':red', ':blue', ':green', ':yellow']
  end
end
