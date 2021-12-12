#!/usr/bin/env ruby
# frozen_string_literal: true

# class player
class Player
  attr_accessor :name, :marker

  MAX_NAME_LENGTH = 15

  def initialize
    @name = nil
    @marker = nil
  end

  def valid_name?(name)
    name.match?(/^[\w+\s]{1,#{MAX_NAME_LENGTH}}$/)
  end
end
