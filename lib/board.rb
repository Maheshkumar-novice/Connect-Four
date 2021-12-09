#!/usr/bin/env ruby
# frozen_string_literal: true

# board class
class Board
  attr_reader :board, :last_moved_piece

  def initialize
    @board = Array.new(6) { Array.new(7, '') }
    @last_moved_piece = nil
  end

  def game_over?
    return true if win? || draw?

    false
  end

  def win?; end

  def draw?; end
end
