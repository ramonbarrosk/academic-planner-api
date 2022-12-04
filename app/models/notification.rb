class Notification < ApplicationRecord
  has_many :notification_topic, dependent: :destroy
  has_many :topics, through: :notification_topic
end
