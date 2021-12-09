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

    it 'creates an instance variable last_moved_piece with nil value' do
      last_moved_piece = board.last_moved_piece
      expect(last_moved_piece).to be_nil
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
end
