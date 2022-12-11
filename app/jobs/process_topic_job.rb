class ProcessTopicJob < ApplicationJob
  def perform(topic_id)
    Notification::Create.call(topic_id)
  end
end