# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Scraping, type: :model do
  describe '正常系' do
    it '登録成功' do
      expect(FactoryBot.build(:scraping)).to be_valid
    end
  end
end
