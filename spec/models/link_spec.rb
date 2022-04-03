# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Link, type: :model do
  describe '正常系' do
    it '登録成功' do
      expect(FactoryBot.build(:link)).to be_valid
    end
  end
end
