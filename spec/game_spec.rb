# frozen_string_literal: true

require 'spec_helper'

describe Game do
  describe '#initialize' do
    it 'populates a board' do
      game = Game.new
      expect(game.board).to be_a(Board)
    end

    it "starts with red's turn" do
      game = Game.new
      expect(game.turn).to eql('🔴')
    end
  end

  describe '#switch_player' do
    it 'changes the current player from red to yellow' do
      game = Game.new
      game.send(:switch_player)
      expect(game.turn).to eq('🟡')
    end

    it 'changes the current player from yellow back to red' do
      game = Game.new
      game.send(:switch_player)
      game.send(:switch_player)
      expect(game.turn).to eq('🔴')
    end
  end
  describe '#play_turn' do
    it 'places a piece on the board when input is valid' do
      game = Game.new
      allow(game).to receive(:gets).and_return('3')
      expect(game.board).to receive(:stack).with(3, '🔴')
      allow(game).to receive(:puts)

      game.send(:play_turn)
    end

    it 'prompts the player to re-input if input is invalid' do
      game = Game.new
      allow(game).to receive(:gets).and_return('8', '3')
      allow(game).to receive(:puts).with(start_with("It's"))
      allow(game.board).to receive(:stack).with(8, '🔴').and_raise(IndexError)
      expect(game).to receive(:puts).with(include('Invalid move'))
      expect(game.board).to receive(:stack).with(3, '🔴')

      game.send(:play_turn)
    end

    it 'prompts re-input if the input is empty' do
      game = Game.new
      allow(game).to receive(:gets).and_return('', '3')
      allow(game).to receive(:puts).with(start_with("It's"))
      expect(game).to receive(:puts).with(include('valid number')).once
      expect(game.board).to receive(:stack).with(3, anything)

      game.send(:play_turn)
    end
  end

  describe '#play' do
    it 'loops until the game is over' do
      game = Game.new
      allow(game.board).to receive(:over?).and_return(false, true)

      expect(game).to receive(:play_turn)
      expect(game).to receive(:switch_player)
      expect(game).to receive(:announce_result)

      allow(game.board).to receive(:display)

      game.play
    end
  end

  describe '#announce_result' do
    it 'announces the winner if there is one' do
      game = Game.new
      allow(game.board).to receive(:winner).and_return('🔴')

      expect(game).to receive(:puts).with('🔴 won!')
      game.send(:announce_result)
    end

    it 'announces a draw if there is no winner' do
      game = Game.new
      allow(game.board).to receive(:winner).and_return(nil)

      expect(game).to receive(:puts).with("It's a draw!")
      game.send(:announce_result)
    end
  end
end
