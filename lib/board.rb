#!/usr/bin/env ruby
# frozen_string_literal: true

# board class
class Board
  attr_reader :board, :last_moved_piece

  def initialize
    @board = Array.new(7) { Array.new(6, '') }
    @last_moved_piece = nil
  end

  def game_over?
    return true if win? || draw?

    false
  end

  def win?
    return false if board_empty?
    return true if row_has_connected_four? || column_has_connected_four? || diagonal_has_connected_four?

    false
  end

  def draw?
    return true if board_full?

    false
  end

  def board_full?; end

  def board_empty?; end

  def row_has_connected_four?; end

  def column_has_connected_four?; end

  def diagonal_has_connected_four?; end
end
