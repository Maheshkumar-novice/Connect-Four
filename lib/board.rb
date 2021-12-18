#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './display'

# Connect Four Board
class Board
  include Display

  attr_reader :board

  def initialize
    @rows = 6
    @columns = 7
    @board = Array.new(@rows) { Array.new(@columns, '') }
    @last_changed_column = nil
    @last_changed_row = nil
    @column_to_rows_mapping = Hash.new { |hash, key| hash[key] = (0..(@rows - 1)).to_a }
  end

  def add_disc(move, disc)
    column = move - 1
    return if @column_to_rows_mapping[column].empty?

    @last_changed_row = @column_to_rows_mapping[column].pop
    @last_changed_column = column
    board[@last_changed_row][column] = disc
  end

  def valid_move?(move)
    move.match?(/^[1-7]{1}$/) && !@column_to_rows_mapping[move.to_i - 1].empty?
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
    row_right_has_connected_four? || row_middle_has_connected_four? || row_left_has_connected_four?
  end

  def column_has_connected_four?
    return false unless row_satisfies_boundary_conditions?(@last_changed_row + 3)

    all_values_are_same?([0, 0], [1, 0], [2, 0], [3, 0])
  end

  def diagonal_has_connected_four?
    top_diagonal_has_connected_four? || bottom_diagonal_has_connected_four?
  end

  def board_empty?
    board.flatten.all?(&:empty?)
  end

  def board_full?
    board.flatten.none?(&:empty?)
  end

  def result
    return :win if win?
    return :draw if draw?
  end

  private

  def all_values_are_same?(*args)
    value_to_compare = @board[@last_changed_row][@last_changed_column]
    args.each do |row_change, column_change|
      value = @board[@last_changed_row + row_change][@last_changed_column + column_change]
      return false unless value_to_compare == value
    end
    true
  end

  def row_satisfies_boundary_conditions?(*args)
    args.all? { |value| value >= 0 && value <= (@rows - 1) }
  end

  def column_satisfies_boundary_conditions?(*args)
    args.all? { |value| value >= 0 && value <= (@columns - 1) }
  end

  def row_right_has_connected_four?
    return false unless column_satisfies_boundary_conditions?(@last_changed_column + 3)

    all_values_are_same?([0, 0], [0, 1], [0, 2], [0, 3])
  end

  def row_left_has_connected_four?
    return false unless column_satisfies_boundary_conditions?(@last_changed_column - 3)

    all_values_are_same?([0, 0], [0, -1], [0, -2], [0, -3])
  end

  def row_middle_has_connected_four?
    row_middle_right_has_connected_four? || row_middle_left_has_connected_four?
  end

  def row_middle_right_has_connected_four?
    return false unless column_satisfies_boundary_conditions?(@last_changed_column + 2, @last_changed_column - 1)

    all_values_are_same?([0, -1], [0, 0], [0, 1], [0, 2])
  end

  def row_middle_left_has_connected_four?
    return false unless column_satisfies_boundary_conditions?(@last_changed_column - 2, @last_changed_column + 1)

    all_values_are_same?([0, -2], [0, -1], [0, 0], [0, 1])
  end

  def top_diagonal_has_connected_four?
    top_right_diagonal_has_connected_four? || top_left_diagonal_has_connected_four? || top_middle_diagonal_has_connected_four?
  end

  def top_right_diagonal_has_connected_four?
    return false unless row_satisfies_boundary_conditions?(@last_changed_row - 3)
    return false unless column_satisfies_boundary_conditions?(@last_changed_column + 3)

    all_values_are_same?([0, 0], [-1, 1], [-2, 2], [-3, 3])
  end

  def top_left_diagonal_has_connected_four?
    return false unless row_satisfies_boundary_conditions?(@last_changed_row - 3)
    return false unless column_satisfies_boundary_conditions?(@last_changed_column - 3)

    all_values_are_same?([0, 0], [-1, -1], [-2, -2], [-3, -3])
  end

  def top_middle_diagonal_has_connected_four?
    top_right_middle_diagonal_has_connected_four? || top_left_middle_diagonal_has_connected_four?
  end

  def top_right_middle_diagonal_has_connected_four?
    top_right_middle_right_has_connected_four? || top_right_middle_left_has_connected_four?
  end

  def top_right_middle_right_has_connected_four?
    return false unless row_satisfies_boundary_conditions?(@last_changed_row - 2, @last_changed_row + 1)
    return false unless column_satisfies_boundary_conditions?(@last_changed_column + 2, @last_changed_column - 1)

    all_values_are_same?([1, -1], [0, 0], [-1, 1], [-2, 2])
  end

  def top_right_middle_left_has_connected_four?
    return false unless row_satisfies_boundary_conditions?(@last_changed_row - 1, @last_changed_row + 2)
    return false unless column_satisfies_boundary_conditions?(@last_changed_column + 1, @last_changed_column - 2)

    all_values_are_same?([2, -2], [1, -1], [0, 0], [-1, 1])
  end

  def top_left_middle_diagonal_has_connected_four?
    top_left_middle_right_has_connected_four? || top_left_middle_left_has_connected_four?
  end

  def top_left_middle_right_has_connected_four?
    return false unless row_satisfies_boundary_conditions?(@last_changed_row - 2, @last_changed_row + 1)
    return false unless column_satisfies_boundary_conditions?(@last_changed_column - 2, @last_changed_column + 1)

    all_values_are_same?([1, 1], [0, 0], [-1, -1], [-2, -2])
  end

  def top_left_middle_left_has_connected_four?
    return false unless row_satisfies_boundary_conditions?(@last_changed_row - 1, @last_changed_row + 2)
    return false unless column_satisfies_boundary_conditions?(@last_changed_column - 1, @last_changed_column + 2)

    all_values_are_same?([1, 1], [2, 2], [0, 0], [-1, -1])
  end

  def bottom_diagonal_has_connected_four?
    bottom_right_diagonal_has_connected_four? || bottom_left_diagonal_has_connected_four? || bottom_middle_diagonal_has_connected_four?
  end

  def bottom_right_diagonal_has_connected_four?
    return false unless row_satisfies_boundary_conditions?(@last_changed_row + 3)
    return false unless column_satisfies_boundary_conditions?(@last_changed_column + 3)

    all_values_are_same?([0, 0], [1, 1], [2, 2], [3, 3])
  end

  def bottom_left_diagonal_has_connected_four?
    return false unless row_satisfies_boundary_conditions?(@last_changed_row + 3)
    return false unless column_satisfies_boundary_conditions?(@last_changed_column - 3)

    all_values_are_same?([0, 0], [1, -1], [2, -2], [3, -3])
  end

  def bottom_middle_diagonal_has_connected_four?
    bottom_right_middle_diagonal_has_connected_four? || bottom_left_middle_diagonal_has_connected_four?
  end

  def bottom_right_middle_diagonal_has_connected_four?
    bottom_right_middle_right_has_connected_four? || bottom_right_middle_left_has_connected_four?
  end

  def bottom_right_middle_right_has_connected_four?
    return false unless row_satisfies_boundary_conditions?(@last_changed_row + 1, @last_changed_row - 2)
    return false unless column_satisfies_boundary_conditions?(@last_changed_column + 1, @last_changed_column - 2)

    all_values_are_same?([1, 1], [0, 0], [-1, -1], [-2, -2])
  end

  def bottom_right_middle_left_has_connected_four?
    return false unless row_satisfies_boundary_conditions?(@last_changed_row + 2, @last_changed_row - 1)
    return false unless column_satisfies_boundary_conditions?(@last_changed_column + 2, @last_changed_column - 1)

    all_values_are_same?([2, 2], [1, 1], [0, 0], [-1, -1])
  end

  def bottom_left_middle_diagonal_has_connected_four?
    bottom_left_middle_right_has_connected_four? || bottom_left_middle_left_has_connected_four?
  end

  def bottom_left_middle_right_has_connected_four?
    return false unless row_satisfies_boundary_conditions?(@last_changed_row + 1, @last_changed_row - 2)
    return false unless column_satisfies_boundary_conditions?(@last_changed_column - 1, @last_changed_column + 2)

    all_values_are_same?([1, -1], [0, 0], [-1, 1], [-2, 2])
  end

  def bottom_left_middle_left_has_connected_four?
    return false unless row_satisfies_boundary_conditions?(@last_changed_row + 2, @last_changed_row - 1)
    return false unless column_satisfies_boundary_conditions?(@last_changed_column - 2, @last_changed_column + 1)

    all_values_are_same?([1, -1], [2, -2], [0, 0], [-1, 1])
  end
end
