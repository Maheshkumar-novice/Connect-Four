#!/usr/bin/env ruby
# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize, Metrics/ClassLength
# board class
class Board
  attr_reader :board

  def initialize
    @board = Array.new(6) { Array.new(7, '') }
    @last_changed_column = nil
    @last_changed_row = nil
    @column_to_rows_mapping = Hash.new { |hash, key| hash[key] = (0..5).to_a }
  end

  def add_disc(column, disc)
    return if @column_to_rows_mapping[column].empty?

    @last_changed_row = @column_to_rows_mapping[column].pop
    @last_changed_column = column
    board[@last_changed_row][column] = disc
  end

  def valid_move?(move)
    move.match?(/^[0-6]{1}$/)
  end

  def result
    return :win if win?
    return :draw if draw?
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

  def row_has_connected_four?
    row_right_connected_four? || row_left_connected_four?
  end

  def column_has_connected_four?
    return false if @last_changed_row + 3 > 5

    values = [
      board[@last_changed_row][@last_changed_column],
      board[@last_changed_row + 1][@last_changed_column],
      board[@last_changed_row + 2][@last_changed_column],
      board[@last_changed_row + 3][@last_changed_column]
    ]
    values.all? { |value| value == values[0] }
  end

  def diagonal_has_connected_four?
    top_diagonal_connected_four? || bottom_diagonal_connected_four?
  end

  def board_empty?
    board.flatten.all?(&:empty?)
  end

  def board_full?
    board.flatten.none?(&:empty?)
  end

  private

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

  def top_diagonal_connected_four?
    top_right_diagonal_connected_four? || top_left_diagonal_connected_four?
  end

  def top_right_diagonal_connected_four?
    return false if (@last_changed_row - 3).negative? || (@last_changed_column + 3) > 6

    values = [
      board[@last_changed_row][@last_changed_column],
      board[@last_changed_row - 1][@last_changed_column + 1],
      board[@last_changed_row - 2][@last_changed_column + 2],
      board[@last_changed_row - 3][@last_changed_column + 3]
    ]
    values.all? { |value| value == values[0] }
  end

  def top_left_diagonal_connected_four?
    return false if (@last_changed_row - 3).negative? || (@last_changed_column - 3).negative?

    values = [
      board[@last_changed_row][@last_changed_column],
      board[@last_changed_row - 1][@last_changed_column - 1],
      board[@last_changed_row - 2][@last_changed_column - 2],
      board[@last_changed_row - 3][@last_changed_column - 3]
    ]
    values.all? { |value| value == values[0] }
  end

  def bottom_diagonal_connected_four?
    bottom_right_diagonal_connected_four? || bottom_left_diagonal_connected_four?
  end

  def bottom_right_diagonal_connected_four?
    return false if (@last_changed_row + 3) > 5 || (@last_changed_column + 3) > 6

    values = [
      board[@last_changed_row][@last_changed_column],
      board[@last_changed_row + 1][@last_changed_column + 1],
      board[@last_changed_row + 2][@last_changed_column + 2],
      board[@last_changed_row + 3][@last_changed_column + 3]
    ]
    values.all? { |value| value == values[0] }
  end

  def bottom_left_diagonal_connected_four?
    return false if (@last_changed_row + 3) > 5 || (@last_changed_column - 3).negative?

    values = [
      board[@last_changed_row][@last_changed_column],
      board[@last_changed_row + 1][@last_changed_column - 1],
      board[@last_changed_row + 2][@last_changed_column - 2],
      board[@last_changed_row + 3][@last_changed_column - 3]
    ]
    values.all? { |value| value == values[0] }
  end
end
# rubocop:enable Metrics/AbcSize, Metrics/ClassLength
