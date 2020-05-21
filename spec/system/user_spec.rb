require 'rails_helper'
RSpec.describe 'ユーザ登録・ログイン・ログアウト機能', type: :system do
  before do
  FactoryBot.create(:user)
  FactoryBot.create(:admin_user)
  end

  def login
    visit new_session_path
    fill_in 'Email', with: 'sample@example.com'
    fill_in 'Password', with: '00000000'
    click_on 'ログインする'
  end

  def admin_login
    visit new_session_path
    fill_in 'Email', with: 'admin@example.com'
    fill_in 'Password', with: '00000000'
    click_on 'ログインする'
  end

  describe 'ユーザ登録のテスト' do
    context 'ユーザのデータがなくログインしていない場合' do
      it 'ユーザ新規登録のテスト' do
        visit new_user_path
        fill_in 'user[name]', with: 'aaa'
        fill_in 'user[email]', with: 'bbb@example.com'
        fill_in 'user[password]', with: '00000000'
        fill_in 'user[password_confirmation]', with: '00000000'
        click_on '登録する'
        expect(page).to have_content 'タスク一覧'
      end
      it 'ログインしていない時はログイン画面に飛ぶテスト' do
        visit tasks_path
        expect(current_path).to eq new_session_path
      end
    end
  end

  describe 'セッション機能のテスト' do
    before do
      visit new_session_path
      fill_in 'Email', with: 'sample@example.com'
      fill_in 'Password', with: '00000000'
      click_on 'ログインする'
    end
    context 'ログインした場合' do
      it 'ログインが出来るかのテスト' do
        expect(page).to have_content 'ログインしました'
      end
      it 'ログイン後自分のマイページ（詳細画面）に遷移出来るか' do
        click_on 'Profile'
        expect(page).to have_content 'sampleのページ'
      end
      it 'ログアウト出来るか' do
        click_on 'Logout'
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end

  describe '管理画面のテスト' do
    context '管理者がログインした場合' do
      it '管理者は管理画面にアクセス出来るか' do
        admin_login
        click_on '管理者画面'
        expect(page).to have_content 'ユーザー管理一覧画面'
      end
    end
    context '一般ユーザーがログインした場合' do
      it '管理画面にアクセス出来ない' do
        login
        visit admin_users_path
        expect(page).to have_content '管理者ではありません'
      end
    end
    it '管理者はユーザーを新規登録出来るか' do
      admin_login
      click_on '管理者画面'
      click_on 'ユーザー新規作成'
      fill_in 'user[name]', with: 'sample03'
      fill_in 'user[email]', with: 'sample03@example.com'
      fill_in 'user[password]', with: '00000000'
      fill_in 'user[password_confirmation]', with: '00000000'
      click_on '登録する'
      sleep 0.5
      expect(page).to have_content '詳細確認画面'
    end
    it '管理者はユーザーの詳細画面にアクセス出来るか' do
      admin_login
      click_on '管理者画面'
      click_on '詳細', match: :first
      expect(page).to have_content 'sampleのページ'
    end
    it '管理者はユーザーの編集画面から編集出来るか' do
      admin_login
      click_on '管理者画面'
      click_on '編集', match: :first
      expect(page).to have_content '管理者編集画面'
    end
    it '管理者はユーザーの削除が出来るか' do
      admin_login
      click_on '管理者画面'
      click_on '削除', match: :first
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content 'ユーザーを削除しました'
    end
  end
end