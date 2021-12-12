#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/player'

describe Player do
  subject(:player) { described_class.new }

  describe '#valid_name?' do
    context 'when a name with length 0 given' do
      it 'returns false' do
        name = ''
        expect(player.valid_name?(name)).to be false
      end
    end

    context 'when a name with length more than max length given' do
      it 'returns false' do
        name = 'qwertymanfrommarsgoingtovenus'
        expect(player.valid_name?(name)).to be false
      end
    end

    context 'when a name with special characters given' do
      it 'returns false' do
        name = '^hello $mate!'
        expect(player.valid_name?(name)).to be false
      end
    end

    context 'when a valid name given' do
      it 'returns true' do
        name = 'hello mate'
        expect(player.valid_name?(name)).to be true
      end
    end
  end
end
