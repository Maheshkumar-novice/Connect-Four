#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  subject(:board) { described_class.new }

  describe '#initialize' do
    matcher :be_empty do
      match { |value| value == '' }
    end

    it 'creates an array with empty strings' do
      board_slots = board.board.flatten
      expect(board_slots).to all(be_empty)
    end

    it 'creates an array of length 42' do
      board_slots_count = board.board.flatten.size
      expect(board_slots_count).to be(42)
    end
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
        allow(board).to receive(:column_has_connected_four?).and_return(true)
        expect(board.win?).to be true
      end
    end

    context 'when a diagonal has connected four' do
      it 'returns true' do
        allow(board).to receive(:board_empty?).and_return(false)
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
        value = [
          %i[red red red red red red red],
          %i[red red red red red red red],
          %i[red red red red red red red],
          %i[red red red red red red red],
          %i[red red red red red red red],
          %i[red red red red red red red]
        ]
        board.instance_variable_set(:@board, value)
        expect(board.board_empty?).to be false
      end
    end

    context 'when the board is neither empty nor full' do
      it 'returns false' do
        value = [
          ['', :red, '', '', '', :red, ''],
          [:red, '', '', '', :red, :red, :red],
          ['', '', '', '', '', '', ''],
          %i[red red red red red red red],
          ['', :red, '', :red, '', :red, ''],
          [:red, :red, :red, '', '', '', :red]
        ]
        board.instance_variable_set(:@board, value)
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
        value = [
          %i[red red red red red red red],
          %i[red red red red red red red],
          %i[red red red red red red red],
          %i[red red red red red red red],
          %i[red red red red red red red],
          %i[red red red red red red red]
        ]
        board.instance_variable_set(:@board, value)
        expect(board.board_full?).to be true
      end
    end

    context 'when the board is neither empty nor full' do
      it 'returns false' do
        value = [
          ['', :red, '', '', '', :red, ''],
          [:red, '', '', '', :red, :red, :red],
          ['', '', '', '', '', '', ''],
          %i[red red red red red red red],
          ['', :red, '', :red, '', :red, ''],
          [:red, :red, :red, '', '', '', :red]
        ]
        board.instance_variable_set(:@board, value)
        expect(board.board_full?).to be false
      end
    end
  end
end
