#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './color'

# display module
module Display
  include Color

  def introduction
    puts <<~INTRO

      [0;1;35;95m┌─[0;1;31;91m──[0;1;33;93m──[0;1;32;92m──[0;1;36;96m──[0;1;34;94m──[0;1;35;95m──[0;1;31;91m──[0;1;33;93m──[0;1;32;92m──[0;1;36;96m──[0;1;34;94m──[0;1;35;95m──[0;1;31;91m──[0;1;33;93m──[0;1;32;92m──[0;1;36;96m──[0;1;34;94m──[0;1;35;95m──[0;1;31;91m──[0;1;33;93m──[0;1;32;92m──[0;1;36;96m──[0;1;34;94m──[0;1;35;95m─┐[0m
      [0;1;31;91m│░[0;1;33;93m█▀[0;1;32;92m▀░[0;1;36;96m█▀[0;1;34;94m█░[0;1;35;95m█▀[0;1;31;91m█░[0;1;33;93m█▀[0;1;32;92m█░[0;1;36;96m█▀[0;1;34;94m▀░[0;1;35;95m█▀[0;1;31;91m▀░[0;1;33;93m▀█[0;1;32;92m▀░[0;1;36;96m░░[0;1;34;94m░░[0;1;35;95m█▀[0;1;31;91m▀░[0;1;33;93m█▀[0;1;32;92m█░[0;1;36;96m█░[0;1;34;94m█░[0;1;35;95m█▀[0;1;31;91m▄│[0m
      [0;1;33;93m│░[0;1;32;92m█░[0;1;36;96m░░[0;1;34;94m█░[0;1;35;95m█░[0;1;31;91m█░[0;1;33;93m█░[0;1;32;92m█░[0;1;36;96m█░[0;1;34;94m█▀[0;1;35;95m▀░[0;1;31;91m█░[0;1;33;93m░░[0;1;32;92m░█[0;1;36;96m░░[0;1;34;94m▄▄[0;1;35;95m▄░[0;1;31;91m█▀[0;1;33;93m▀░[0;1;32;92m█░[0;1;36;96m█░[0;1;34;94m█░[0;1;35;95m█░[0;1;31;91m█▀[0;1;33;93m▄│[0m
      [0;1;32;92m│░[0;1;36;96m▀▀[0;1;34;94m▀░[0;1;35;95m▀▀[0;1;31;91m▀░[0;1;33;93m▀░[0;1;32;92m▀░[0;1;36;96m▀░[0;1;34;94m▀░[0;1;35;95m▀▀[0;1;31;91m▀░[0;1;33;93m▀▀[0;1;32;92m▀░[0;1;36;96m░▀[0;1;34;94m░░[0;1;35;95m░░[0;1;31;91m░░[0;1;33;93m▀░[0;1;32;92m░░[0;1;36;96m▀▀[0;1;34;94m▀░[0;1;35;95m▀▀[0;1;31;91m▀░[0;1;33;93m▀░[0;1;32;92m▀│[0m
      [0;1;36;96m└─[0;1;34;94m──[0;1;35;95m──[0;1;31;91m──[0;1;33;93m──[0;1;32;92m──[0;1;36;96m──[0;1;34;94m──[0;1;35;95m──[0;1;31;91m──[0;1;33;93m──[0;1;32;92m──[0;1;36;96m──[0;1;34;94m──[0;1;35;95m──[0;1;31;91m──[0;1;33;93m──[0;1;32;92m──[0;1;36;96m──[0;1;34;94m──[0;1;35;95m──[0;1;31;91m──[0;1;33;93m──[0;1;32;92m──[0;1;36;96m─┘[0m

    INTRO
  end

  def player1_name_prompt
    puts <<~NAME

      [0;1;35;95mEn[0;1;31;91mte[0;1;33;93mr[0m [0;1;32;92mpl[0;1;36;96may[0;1;34;94mer[0;1;35;95m1[0m [0;1;31;91mna[0;1;33;93mme[0m
    NAME
    print_prompt
  end

  def player2_name_prompt
    puts <<~NAME

      [0;1;35;95mEn[0;1;31;91mte[0;1;33;93mr[0m [0;1;32;92mpl[0;1;36;96may[0;1;34;94mer[0;1;35;95m2[0m [0;1;31;91mna[0;1;33;93mme[0m
    NAME
    print_prompt
  end

  def player1_marker_prompt
    puts <<~MARKER

      [0;1;35;95mSe[0;1;31;91mle[0;1;33;93mct[0m [0;1;32;92mp[0;1;36;96mla[0;1;34;94mye[0;1;35;95mr1[0m [0;1;31;91mm[0;1;33;93mar[0;1;32;92mke[0;1;36;96mr[0m
    MARKER
  end

  def player2_marker_prompt
    puts <<~MARKER

      [0;1;35;95mSe[0;1;31;91mle[0;1;33;93mct[0m [0;1;32;92mp[0;1;36;96mla[0;1;34;94mye[0;1;35;95mr2[0m [0;1;31;91mm[0;1;33;93mar[0;1;32;92mke[0;1;36;96mr[0m
    MARKER
  end

  def print_prompt
    print "\e[0;1;34;94m: \e[0m"
  end

  def print_invalid(string)
    puts color_text("Invalid #{string.capitalize}!\n", :red)
  end

  def print_current_player_data
    puts <<~PLAYER


      #{color_text(@current_player.name, :green)}(#{color_text(@current_player.marker, @current_player.marker.to_sym)})'s move

    PLAYER
  end

  def print_column_number_prompt
    puts 'Enter a Column number (0-6)'
  end

  def list_markers
    puts "\n#{@markers.map(&:to_sym).map { |color| color_text(color.to_s, color) }.join(' ')}\n\n"
    print_prompt
  end

  def circles_map(symbol)
    {
      red: "\u{1f534}",
      blue: "\u{1f535}",
      green: "\u{1f7e2}",
      yellow: "\u{1f7e2}",
      white: "\u{26aa}"
    }[symbol]
  end

  def print_board
    @board.each do |row|
      printable_row = row.map do |element|
        element = 'white' if element.empty?

        circles_map(element.to_sym)
      end
      print "\n#{printable_row.join(' ')}\n"
    end
  end
end
