class Notification::Create
  prepend SimpleCommand

  def initialize(topic_id)
    @topic = Topic.find topic_id
  end

  def call
    revisions = [1, 7, 30]

    revisions.each do |revision|
      notification = Notification.new

      notification.user_id = @topic.user_id

      notification.date = Date.today + revision.days()

      notification.save

      notification_topic = NotificationTopic.new

      notification_topic.notification_id = notification.id 
      notification_topic.topic_id = @topic.id
  
      notification_topic.save
    end
  end
end
