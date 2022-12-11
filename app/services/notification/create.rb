class Notification::Create
  prepend SimpleCommand

  def initialize(topic_id)
    @topic = Topic.find topic_id
  end

  def call
    notification = Notification.where(created_at: Date.today.all_day).last
    notification = notification ? notification : Notification.new

    notification.user_id = @topic.user_id

    notification.date = Time.now - 3.hours

    notification.save 

    notification_topic = NotificationTopic.new

    notification_topic.notification_id = notification.id 
    notification_topic.topic_id = @topic.id

    notification_topic.save
  end

end
