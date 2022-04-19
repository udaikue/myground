# frozen_string_literal: true

require 'rails_helper'

describe '観戦日記管理', type: :system do
  before do
    FactoryBot.create(:marines)
    FactoryBot.create(:carp)
    FactoryBot.create(:ballpark)
    @game = FactoryBot.create(:game)
    @user = FactoryBot.create(:user)
  end

  context '未ログイン時' do
    context '日記一覧ページにアクセスすると' do
      before do
        visit diaries_path(@user.username)
      end

      it 'ログイン画面が表示される' do
        expect(page).to have_content 'ログインもしくはアカウント登録してください。'
      end
    end
  end

  describe '#index' do
    context 'ログイン時' do
      before do
        visit new_user_session_path
        fill_in 'Eメール', with: @user.email
        fill_in 'パスワード', with: @user.password
        click_button 'ログイン'
      end

      context '日記がある場合' do
        before do
          FactoryBot.create(:diary, game: @game, user: @user)
          visit diaries_path(@user.username)
        end

        it '日記が表示される' do
          expect(page).to have_content "#{Time.zone.today.year}/#{Time.zone.today.month}/#{Time.zone.today.day}"
        end
      end

      context '日記がない場合' do
        before do
          visit diaries_path(@user.username)
        end

        it '「まだ日記はありません」と表示される' do
          expect(page).to have_content 'まだ日記はありません'
        end
      end

      context '他ユーザーの日記一覧の場合' do
        before do
          @other_user = FactoryBot.create(:user, username: 'other_user', email: 'other_user@example.com')
          visit diaries_path(@other_user.username)
        end

        it '「このページは表示できません」と表示される' do
          expect(page).to have_content 'このページは表示できません'
        end
      end
    end
  end

  describe '#show' do
    context 'ログイン時' do
      before do
        @diary = FactoryBot.create(:diary, game: @game, user: @user)

        visit new_user_session_path
        fill_in 'Eメール', with: @user.email
        fill_in 'パスワード', with: @user.password
        click_button 'ログイン'
      end

      context '自分の日記の場合' do
        before do
          visit diary_path(@user.username, @diary.id)
        end

        it '編集ボタンが表示される' do
          expect(page).to have_link '編集'
        end
      end

      context '他ユーザーの日記の場合' do
        before do
          other_user = FactoryBot.create(:user, username: 'other_user', email: 'other_user@example.com')
          other_diary = FactoryBot.create(:diary, game: @game, user: other_user)
          visit diary_path(other_user.username, other_diary.id)
        end

        it '「このページは表示できません」と表示される' do
          expect(page).to have_content 'このページは表示できません'
        end
      end
    end
  end

  describe '#create' do
    context 'ログイン時' do
      before do
        visit new_user_session_path
        fill_in 'Eメール', with: @user.email
        fill_in 'パスワード', with: @user.password
        click_button 'ログイン'

        visit new_diary_path(@user.username)
      end

      it '日記を作成できる' do
        within '#game-cards' do
          find('#game-card').click
        end
        fill_in 'diary[comment]', with: 'テスト日記です。'
        click_button '保存'
        expect(page).to have_text '日記を登録しました'
      end
    end
  end

  describe '#update' do
    context 'ログイン時' do
      before do
        @diary = FactoryBot.create(:diary, game: @game, user: @user)

        visit new_user_session_path
        fill_in 'Eメール', with: @user.email
        fill_in 'パスワード', with: @user.password
        click_button 'ログイン'

        visit edit_diary_path(@user.username, @diary.id)
      end

      it '日記を更新できる' do
        fill_in 'diary_comment', with: '日記を更新します。'
        click_button '更新'
        expect(page).to have_text '日記を更新しました'
      end
    end
  end

  describe '#destroy' do
    context 'ログイン時' do
      before do
        @diary = FactoryBot.create(:diary, game: @game, user: @user)

        visit new_user_session_path
        fill_in 'Eメール', with: @user.email
        fill_in 'パスワード', with: @user.password
        click_button 'ログイン'

        visit edit_diary_path(@user.username, @diary.id)
      end

      it '日記を削除できる' do
        click_button '削除'
        expect(page.accept_confirm).to eq '本当に削除しますか?'
        expect(page).to have_text '日記を削除しました'
      end
    end
  end
end
