class User < ApplicationRecord
  acts_as_paranoid
  has_secure_password

  has_many :subject_user, dependent: :destroy
  has_many :subjects, through: :subject_user

  validates :email, :name, presence: true, uniqueness: { conditions: -> { where(deleted_at: nil) } }
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
end
