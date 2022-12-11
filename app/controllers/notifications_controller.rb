class NotificationsController < ApplicationController
  before_action :set_notification, only: %i[ show update ]

  def index
    query = "
      SELECT
        notifications.id,
        notifications.date,
        jsonb_agg(topics.name) AS topics
      FROM
        notifications
      LEFT JOIN notification_topics nt
        on nt.notification_id = notifications.id
      LEFT JOIN topics
        ON topics.id = nt.topic_id 
      WHERE notifications.user_id = '#{current_user.id}'
      GROUP BY 
        notifications.id,
        notifications.date 
    "

    results = ActiveRecord::Base.connection.exec_query(query)

    results.map do |notification|
      notification[:topics] = notification['topics'].gsub("[", "").gsub("]", "").gsub("\"", "").split(",")
    end
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
    #DEFAULT ASSIM QUE ATUALIZA NOTIFICAÇÃO, ACRESCENTA MAIS 10 DIAS PARA REVISAR

    if @notification.update(date: @notification.date + 10.days)
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
