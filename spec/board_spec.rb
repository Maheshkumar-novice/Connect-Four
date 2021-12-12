#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  subject(:board) { described_class.new }
  let(:p1_marker) { :red }
  let(:p2_marker) { :blue }
  let(:half_board) do
    [
      ['', '', '', '', '', '', ''],
      ['', '', '', '', '', '', ''],
      ['', '', '', '', '', '', ''],
      [p1_marker, p2_marker, p1_marker, '', '', '', ''],
      [p2_marker, p1_marker, p2_marker, '', '', '', ''],
      [p1_marker, p2_marker, p2_marker, p1_marker, p2_marker, p1_marker, p2_marker]
    ]
  end
  let(:full_board) do
    [
      [p2_marker, p1_marker, p2_marker, p1_marker, p2_marker, p1_marker, p2_marker],
      [p1_marker, p2_marker, p1_marker, p2_marker, p1_marker, p1_marker, p1_marker],
      [p2_marker, p1_marker, p1_marker, p1_marker, p2_marker, p2_marker, p2_marker],
      [p1_marker, p2_marker, p2_marker, p1_marker, p1_marker, p1_marker, p1_marker],
      [p2_marker, p1_marker, p2_marker, p1_marker, p2_marker, p2_marker, p2_marker],
      [p1_marker, p2_marker, p1_marker, p2_marker, p2_marker, p1_marker, p1_marker]
    ]
  end

  describe '#game_over?' do
    context 'when win occurs' do
      it 'returns true' do
        allow(board).to receive(:win?).and_return(true)
        result = board.game_over?
        expect(result).to be true
      end
    end

    context 'when draw occurs' do
      it 'returns true' do
        allow(board).to receive(:win?).and_return(false)
        allow(board).to receive(:draw?).and_return(true)
        result = board.game_over?
        expect(result).to be true
      end
    end

    context 'when neither win nor draw occurs' do
      it 'returns false' do
        allow(board).to receive(:win?).and_return(false)
        allow(board).to receive(:draw?).and_return(false)
        result = board.game_over?
        expect(result).to be false
      end
    end
  end

  describe '#win?' do
    context 'when a row has connected four' do
      it 'returns true' do
        allow(board).to receive(:board_empty?).and_return(false)
        allow(board).to receive(:row_has_connected_four?).and_return(true)
        expect(board.win?).to be true
      end
    end

    context 'when a column has connected four' do
      it 'returns true' do
        allow(board).to receive(:board_empty?).and_return(false)
        allow(board).to receive(:row_has_connected_four?).and_return(false)
        allow(board).to receive(:column_has_connected_four?).and_return(true)
        expect(board.win?).to be true
      end
    end

    context 'when a diagonal has connected four' do
      xit 'returns true' do
        allow(board).to receive(:board_empty?).and_return(false)
        allow(board).to receive(:row_has_connected_four?).and_return(false)
        allow(board).to receive(:diagonal_has_connected_four?).and_return(true)
        expect(board.win?).to be true
      end
    end

    context 'when the board is empty' do
      it 'returns false' do
        allow(board).to receive(:board_empty?).and_return(true)
        expect(board.win?).to be false
      end
    end

    context 'when no connected four found' do
      it 'returns false' do
        allow(board).to receive(:row_has_connected_four?).and_return(false)
        allow(board).to receive(:column_has_connected_four?).and_return(false)
        allow(board).to receive(:diagonal_has_connected_four?).and_return(false)
        expect(board.win?).to be false
      end
    end
  end

  describe '#draw?' do
    context 'when the board is full' do
      it 'returns true' do
        allow(board).to receive(:board_full?).and_return(true)
        expect(board.draw?).to be true
      end
    end

    context 'when the board is empty' do
      it 'returns false' do
        allow(board).to receive(:board_full?).and_return(false)
        expect(board.draw?).to be false
      end
    end

    context 'when the board is neither empty nor full' do
      it 'returns false' do
        allow(board).to receive(:board_full?).and_return(false)
        expect(board.draw?).to be false
      end
    end
  end

  describe '#board_empty?' do
    context 'when the board is empty' do
      it 'returns true' do
        expect(board.board_empty?).to be true
      end
    end

    context 'when the board is full' do
      it 'returns false' do
        board.instance_variable_set(:@board, full_board)
        expect(board.board_empty?).to be false
      end
    end

    context 'when the board is neither empty nor full' do
      it 'returns false' do
        board.instance_variable_set(:@board, half_board)
        expect(board.board_empty?).to be false
      end
    end
  end

  describe '#board_full?' do
    context 'when the board is empty' do
      it 'returns false' do
        expect(board.board_full?).to be false
      end
    end

    context 'when the board is full' do
      it 'returns true' do
        board.instance_variable_set(:@board, full_board)
        expect(board.board_full?).to be true
      end
    end

    context 'when the board is neither empty nor full' do
      it 'returns false' do
        board.instance_variable_set(:@board, half_board)
        expect(board.board_full?).to be false
      end
    end
  end

  describe '#row_has_connected_four?' do
    context 'when top right row has connected four' do
      it 'returns true' do
        value = [
          ['', '', '', p1_marker, p1_marker, p1_marker, p1_marker],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '']

        ]
        board.instance_variable_set(:@board, value)
        board.instance_variable_set(:@last_changed_row, 0)
        board.instance_variable_set(:@last_changed_column, 3)
        expect(board.row_has_connected_four?).to be true
      end
    end

    context 'when top left row has connected four' do
      it 'returns true' do
        value = [
          [p1_marker, p1_marker, p1_marker, p1_marker, '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '']

        ]
        board.instance_variable_set(:@board, value)
        board.instance_variable_set(:@last_changed_row, 0)
        board.instance_variable_set(:@last_changed_column, 3)
        expect(board.row_has_connected_four?).to be true
      end
    end

    context 'when middle right row has connected four' do
      it 'returns true' do
        value = [
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', p1_marker, p1_marker, p1_marker, p1_marker],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '']

        ]
        board.instance_variable_set(:@board, value)
        board.instance_variable_set(:@last_changed_row, 2)
        board.instance_variable_set(:@last_changed_column, 3)
        expect(board.row_has_connected_four?).to be true
      end
    end

    context 'when middle left row has connected four' do
      it 'returns true' do
        value = [
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          [p1_marker, p1_marker, p1_marker, p1_marker, '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '']

        ]
        board.instance_variable_set(:@board, value)
        board.instance_variable_set(:@last_changed_row, 2)
        board.instance_variable_set(:@last_changed_column, 3)
        expect(board.row_has_connected_four?).to be true
      end
    end

    context 'when bottom right row has connected four' do
      it 'returns true' do
        value = [
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', p1_marker, p1_marker, p1_marker, p1_marker]

        ]
        board.instance_variable_set(:@board, value)
        board.instance_variable_set(:@last_changed_row, 5)
        board.instance_variable_set(:@last_changed_column, 3)
        expect(board.row_has_connected_four?).to be true
      end
    end

    context 'when bottom left row has connected four' do
      it 'returns true' do
        value = [
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          [p1_marker, p1_marker, p1_marker, p1_marker, '', '', '']

        ]
        board.instance_variable_set(:@board, value)
        board.instance_variable_set(:@last_changed_row, 5)
        board.instance_variable_set(:@last_changed_column, 3)
        expect(board.row_has_connected_four?).to be true
      end
    end

    context 'when no connected four found' do
      it 'returns false' do
        board.instance_variable_set(:@board, full_board)
        board.instance_variable_set(:@last_changed_row, 3)
        board.instance_variable_set(:@last_changed_column, 2)
        expect(board.row_has_connected_four?).to be false
      end
    end

    context 'when last changed column not met the condition (positive)' do
      it 'returns false' do
        board.instance_variable_set(:@board, full_board)
        board.instance_variable_set(:@last_changed_row, 3)
        board.instance_variable_set(:@last_changed_column, 5)
        expect(board.row_has_connected_four?).to be false
      end
    end

    context 'when last changed column not met the condition (negative)' do
      it 'returns false' do
        board.instance_variable_set(:@board, full_board)
        board.instance_variable_set(:@last_changed_row, 3)
        board.instance_variable_set(:@last_changed_column, 0)
        expect(board.row_has_connected_four?).to be false
      end
    end
  end

  describe '#column_has_connected_four?' do
    context 'when first column has connect four' do
      it 'returns true' do
        value = [
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          [p1_marker, '', '', '', '', '', ''],
          [p1_marker, '', '', '', '', '', ''],
          [p1_marker, '', '', '', '', '', ''],
          [p1_marker, '', '', '', '', '', '']

        ]
        board.instance_variable_set(:@board, value)
        board.instance_variable_set(:@last_changed_row, 2)
        board.instance_variable_set(:@last_changed_column, 0)
        expect(board.column_has_connected_four?).to be true
      end
    end

    context 'when last column has connect four' do
      it 'returns true' do
        value = [
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', p1_marker],
          ['', '', '', '', '', '', p1_marker],
          ['', '', '', '', '', '', p1_marker],
          ['', '', '', '', '', '', p1_marker]

        ]
        board.instance_variable_set(:@board, value)
        board.instance_variable_set(:@last_changed_row, 2)
        board.instance_variable_set(:@last_changed_column, 6)
        expect(board.column_has_connected_four?).to be true
      end
    end

    context 'when middle column has connect four' do
      it 'returns true' do
        value = [
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', p1_marker, '', '', ''],
          ['', '', '', p1_marker, '', '', ''],
          ['', '', '', p1_marker, '', '', ''],
          ['', '', '', p1_marker, '', '', '']

        ]
        board.instance_variable_set(:@board, value)
        board.instance_variable_set(:@last_changed_row, 2)
        board.instance_variable_set(:@last_changed_column, 3)
        expect(board.column_has_connected_four?).to be true
      end
    end

    context 'when no connected four found' do
      it 'returns false' do
        board.instance_variable_set(:@board, full_board)
        board.instance_variable_set(:@last_changed_row, 2)
        board.instance_variable_set(:@last_changed_column, 3)
        expect(board.column_has_connected_four?).to be false
      end
    end

    context 'when last changed row not met the condition' do
      it 'returns false' do
        board.instance_variable_set(:@last_changed_row, 5)
        expect(board.column_has_connected_four?).to be false
      end
    end
  end

  describe '#diagonal_has_connected_four?' do
    context 'when top right diagonal has connect four' do
      it 'returns true' do
        value = [
          ['', '', '', '', '', '', p1_marker],
          ['', '', '', '', '', p1_marker, ''],
          ['', '', '', '', p1_marker, '', ''],
          ['', '', '', p1_marker, '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '']

        ]
        board.instance_variable_set(:@board, value)
        board.instance_variable_set(:@last_changed_row, 3)
        board.instance_variable_set(:@last_changed_column, 6)
        expect(board.diagonal_has_connected_four?).to be true
      end
    end

    context 'when top left diagonal has connect four' do
      it 'returns true' do
        value = [
          [p1_marker, '', '', '', '', '', ''],
          ['', p1_marker, '', '', '', '', ''],
          ['', '', p1_marker, '', '', '', ''],
          ['', '', '', p1_marker, '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '']

        ]
        board.instance_variable_set(:@board, value)
        board.instance_variable_set(:@last_changed_row, 0)
        board.instance_variable_set(:@last_changed_column, 3)
        expect(board.diagonal_has_connected_four?).to be true
      end
    end

    context 'when bottom right diagonal has connect four' do
      it 'returns true' do
        value = [
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', p1_marker, '', '', ''],
          ['', '', '', '', p1_marker, '', ''],
          ['', '', '', '', '', p1_marker, ''],
          ['', '', '', '', '', '', p1_marker]

        ]
        board.instance_variable_set(:@board, value)
        board.instance_variable_set(:@last_changed_row, 5)
        board.instance_variable_set(:@last_changed_column, 6)
        expect(board.diagonal_has_connected_four?).to be true
      end
    end

    context 'when bottom left diagonal has connect four' do
      it 'returns true' do
        value = [
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', p1_marker, '', '', ''],
          ['', '', p1_marker, '', '', '', ''],
          ['', p1_marker, '', '', '', '', ''],
          [p1_marker, '', '', '', '', '', '']

        ]
        board.instance_variable_set(:@board, value)
        board.instance_variable_set(:@last_changed_row, 2)
        board.instance_variable_set(:@last_changed_column, 3)
        expect(board.diagonal_has_connected_four?).to be true
      end
    end

    context 'when no connect four found' do
      it 'returns false' do
        board.instance_variable_set(:@board, full_board)
        board.instance_variable_set(:@last_changed_row, 0)
        board.instance_variable_set(:@last_changed_column, 0)
        expect(board.row_has_connected_four?).to be false
      end
    end

    context 'when top right condition not met' do
      it 'returns false' do
        board.instance_variable_set(:@last_changed_row, 0)
        board.instance_variable_set(:@last_changed_column, 4)
        allow(board).to receive(:bottom_diagonal_connected_four?).and_return(false)
        allow(board).to receive(:top_left_diagonal_connected_four?).and_return(false)
        expect(board.diagonal_has_connected_four?).to be false
      end
    end

    context 'when top left condition not met' do
      it 'returns false' do
        board.instance_variable_set(:@last_changed_row, 0)
        board.instance_variable_set(:@last_changed_column, 0)
        allow(board).to receive(:bottom_diagonal_connected_four?).and_return(false)
        allow(board).to receive(:top_right_diagonal_connected_four?).and_return(false)
        expect(board.diagonal_has_connected_four?).to be false
      end
    end

    context 'when bottom right condition not met' do
      it 'returns false' do
        board.instance_variable_set(:@last_changed_row, 3)
        board.instance_variable_set(:@last_changed_column, 0)
        allow(board).to receive(:top_diagonal_connected_four?).and_return(false)
        allow(board).to receive(:bottom_left_diagonal_connected_four?).and_return(false)
        expect(board.diagonal_has_connected_four?).to be false
      end
    end

    context 'when bottom left condition not met' do
      it 'returns false' do
        board.instance_variable_set(:@last_changed_row, 3)
        board.instance_variable_set(:@last_changed_column, 4)
        allow(board).to receive(:top_diagonal_connected_four?).and_return(false)
        allow(board).to receive(:bottom_left_diagonal_connected_four?).and_return(false)
        expect(board.diagonal_has_connected_four?).to be false
      end
    end
  end
end
