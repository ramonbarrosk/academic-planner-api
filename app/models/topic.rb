class Topic < ApplicationRecord
  acts_as_paranoid

  has_many :notification_topic, dependent: :destroy
  has_many :notifications, through: :notification_topic

  validates :name, :study_hours, :subject_id, :user_id, presence: true

  after_create :create_notification


  def create_notification
    ProcessTopicJob.perform_later(self.id)
  end
end
