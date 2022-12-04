class Topic < ApplicationRecord
  has_many :notification_topic, dependent: :destroy
  has_many :notifications, through: :notification_topic
end
