class NotificationsController < ApplicationController
  before_action :set_notification, only: %i[ show update ]

  def index
    query = "
      SELECT
      DISTINCT ON (notifications.id)
        notifications.id,
        notifications.date,
        notifications.status,
        topics.name AS topic_name,
        topics.id AS topic_id
      FROM
        notifications
      LEFT JOIN notification_topics nt
        on nt.notification_id = notifications.id
      LEFT JOIN topics
        ON topics.id = nt.topic_id 
      WHERE notifications.user_id = '#{current_user.id}' 
        AND topics.deleted_at IS NULL
    "

    results = ActiveRecord::Base.connection.exec_query(query)

    render json: results, status: 200
  end

  def show
    if @notification
      render json: @notification, status: 200
    else 
      render json: { errors: 'Topic not exists' }, status: 503
    end
  end

  def update 
    if @notification.nil?
      render json: { errors: "Notification not exists" }, status: 503
      return []
    end

    if @notification.update(status: true)
      render json: @notification, status: 200
    else  
      render json: { errors: @notification.errors.full_messages }, status: 503
    end
  end

  private

  def set_notification
    @notification = Notification.find_by(id: params[:id])
  end
end
