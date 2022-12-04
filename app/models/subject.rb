class Subject < ApplicationRecord
  has_many :subject_user, dependent: :destroy
  has_many :users, through: :subject_user

end
