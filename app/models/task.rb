class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  belongs_to :user
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings

  scope :find_status, -> (status) { where(status: status) if status.present?}
  scope :find_title, -> (title) { where("title LIKE ?", "%#{title}%") if title.present?}
  scope :sort_column, -> (colmn,sort) { 
    column = "created_at" if column.blank?
    sort = "DESC" if sort.blank?
    order(Hash[column,sort])}

  scope :find_label, -> (label) { joins(:labels).where(label)}

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
