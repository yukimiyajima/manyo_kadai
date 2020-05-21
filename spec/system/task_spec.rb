require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do

  before do
    @user = FactoryBot.create(:user)
    visit new_session_path
      fill_in 'Email', with: 'sample@example.com'
      fill_in 'Password', with: '00000000'
      click_on 'ログインする'
    # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する
    @task1 = FactoryBot.create(:task, user: @user)
    @task2 = FactoryBot.create(:second_task, user: @user)
  end
  
  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示される' do
        visit tasks_path
        expect(page).to have_content 'Factoryで作ったデフォルトのタイトル１'
      end
    end
    context '複数のタスクを作成した場合' do
      it 'タスクが作成日時の降順に並んでいる' do
        visit tasks_path
        task_list = all('tbody tr') # タスク一覧を配列として取得するため、View側でidを振っておく
        expect(task_list[0]).to have_content 'Factoryで作ったデフォルトのタイトル２'
        expect(task_list[1]).to have_content 'Factoryで作ったデフォルトのタイトル１'
      end
    end
  end
  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存される' do
        visit new_task_path
        fill_in 'タイトル', with: 'title'
        fill_in '内容', with: 'content'
        click_button '登録する'
        expect(page).to have_content 'title'
        expect(page).to have_content 'content'
      end
    end
  end

  describe 'タスク詳細画面' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示されたページに遷移する' do
        visit task_path(@task1)
        expect(page).to have_content 'Factoryで作ったデフォルトのタイトル１'
       end
     end
  end

  describe 'タスク一覧画面' do
    context '検索をした場合' do
      it "タイトル検索ができる" do
        visit tasks_path
        fill_in 'title', with: 'Factoryで作ったデフォルトのタイトル１'
        click_button 'commit'
        expect(page).to have_content 'Factoryで作ったデフォルトのタイトル１'
      end
      it "ステータス検索ができる" do
        visit tasks_path
        select('未着手')
        click_button 'commit'
        expect(page).to have_content 'Factoryで作ったデフォルトのタイトル１'
      end
      it "タイトルとステータスの両方が検索出来る" do
        visit tasks_path
        fill_in 'title', with: 'Factoryで作ったデフォルトのタイトル１'
        select('未着手')
        click_button 'commit'
        expect(page).to have_content 'Factoryで作ったデフォルトのタイトル１'
      end
    end
  end

  describe 'タスク一覧画面' do
    context 'ソートするボタンを押した場合'do
      it "終了期限の降順でソート出来る" do
        visit tasks_path
        # tasks_path(sort_expired: "true")
        click_link "終了期限でソートする"
        sleep (0.5)
        task_list = all('tbody tr')
        expect(task_list[1]).to have_content 'Factoryで作ったデフォルトのタイトル２'
        expect(task_list[0]).to have_content 'Factoryで作ったデフォルトのタイトル１'
      end
      it "優先順位の降順でソートする" do
        visit tasks_path
        tasks_path(sort_priority: "true")
        task_list = all('tbody tr')
        expect(task_list[0]).to have_content 'Factoryで作ったデフォルトのタイトル２'
        expect(task_list[1]).to have_content 'Factoryで作ったデフォルトのタイトル１'
      end
    end
  end
end