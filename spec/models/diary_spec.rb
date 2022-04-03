# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Diary, type: :model do
  describe '正常系' do
    it '登録成功' do
      game = FactoryBot.build(:game)
      user = FactoryBot.build(:user)
      expect(FactoryBot.build(:diary, game: game, user: user)).to be_valid
    end
  end
end
