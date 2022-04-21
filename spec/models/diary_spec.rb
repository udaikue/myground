# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Diary, type: :model do
  describe '正常系' do
    before do
      @game = FactoryBot.build(:game)
      @user = FactoryBot.build(:user)
    end

    it '登録成功' do
      expect(FactoryBot.build(:diary, game: @game, user: @user)).to be_valid
    end

    context 'previousメソッドを実行すると' do
      before do
        @diary1 = FactoryBot.create(:diary, game: @game, user: @user)
        @diary2 = FactoryBot.create(:diary, game: @game, user: @user, id: @diary1.id + 1)
      end

      it '前の日記を取得できる' do
        expect(@diary2.previous).to eq @diary1
      end
    end

    context 'nextメソッドを実行すると' do
      before do
        @diary1 = FactoryBot.create(:diary, game: @game, user: @user)
        @diary2 = FactoryBot.create(:diary, game: @game, user: @user, id: @diary1.id + 1)
      end

      it '次の日記を取得できる' do
        expect(@diary1.next).to eq @diary2
      end
    end
  end
end
