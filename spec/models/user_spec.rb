# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '正常系' do
    it '登録成功' do
      expect(FactoryBot.build(:user)).to be_valid
    end
  end

  describe '異常系' do
    context 'パスワード' do
      it '空白の場合は無効' do
        user = FactoryBot.build(:user, password: nil)
        user.valid?
        expect(user.errors[:password]).to include('が入力されていません')
      end
    end

    context 'メールアドレス' do
      it '重複の場合は無効' do
        user = FactoryBot.create(:user)
        user = FactoryBot.build(:user, id: 101, username: 'user101')
        user.valid?
        expect(user.errors[:email]).to include('は使用されています')
      end
    end

    context 'ユーザー名' do
      it '26文字の場合は無効' do
        user = FactoryBot.build(:user, username: 'abcdefghijklmnopqrstuvwxyz')
        user.valid?
        expect(user.errors[:username]).to include('は25文字以下に設定してください')
      end

      it '-が入っていれば無効' do
        user = FactoryBot.build(:user, username: 'test-user')
        user.valid?
        expect(user.errors[:username]).to include('は有効な値ではありません')
      end

      it '禁止されている単語が使われていれば無効' do
        user = FactoryBot.build(:user, username: 'index')
        user.valid?
        expect(user.errors[:username]).to include('は有効な値ではありません')
      end
    end
  end
end
