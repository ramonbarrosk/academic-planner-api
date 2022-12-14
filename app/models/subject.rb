class Subject < ApplicationRecord
  acts_as_paranoid
  
  has_many :subject_user, dependent: :destroy
  has_many :users, through: :subject_user

  validates :name, :start_date, :end_date, :shift, presence: true
  validates :name, :shift, uniqueness: { conditions: -> { where(deleted_at: nil) } }
end
