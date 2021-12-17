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
      [p2_marker, p2_marker, p2_marker, p1_marker, p1_marker, p1_marker, p2_marker],
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
      it 'returns true' do
        allow(board).to receive(:board_empty?).and_return(false)
        allow(board).to receive(:row_has_connected_four?).and_return(false)
        allow(board).to receive(:column_has_connected_four?).and_return(false)
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
        board_state = [
          ['', '', '', p1_marker, p1_marker, p1_marker, p1_marker],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '']
        ]
        board.instance_variable_set(:@board, board_state)
        board.instance_variable_set(:@last_changed_row, 0)
        board.instance_variable_set(:@last_changed_column, 3)
        expect(board.row_has_connected_four?).to be true
      end
    end

    context 'when top left row has connected four' do
      it 'returns true' do
        board_state = [
          [p1_marker, p1_marker, p1_marker, p1_marker, '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '']
        ]
        board.instance_variable_set(:@board, board_state)
        board.instance_variable_set(:@last_changed_row, 0)
        board.instance_variable_set(:@last_changed_column, 3)
        expect(board.row_has_connected_four?).to be true
      end
    end

    context 'when middle right row has connected four' do
      it 'returns true' do
        board_state = [
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', p1_marker, p1_marker, p1_marker, p1_marker],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '']
        ]
        board.instance_variable_set(:@board, board_state)
        board.instance_variable_set(:@last_changed_row, 2)
        board.instance_variable_set(:@last_changed_column, 3)
        expect(board.row_has_connected_four?).to be true
      end
    end

    context 'when middle left row has connected four' do
      it 'returns true' do
        board_state = [
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          [p1_marker, p1_marker, p1_marker, p1_marker, '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '']
        ]
        board.instance_variable_set(:@board, board_state)
        board.instance_variable_set(:@last_changed_row, 2)
        board.instance_variable_set(:@last_changed_column, 3)
        expect(board.row_has_connected_four?).to be true
      end
    end

    context 'when bottom right row has connected four' do
      it 'returns true' do
        board_state = [
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', p1_marker, p1_marker, p1_marker, p1_marker]
        ]
        board.instance_variable_set(:@board, board_state)
        board.instance_variable_set(:@last_changed_row, 5)
        board.instance_variable_set(:@last_changed_column, 3)
        expect(board.row_has_connected_four?).to be true
      end
    end

    context 'when bottom left row has connected four' do
      it 'returns true' do
        board_state = [
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          [p1_marker, p1_marker, p1_marker, p1_marker, '', '', '']
        ]
        board.instance_variable_set(:@board, board_state)
        board.instance_variable_set(:@last_changed_row, 5)
        board.instance_variable_set(:@last_changed_column, 3)
        expect(board.row_has_connected_four?).to be true
      end
    end

    context 'when last changed column is in the middle of a connected row' do
      it 'returns true' do
        board_state = [
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          [p1_marker, p1_marker, p1_marker, p1_marker, '', '', '']
        ]
        board.instance_variable_set(:@board, board_state)
        board.instance_variable_set(:@last_changed_row, 5)
        board.instance_variable_set(:@last_changed_column, 1)
        expect(board.row_has_connected_four?).to be true
      end

      it 'returns true' do
        board_state = [
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          [p1_marker, p1_marker, p1_marker, p1_marker, '', '', '']
        ]
        board.instance_variable_set(:@board, board_state)
        board.instance_variable_set(:@last_changed_row, 5)
        board.instance_variable_set(:@last_changed_column, 2)
        expect(board.row_has_connected_four?).to be true
      end
    end

    context 'when no connected four found' do
      it 'returns false' do
        board_state = [
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          [p1_marker, '', p1_marker, p1_marker, '', '', '']
        ]
        board.instance_variable_set(:@board, board_state)
        board.instance_variable_set(:@last_changed_row, 5)
        board.instance_variable_set(:@last_changed_column, 4)
        expect(board.row_has_connected_four?).to be false
      end
    end
  end

  describe '#column_has_connected_four?' do
    context 'when first column has connect four' do
      it 'returns true' do
        board_state = [
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          [p1_marker, '', '', '', '', '', ''],
          [p1_marker, '', '', '', '', '', ''],
          [p1_marker, '', '', '', '', '', ''],
          [p1_marker, '', '', '', '', '', '']
        ]
        board.instance_variable_set(:@board, board_state)
        board.instance_variable_set(:@last_changed_row, 2)
        board.instance_variable_set(:@last_changed_column, 0)
        expect(board.column_has_connected_four?).to be true
      end
    end

    context 'when last column has connect four' do
      it 'returns true' do
        board_state = [
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', p1_marker],
          ['', '', '', '', '', '', p1_marker],
          ['', '', '', '', '', '', p1_marker],
          ['', '', '', '', '', '', p1_marker]
        ]
        board.instance_variable_set(:@board, board_state)
        board.instance_variable_set(:@last_changed_row, 2)
        board.instance_variable_set(:@last_changed_column, 6)
        expect(board.column_has_connected_four?).to be true
      end
    end

    context 'when middle column has connect four' do
      it 'returns true' do
        board_state = [
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', p1_marker, '', '', ''],
          ['', '', '', p1_marker, '', '', ''],
          ['', '', '', p1_marker, '', '', ''],
          ['', '', '', p1_marker, '', '', '']
        ]
        board.instance_variable_set(:@board, board_state)
        board.instance_variable_set(:@last_changed_row, 2)
        board.instance_variable_set(:@last_changed_column, 3)
        expect(board.column_has_connected_four?).to be true
      end
    end

    context 'when no connected four found' do
      it 'returns false' do
        board_state = [
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          [p1_marker, '', '', '', '', '', ''],
          [p1_marker, '', '', '', '', '', ''],
          [p1_marker, '', '', '', '', '', '']
        ]
        board.instance_variable_set(:@board, board_state)
        board.instance_variable_set(:@last_changed_row, 3)
        board.instance_variable_set(:@last_changed_column, 0)
        expect(board.column_has_connected_four?).to be false
      end
    end
  end

  describe '#diagonal_has_connected_four?' do
    context 'when top right diagonal has connect four' do
      let(:board_state) do
        [
          ['', '', '', '', '', '', p1_marker],
          ['', '', '', '', '', p1_marker, ''],
          ['', '', '', '', p1_marker, '', ''],
          ['', '', '', p1_marker, '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '']
        ]
      end

      before do
        board.instance_variable_set(:@board, board_state)
      end

      it 'returns true' do
        board.instance_variable_set(:@last_changed_row, 3)
        board.instance_variable_set(:@last_changed_column, 6)
        expect(board.diagonal_has_connected_four?).to be true
      end

      context 'when last changed column is in the middle of the top right diagonal' do
        it 'returns true' do
          board.instance_variable_set(:@last_changed_row, 2)
          board.instance_variable_set(:@last_changed_column, 4)
          expect(board.diagonal_has_connected_four?).to be true
        end

        it 'returns true' do
          board.instance_variable_set(:@last_changed_row, 0)
          board.instance_variable_set(:@last_changed_column, 4)
          expect(board.diagonal_has_connected_four?).to be true
        end
      end
    end

    context 'when top left diagonal has connect four' do
      let(:board_state) do
        [
          [p1_marker, '', '', '', '', '', ''],
          ['', p1_marker, '', '', '', '', ''],
          ['', '', p1_marker, '', '', '', ''],
          ['', '', '', p1_marker, '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '']
        ]
      end

      before do
        board.instance_variable_set(:@board, board_state)
      end

      it 'returns true' do
        board.instance_variable_set(:@last_changed_row, 0)
        board.instance_variable_set(:@last_changed_column, 3)
        expect(board.diagonal_has_connected_four?).to be true
      end

      context 'when last changed column is in the middle of the top left diagonal' do
        it 'returns true' do
          board.instance_variable_set(:@last_changed_row, 1)
          board.instance_variable_set(:@last_changed_column, 2)
          expect(board.diagonal_has_connected_four?).to be true
        end

        it 'returns true' do
          board.instance_variable_set(:@last_changed_row, 2)
          board.instance_variable_set(:@last_changed_column, 3)
          expect(board.diagonal_has_connected_four?).to be true
        end
      end
    end

    context 'when bottom right diagonal has connect four' do
      let(:board_state) do
        [
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', p1_marker, '', '', ''],
          ['', '', '', '', p1_marker, '', ''],
          ['', '', '', '', '', p1_marker, ''],
          ['', '', '', '', '', '', p1_marker]
        ]
      end

      before do
        board.instance_variable_set(:@board, board_state)
      end

      it 'returns true' do
        board.instance_variable_set(:@last_changed_row, 5)
        board.instance_variable_set(:@last_changed_column, 6)
        expect(board.diagonal_has_connected_four?).to be true
      end

      context 'when last changed column is in the middle of the bottom right diagonal' do
        it 'returns true' do
          board.instance_variable_set(:@last_changed_row, 4)
          board.instance_variable_set(:@last_changed_column, 5)
          expect(board.diagonal_has_connected_four?).to be true
        end

        it 'returns true' do
          board.instance_variable_set(:@last_changed_row, 3)
          board.instance_variable_set(:@last_changed_column, 4)
          expect(board.diagonal_has_connected_four?).to be true
        end
      end
    end

    context 'when bottom left diagonal has connect four' do
      let(:board_state) do
        [
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', p1_marker, '', '', ''],
          ['', '', p1_marker, '', '', '', ''],
          ['', p1_marker, '', '', '', '', ''],
          [p1_marker, '', '', '', '', '', '']
        ]
      end

      before do
        board.instance_variable_set(:@board, board_state)
      end

      it 'returns true' do
        board.instance_variable_set(:@last_changed_row, 2)
        board.instance_variable_set(:@last_changed_column, 3)
        expect(board.diagonal_has_connected_four?).to be true
      end

      context 'when last changed column is in the middle of the bottom left diagonal' do
        it 'returns true' do
          board.instance_variable_set(:@last_changed_row, 4)
          board.instance_variable_set(:@last_changed_column, 1)
          expect(board.diagonal_has_connected_four?).to be true
        end

        it 'returns true' do
          board.instance_variable_set(:@last_changed_row, 3)
          board.instance_variable_set(:@last_changed_column, 2)
          expect(board.diagonal_has_connected_four?).to be true
        end
      end
    end

    context 'when no connect four found' do
      it 'returns false' do
        value = [
          [p1_marker, '', '', '', '', '', ''],
          ['', p1_marker, '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', p1_marker, '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', '']
        ]
        board.instance_variable_set(:@board, value)
        board.instance_variable_set(:@last_changed_row, 0)
        board.instance_variable_set(:@last_changed_column, 0)
        expect(board.diagonal_has_connected_four?).to be false
      end
    end
  end

  describe '#add_disc' do
    context 'when adding to an empty column' do
      it 'adds the disc to the column' do
        move = 1
        column = move - 1
        disc = p1_marker
        board.add_disc(move, disc)
        row = board.instance_variable_get(:@last_changed_row)
        expect(board.board[row][column]).to eq(disc)
      end
    end

    context 'when adding to a partially filled column' do
      it 'adds the disc to the column' do
        move = 7
        column = move - 1
        disc = p1_marker
        board_state = [
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', ''],
          ['', '', '', '', '', '', p1_marker],
          ['', '', '', '', '', '', p1_marker],
          ['', '', '', '', '', '', p1_marker],
          ['', '', '', '', '', '', p1_marker]
        ]
        board.instance_variable_set(:@board, board_state)
        map = board.instance_variable_get(:@column_to_rows_mapping)
        map[column] = [0, 1]
        board.instance_variable_set(:@column_to_rows_mapping, map)
        board.add_disc(move, disc)
        row = board.instance_variable_get(:@last_changed_row)
        expect(board.board[row][column]).to eq(disc)
      end
    end

    context 'when adding to an already filled column' do
      it 'column stays unchanged' do
        move = 7
        column = move - 1
        disc = p1_marker
        board_state = [
          ['', '', '', '', '', '', p2_marker],
          ['', '', '', '', '', '', p1_marker],
          ['', '', '', '', '', '', p1_marker],
          ['', '', '', '', '', '', p1_marker],
          ['', '', '', '', '', '', p1_marker],
          ['', '', '', '', '', '', p1_marker]
        ]
        board.instance_variable_set(:@board, board_state)
        map = board.instance_variable_get(:@column_to_rows_mapping)
        map[column] = []
        board.instance_variable_set(:@column_to_rows_mapping, map)
        board.add_disc(move, disc)
        row = 0
        expect(board.board[row][column]).to eq(p2_marker)
      end
    end
  end

  describe '#valid_move?' do
    context 'when the move is a string of length more than 1' do
      it 'returns false' do
        move = '1s'
        expect(board.valid_move?(move)).to be false
      end
    end

    context 'when the move is an out of bound value' do
      it 'returns false' do
        move = '8'
        expect(board.valid_move?(move)).to be false
      end
    end

    context 'when the move is a valid value' do
      it 'returns true' do
        move = '1'
        expect(board.valid_move?(move)).to be true
      end
    end

    context 'when the column is full' do
      it 'returns false' do
        move = '1'
        map = board.instance_variable_get(:@column_to_rows_mapping)
        map[0] = []
        board.instance_variable_set(:@column_to_rows_mapping, map)
        expect(board.valid_move?(move)).to be false
      end
    end
  end

  describe '#result' do
    context 'when a win occurs' do
      it 'returns :win' do
        allow(board).to receive(:win?).and_return(true)
        expect(board.result).to eq(:win)
      end
    end

    context 'when a draw occurs' do
      it 'returns :draw' do
        allow(board).to receive(:win?).and_return(false)
        allow(board).to receive(:draw?).and_return(true)
        expect(board.result).to eq(:draw)
      end
    end

    context 'when neither win nor draw occurs' do
      it 'returns nil' do
        allow(board).to receive(:win?).and_return(false)
        allow(board).to receive(:draw?).and_return(false)
        expect(board.result).to be_nil
      end
    end
  end
end
