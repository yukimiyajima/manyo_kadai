require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :model do

  before do
    @user = FactoryBot.create(:user)
    end

  it 'titleが空ならバリデーションが通らない' do
    task = Task.new(title: '', content: '失敗テスト')
    expect(task).not_to be_valid
  end
  it 'contentが空ならバリデーションが通らない' do
    # ここに内容を記載する
    task = Task.new(title: '失敗テスト', content: '')
    expect(task).not_to be_valid
  end
  it 'titleとcontentに内容が記載されていればバリデーションが通る' do
    # ここに内容を記載する
    task = Task.new(title: '成功テスト', content: '成功テスト', user: @user)
    expect(task).to be_valid
  end
end