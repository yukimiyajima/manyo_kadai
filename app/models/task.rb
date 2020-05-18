class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  belongs_to :user

  scope :find_status, -> (status) { where(status: status) if status.present?}
  scope :find_title, -> (title) { where("title LIKE ?", "%#{title}%") if title.present?}
  scope :sort_column, -> (colmn,sort) { 
    column = "created_at" if column.blank?
    sort = "DESC" if sort.blank?
    order(Hash[column,sort])}

  enum priority:{
    高: 0,
    中: 1,
    低: 2
  }

  enum status:{
    未着手:0,
    着手中:1,
    完了:2
  }
  
end
