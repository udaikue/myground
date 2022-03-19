# frozen_string_literal: true

require 'rails_helper'

describe 'ユーザー管理', type: :system do
  describe 'ユーザー登録' do
    before do
      visit new_user_registration_path
    end

    describe '正しく入力された場合' do
      before do
        fill_in 'Eメール', with: 'abc@example.com'
        fill_in 'ユーザー名', with: 'abc'
        fill_in 'パスワード', with: 'abc123'
        fill_in 'パスワード（確認用）', with: 'abc123'
        click_button '登録'
      end

      it '「アカウント登録が完了しました。」と表示される' do
        expect(page).to have_text 'アカウント登録が完了しました。'
      end
    end

    describe 'Eメールが重複している場合' do
      before do
        FactoryBot.create(:user, email: 'abc@example.com')

        fill_in 'Eメール', with: 'abc@example.com'
        fill_in 'ユーザー名', with: 'abc'
        fill_in 'パスワード', with: 'abc123'
        fill_in 'パスワード（確認用）', with: 'abc123'
        click_button '登録'
      end

      it 'エラーメッセージが表示される' do
        # 再考して書く
      end
    end
  end

  describe 'ログイン' do
    before do
      @user = FactoryBot.create(:user)
      visit new_user_session_path
    end

    describe '正しく入力された場合' do
      before do
        fill_in 'Eメール', with: @user.email
        fill_in 'パスワード', with: @user.password
        click_button 'ログイン'
      end

      it '「ログインしました。」と表示される' do
        expect(page).to have_text 'ログインしました。'
      end
    end

    describe 'メールアドレスが違う場合' do
      before do
        fill_in 'Eメール', with: 'abc@abc'
        fill_in 'パスワード', with: @user.password
        click_button 'ログイン'
      end

      it '「Eメールまたはパスワードが違います」と表示される' do
        expect(page).to have_text 'Eメールまたはパスワードが違います'
      end
    end

    describe 'パスワードが空白の場合' do
      before do
        fill_in 'Eメール', with: @user.email
        click_button 'ログイン'
      end

      it '「Eメールまたはパスワードが違います」と表示される' do
        expect(page).to have_text 'Eメールまたはパスワードが違います'
      end
    end
  end
end
