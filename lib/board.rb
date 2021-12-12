#!/usr/bin/env ruby
# frozen_string_literal: true

# board class
class Board
  attr_reader :board

  def initialize
    @board = Array.new(7) { Array.new(6, '') }
  end

  def game_over?
    win? || draw?
  end

  def win?
    return false if board_empty?

    row_has_connected_four? || column_has_connected_four? || diagonal_has_connected_four?
  end

  def draw?
    board_full?
  end

  def board_empty?
    board.flatten.all?(&:empty?)
  end

  def board_full?
    board.flatten.none?(&:empty?)
  end

  def row_has_connected_four?; end

  def column_has_connected_four?; end

  def diagonal_has_connected_four?; end
end
