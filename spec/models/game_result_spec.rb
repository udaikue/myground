# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GameResult, type: :model do
  describe '正常系' do
    context 'スコア情報が与えられた場合' do
      before do
        @game_result = GameResult.new
        @game = Game.new
        @scores = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '計', '安', '失', nil, '0', '2', '0', '0', '0', '0', '0', '0', '0', '2', '4', '2', nil, '0', '0',
                   '3', '0', '0', '0', '0', '0', 'X', '3', '8', '1', nil]

        @game_result.instance_variable_set('@game', @game)
        @game_result.instance_variable_set('@scores', @scores)
        @game_result.set_scores
      end

      it '得点・安打数・エラー数を返す' do
        expect(@game.score_visitor).to eq 2
        expect(@game.score_home).to eq 3
        expect(@game.hits_visitor).to eq 4
        expect(@game.hits_home).to eq 8
        expect(@game.errors_visitor).to eq 2
        expect(@game.errors_home).to eq 1
      end

      it 'game_not_end?メソッドが偽を返す' do
        expect(@game_result.game_not_end?).to eq false
      end
    end

    context '球場名が与えられた場合' do
      before do
        @game_result = GameResult.new
        @game = Game.new
        FactoryBot.create(:ballpark, id: 1)

        @game_result.instance_variable_set('@game', @game)
        @game_result.instance_variable_set('@ballpark_name', 'ZOZOマリン')
        @game_result.convert_ballpark_name_to_id
      end

      it '球場idを返す' do
        expect(@game.ballpark_id).to eq 1
      end
    end

    context 'ホームチーム・ビジターチームの名前が与えられた場合' do
      before do
        @game_result = GameResult.new
        @game = Game.new
        FactoryBot.create(:carp, id: 1)
        FactoryBot.create(:marines, id: 2)
        @score_board = ["\n \n123456789計安失\n", "\n\n広島\n\n020000000242\n", "\n\nロッテ\n\n00300000X381\n"]

        @game_result.instance_variable_set('@game', @game)
        @game_result.instance_variable_set('@score_board', @score_board)
        @game_result.convert_team_name_to_id
      end

      it 'ホームチーム・ビジターチームのidを返す' do
        expect(@game.team_visitor_id).to eq 1
        expect(@game.team_home_id).to eq 2
      end
    end

    context '責任投手・本塁打情報が与えられた場合' do
      before do
        @game_result = GameResult.new
        @game = Game.new
        @records = ['大瀬良　2勝1敗0S', '岡野　0勝1敗0S', '栗林　0勝1敗5S', ' ', ' ']

        @game_result.instance_variable_set('@game', @game)
        @game_result.instance_variable_set('@records', @records)
        @game_result.set_game_records
      end

      it '責任投手・本塁打情報を返す' do
        expect(@game.winning_pitcher).to eq '大瀬良(2勝1敗0S)'
        expect(@game.losing_pitcher).to eq '岡野(0勝1敗0S)'
        expect(@game.saving_pitcher).to eq '栗林(0勝1敗5S)'
        expect(@game.homerun_visitor).to eq nil
        expect(@game.homerun_home).to eq nil
      end
    end

    context '必要なデータが与えられた場合' do
      before do
        game = FactoryBot.create(:game)
        @score = Score.new(game: game, inning: 1, home: '0', visitor: '2')
      end

      it 'scoresテーブルへ登録できる' do
        expect(@score).to be_valid
      end
    end

    context '必要なデータが与えられた場合' do
      before do
        @game_result = GameResult.new
        @url = 'https://baseball-freak.com/game/220416bs-h.html'
        FactoryBot.create(:scraping, url: @url)
      end

      it 'scrapingsテーブルを更新できる' do
        expect(@game_result.update_scraping_flag(@url)).to eq true
      end
    end
  end
end
