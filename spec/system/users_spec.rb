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
        fill_in '確認のためパスワードを再度入力してください', with: 'abc123'
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
        fill_in '確認のためパスワードを再度入力してください', with: 'abc123'
        click_button '登録'
      end

      it '「Eメール は使用されています」と表示される' do
        expect(page).to have_text 'Eメール は使用されています'
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

  describe 'ユーザー情報更新' do
    before do
      @user = FactoryBot.create(:user)
      visit new_user_session_path

      fill_in 'Eメール', with: @user.email
      fill_in 'パスワード', with: @user.password
      click_button 'ログイン'
    end

    describe 'ログイン中であれば' do
      it '編集画面が表示される' do
        visit edit_user_registration_path
        expect(page).to have_text 'ユーザー名'
      end
    end

    describe 'ログイン中であれば' do
      it '更新できる' do
        visit edit_user_registration_path
        fill_in 'ユーザー名', with: "#{@user.username}xxx"
        fill_in '現在のパスワード', with: @user.password
        click_button '更新'

        expect(page).to have_text 'アカウント情報を変更しました。'
      end
    end
  end
end
