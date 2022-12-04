class NotificationTopic < ApplicationRecord
  belongs_to :topic 
  belongs_to :notification
end
