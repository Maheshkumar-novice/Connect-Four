#!/usr/bin/env ruby
# frozen_string_literal: true

# board class
class Board
  attr_reader :board

  def initialize
    @board = Array.new(6) { Array.new(7, '') }
    @last_changed_column = nil
    @last_changed_row = nil
    @column_to_rows_mapping = Hash.new { |hash, key| hash[key] = (0..5).to_a }
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

  def row_has_connected_four?
    return false if board_empty?

    row_right_connected_four? || row_left_connected_four?
  end

  def row_right_connected_four?
    return false if @last_changed_column + 3 > 6

    values = [
      board[@last_changed_row][@last_changed_column],
      board[@last_changed_row][@last_changed_column + 1],
      board[@last_changed_row][@last_changed_column + 2],
      board[@last_changed_row][@last_changed_column + 3]
    ]
    values.all? { |value| value == values[0] }
  end

  def row_left_connected_four?
    return false if (@last_changed_column - 3).negative?

    values = [
      board[@last_changed_row][@last_changed_column],
      board[@last_changed_row][@last_changed_column - 1],
      board[@last_changed_row][@last_changed_column - 2],
      board[@last_changed_row][@last_changed_column - 3]
    ]
    values.all? { |value| value == values[0] }
  end

  def column_has_connected_four?; end

  def diagonal_has_connected_four?; end
end
