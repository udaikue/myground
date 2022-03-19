# frozen_string_literal: true

require 'rails_helper'

describe '観戦日記管理', type: :system do
  before do
    FactoryBot.create(:marines)
    FactoryBot.create(:carp)
    FactoryBot.create(:ballpark)
    FactoryBot.create(:game)
    @user = FactoryBot.create(:user)
  end

  describe 'latest_diaries#index' do
    context '公開された日記がある場合' do
      before do
        diary = FactoryBot.create(:diary)
        visit latest_diaries_path
      end

      it '日記が表示される' do
        expect(page).to have_content "#{Time.zone.today.month}/#{Time.zone.today.day} ロッテVS広島 @ZOZOマリン"
      end
    end
  end

  describe '#index' do
    context '公開された日記がある場合' do
      before do
        diary = FactoryBot.create(:diary)
        visit diaries_path(@user.username)
      end

      it '日記が表示される' do
        expect(page).to have_content "#{Time.zone.today.month}/#{Time.zone.today.day} ロッテVS広島 @ZOZOマリン"
      end
    end

    context '非公開の日記がある場合' do
      before do
        diary = FactoryBot.create(:diary, published: 'false')
        visit diaries_path(@user.username)
      end

      it '日記が表示されない' do
        expect(page).to have_no_content "#{Time.zone.today.month}/#{Time.zone.today.day} ロッテVS広島 @ZOZOマリン"
      end

      it '本人がログイン時は表示される' do
        visit new_user_session_path
        fill_in 'Eメール', with: @user.email
        fill_in 'パスワード', with: @user.password
        click_button 'ログイン'

        visit diaries_path(@user.username)
        expect(page).to have_content "#{Time.zone.today.month}/#{Time.zone.today.day} ロッテVS広島 @ZOZOマリン"
      end
    end

    context '日記がない場合' do
      before do
        visit diaries_path(@user.username)
      end

      it '「まだ日記はありません。」と表示される' do
        expect(page).to have_content 'まだ日記はありません。'
      end
    end
  end

  describe '#show' do
    before do
      @diary = FactoryBot.create(:diary)
    end

    context '自分の日記の場合' do
      before do
        visit new_user_session_path
        fill_in 'Eメール', with: @user.email
        fill_in 'パスワード', with: @user.password
        click_button 'ログイン'

        visit diary_path(@user.username, @diary.id)
      end

      it '編集ボタンが表示される' do
        expect(page).to have_link '編集'
      end
    end

    context '他人の日記の場合' do
      before do
        visit diary_path(@user.username, @diary.id)
      end

      it '編集ボタンが表示されない' do
        expect(page).to have_no_link '編集'
      end
    end
  end

  describe '#create' do
    before do
      @diary = FactoryBot.create(:diary)
    end

    context 'ログイン中であれば' do
      before do
        visit new_user_session_path
        fill_in 'Eメール', with: @user.email
        fill_in 'パスワード', with: @user.password
        click_button 'ログイン'

        visit new_diary_path(@user.username)
      end

      it '日記を作成できる' do
        pending 'tableのidかclassを指定した上で修正する'
        find('td').click
        click_button '保存'
        expect(page).to have_text '日記を登録しました'
      end
    end
  end

  describe '#update' do
    before do
      @diary = FactoryBot.create(:diary)
    end

    context 'ログイン中であれば' do
      before do
        visit new_user_session_path
        fill_in 'Eメール', with: @user.email
        fill_in 'パスワード', with: @user.password
        click_button 'ログイン'

        visit edit_diary_path(@user.username, @diary.id)
      end

      it '日記を更新できる' do
        uncheck '公開する'
        click_button '保存'
        expect(page).to have_text '日記を更新しました'
      end
    end
  end

  describe '#destroy' do
    before do
      @diary = FactoryBot.create(:diary)
    end

    context 'ログイン中であれば' do
      before do
        visit new_user_session_path
        fill_in 'Eメール', with: @user.email
        fill_in 'パスワード', with: @user.password
        click_button 'ログイン'

        visit edit_diary_path(@user.username, @diary.id)
      end

      it '日記を削除できる' do
        click_button '削除'
        expect(page).to have_text '日記を削除しました'
      end
    end
  end
end
