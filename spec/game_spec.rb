#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  subject(:game) { described_class.new(player1, player2, board) }
  let(:player1) { instance_double(Player) }
  let(:player2) { instance_double(Player) }
  let(:board) { instance_double(Board) }

  before do
    game.instance_variable_set(:@current_player, player1)
    game.instance_variable_set(:@other_player, player2)
  end

  describe '#update_player1_data' do
    before do
      allow(player1).to receive(:name=)
      allow(player1).to receive(:marker=)
    end

    it 'sends message to player 1 to update name' do
      expect(player1).to receive(:name=)
      game.update_player1_data
    end

    it 'sends message to player 1 to update marker' do
      expect(player1).to receive(:marker=)
      game.update_player1_data
    end
  end

  describe '#update_player2_data' do
    before do
      allow(player2).to receive(:name=)
      allow(player2).to receive(:marker=)
    end

    it 'sends message to player 1 to update name' do
      expect(player2).to receive(:name=)
      game.update_player2_data
    end

    it 'sends message to player 1 to update marker' do
      expect(player2).to receive(:marker=)
      game.update_player2_data
    end
  end

  describe '#create_player_name' do
    before do
      allow(game).to receive(:print).with('> ')
    end

    context 'when the invalid name given as input' do
      context 'when invalid name given twice and a valid input given' do
        before do
          allow(game).to receive(:gets).and_return('', '', 'hell fury')
          allow(player1).to receive(:valid_name?).and_return(false, false, true)
        end

        it 'shows error message twice' do
          expect(game).to receive(:puts).with('Invalid Name!').twice
          game.create_player_name
        end

        it 'returns the valid name' do
          allow(game).to receive(:puts)
          name = game.create_player_name
          expect(name).to eq('hell fury')
          game.create_player_name
        end
      end
    end

    context 'when a valid name given as input' do
      before do
        allow(game).to receive(:gets).and_return('hell fury')
        allow(player1).to receive(:valid_name?).and_return(true)
      end

      it 'finishes execution without showing error message' do
        expect(game).not_to receive(:puts).with('Invalid Name!')
        game.create_player_name
      end

      it 'returns the valid name' do
        name = game.create_player_name
        expect(name).to eq('hell fury')
        game.create_player_name
      end
    end
  end
end
