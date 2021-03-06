#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './color'

# Module for Display
module Display
  include Color

  def circles_map(symbol)
    {
      red: "\u{1f534}",
      blue: "\u{1f535}",
      green: "\u{1f7e2}",
      yellow: "\u{1f7e1}",
      white: "\u{26aa}"
    }[symbol]
  end

  def print_banner
    puts <<~INTRO

      [0;1;35;95mââ[0;1;31;91mââ[0;1;33;93mââ[0;1;32;92mââ[0;1;36;96mââ[0;1;34;94mââ[0;1;35;95mââ[0;1;31;91mââ[0;1;33;93mââ[0;1;32;92mââ[0;1;36;96mââ[0;1;34;94mââ[0;1;35;95mââ[0;1;31;91mââ[0;1;33;93mââ[0;1;32;92mââ[0;1;36;96mââ[0;1;34;94mââ[0;1;35;95mââ[0;1;31;91mââ[0;1;33;93mââ[0;1;32;92mââ[0;1;36;96mââ[0;1;34;94mââ[0;1;35;95mââ[0m
      [0;1;31;91mââ[0;1;33;93mââ[0;1;32;92mââ[0;1;36;96mââ[0;1;34;94mââ[0;1;35;95mââ[0;1;31;91mââ[0;1;33;93mââ[0;1;32;92mââ[0;1;36;96mââ[0;1;34;94mââ[0;1;35;95mââ[0;1;31;91mââ[0;1;33;93mââ[0;1;32;92mââ[0;1;36;96mââ[0;1;34;94mââ[0;1;35;95mââ[0;1;31;91mââ[0;1;33;93mââ[0;1;32;92mââ[0;1;36;96mââ[0;1;34;94mââ[0;1;35;95mââ[0;1;31;91mââ[0m
      [0;1;33;93mââ[0;1;32;92mââ[0;1;36;96mââ[0;1;34;94mââ[0;1;35;95mââ[0;1;31;91mââ[0;1;33;93mââ[0;1;32;92mââ[0;1;36;96mââ[0;1;34;94mââ[0;1;35;95mââ[0;1;31;91mââ[0;1;33;93mââ[0;1;32;92mââ[0;1;36;96mââ[0;1;34;94mââ[0;1;35;95mââ[0;1;31;91mââ[0;1;33;93mââ[0;1;32;92mââ[0;1;36;96mââ[0;1;34;94mââ[0;1;35;95mââ[0;1;31;91mââ[0;1;33;93mââ[0m
      [0;1;32;92mââ[0;1;36;96mââ[0;1;34;94mââ[0;1;35;95mââ[0;1;31;91mââ[0;1;33;93mââ[0;1;32;92mââ[0;1;36;96mââ[0;1;34;94mââ[0;1;35;95mââ[0;1;31;91mââ[0;1;33;93mââ[0;1;32;92mââ[0;1;36;96mââ[0;1;34;94mââ[0;1;35;95mââ[0;1;31;91mââ[0;1;33;93mââ[0;1;32;92mââ[0;1;36;96mââ[0;1;34;94mââ[0;1;35;95mââ[0;1;31;91mââ[0;1;33;93mââ[0;1;32;92mââ[0m
      [0;1;36;96mââ[0;1;34;94mââ[0;1;35;95mââ[0;1;31;91mââ[0;1;33;93mââ[0;1;32;92mââ[0;1;36;96mââ[0;1;34;94mââ[0;1;35;95mââ[0;1;31;91mââ[0;1;33;93mââ[0;1;32;92mââ[0;1;36;96mââ[0;1;34;94mââ[0;1;35;95mââ[0;1;31;91mââ[0;1;33;93mââ[0;1;32;92mââ[0;1;36;96mââ[0;1;34;94mââ[0;1;35;95mââ[0;1;31;91mââ[0;1;33;93mââ[0;1;32;92mââ[0;1;36;96mââ[0m

    INTRO
  end

  def print_rules
    puts <<~RULES

      [0;1;34;94m*[0m [0;1;34;94mTwo[0m [0;1;34;94mplayer[0m [0;1;34;94mga[0;34mme[0m
      [0;1;34;94m*[0m [0;1;34;94mChoose[0m [0;1;34;94ma[0m [0;1;34;94mcolum[0;34mn[0m [0;34mto[0m [0;34mput[0m [0;34ma[0m [0;34mdisc[0m
      [0;1;34;94m*[0m [0;1;34;94mIf[0m [0;1;34;94ma[0m [0;1;34;94mplayer[0m [0;1;34;94mge[0;34mts[0m [0;34ma[0m [0;34mconnected[0m [0;34mf[0;37mour,[0m [0;37mthey[0m [0;37mwins[0m
      [0;1;34;94m*[0m [0;1;34;94mConnected[0m [0;1;34;94mfour[0m [0;34mcan[0m [0;34mbe[0m [0;34min[0m [0;34mrows,[0m [0;37mcolumns[0m [0;37mor[0m [0;37mdiag[0;1;30;90monals[0m
      [0;1;34;94m*[0m [0;1;34;94mIf[0m [0;1;34;94mall[0m [0;1;34;94mcolumns[0m [0;34mget[0m [0;34mfilled,[0m [0;34mthe[0;37mn[0m [0;37mthe[0m [0;37mgame[0m [0;37mis[0m [0;37ma[0m [0;1;30;90mdraw[0m

    RULES
  end

  def player1_name_prompt
    puts <<~NAME

      [0;1;35;95mEn[0;1;31;91mte[0;1;33;93mr[0m [0;1;32;92mpl[0;1;36;96may[0;1;34;94mer[0;1;35;95m1[0m [0;1;31;91mna[0;1;33;93mme[0m [0;1;35;95m(M[0;1;31;91max[0;1;33;93m.[0m [0;1;32;92mle[0;1;36;96mng[0;1;34;94mth[0m [0;1;35;95m1[0;1;31;91m5)[0m
    NAME
    print_prompt
  end

  def player2_name_prompt
    puts <<~NAME

      [0;1;35;95mEn[0;1;31;91mte[0;1;33;93mr[0m [0;1;32;92mpl[0;1;36;96may[0;1;34;94mer[0;1;35;95m2[0m [0;1;31;91mna[0;1;33;93mme[0m [0;1;35;95m(M[0;1;31;91max[0;1;33;93m.[0m [0;1;32;92mle[0;1;36;96mng[0;1;34;94mth[0m [0;1;35;95m1[0;1;31;91m5)[0m
    NAME
    print_prompt
  end

  def list_markers
    puts <<~MARKERS
      #{@markers.map(&:to_sym).map { |color| color_text(color.to_s.capitalize, color) }.join(' ')}

    MARKERS
    print_prompt
  end

  def player1_marker_prompt
    puts <<~MARKER

      [0;1;35;95mSe[0;1;31;91mle[0;1;33;93mct[0m [0;1;32;92mp[0;1;36;96mla[0;1;34;94mye[0;1;35;95mr1[0m [0;1;31;91mm[0;1;33;93mar[0;1;32;92mke[0;1;36;96mr[0m [0;1;35;95m(E[0;1;31;91mnt[0;1;33;93mer[0m [0;1;32;92mO[0;1;36;96mne[0m [0;1;34;94mO[0;1;35;95mpt[0;1;31;91mio[0;1;33;93mn)[0m

    MARKER
  end

  def player2_marker_prompt
    puts <<~MARKER

      [0;1;35;95mSe[0;1;31;91mle[0;1;33;93mct[0m [0;1;32;92mp[0;1;36;96mla[0;1;34;94mye[0;1;35;95mr2[0m [0;1;31;91mm[0;1;33;93mar[0;1;32;92mke[0;1;36;96mr[0m [0;1;35;95m(E[0;1;31;91mnt[0;1;33;93mer[0m [0;1;32;92mO[0;1;36;96mne[0m [0;1;34;94mO[0;1;35;95mpt[0;1;31;91mio[0;1;33;93mn)[0m

    MARKER
  end

  def print_column_number_prompt
    puts <<~COLUMN

      [0;1;35;95mEn[0;1;31;91mte[0;1;33;93mr[0m [0;1;32;92ma[0m [0;1;36;96mCo[0;1;34;94mlu[0;1;35;95mmn[0m [0;1;31;91mn[0;1;33;93mum[0;1;32;92mbe[0;1;36;96mr[0m [0;1;34;94m(1[0;1;35;95m-7[0;1;31;91m)[0m
    COLUMN
    print_prompt
  end

  def print_prompt
    print "\e[0;1;34;94m: \e[0m"
  end

  def print_current_player_data
    puts <<~PLAYER


      #{color_text(@current_player.name, :green)}(#{color_text(@current_player.marker.capitalize, @current_player.marker.to_sym)})'s move:

    PLAYER
  end

  def print_board
    @board.each do |row|
      printable_row = row.map do |element|
        element = 'white' if element.empty?

        circles_map(element.to_sym)
      end
      print <<~ROW
        #{printable_row.join(' ')}
      ROW
    end
  end

  def print_invalid(string)
    puts color_text("Invalid #{string.capitalize}!\n", :red)
  end

  def print_loop_data
    clear_screen
    print_banner
    print_current_player_data
    @board.print_board
    print_column_number_prompt
  end

  def print_thanks
    puts <<~THANKS

      [0;1;35;95mTh[0;1;31;91man[0;1;33;93mks[0m [0;1;32;92mf[0;1;36;96mor[0m [0;1;34;94mp[0;1;35;95mla[0;1;31;91myi[0;1;33;93mng[0m [0;1;32;92m:[0;1;36;96m).[0;1;34;94m..[0;1;35;95m..[0;1;31;91m![0m

    THANKS
  end

  def announce_winner(player)
    puts <<~WINNER

      #{color_text(player.name.to_s, :green)} #{color_text("(#{player.marker})", player.marker)} #{color_text('Won!', :green)}
    WINNER
  end

  def announce_draw
    puts <<~DRAW

      #{color_text("It's a Draw!", :yellow)}
    DRAW
  end

  def prepare_screen_for_result
    clear_screen
    print_banner
    @board.print_board
  end

  def clear_screen
    system('clear')
  end
end
