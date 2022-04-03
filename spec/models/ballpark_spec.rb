# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ballpark, type: :model do
  describe '正常系' do
    it '登録成功' do
      expect(FactoryBot.build(:ballpark)).to be_valid
    end
  end
end
