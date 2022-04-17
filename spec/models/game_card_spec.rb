# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GameCard, type: :model do
  describe '正常系' do
    before do
      @game_card = GameCard.new
      @schedule = ["#{DateTime.now.month}月#{DateTime.now.day}日(土)オ - ソ京セラD大阪18:00 #{DateTime.now.month}月#{DateTime.now.day}日(土)"]
      @game_card.instance_variable_set('@schedule', @schedule)
    end

    it 'today_cardsメソッドを実行すると試合URLを返す' do
      expect(@game_card.today_cards).to eq ["https://baseball-freak.com/game/#{DateTime.now.strftime('%y%m%d')}bs-h.html"]
    end

    it 'scrapingsテーブルへ登録できる' do
      scraping = Scraping.new(url: 'https://baseball-freak.com/game/220416bs-h.html', game_date: '2022-4-16', done: false)
      expect(scraping).to be_valid
    end
  end
end
