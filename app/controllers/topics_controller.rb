class TopicsController < ApplicationController
  before_action :set_topic, only: %i[ show edit update destroy ]

  def index
    render json: Topic.where(user_id: current_user.id).all, status: 201
  end

  def show
    render json: @topic, status: 200
  end

  def new
    @topic = Topic.new
  end

  def edit
  end

  def create
    @topic = Topic.new

    @topic.name = topic_params[:name]
    @topic.study_hours = topic_params[:study_hours]
    @topic.user_id = topic_params[:user_id]
    @topic.subject_id = topic_params[:subject_id]

    if @topic.save
      render json: @topic, status: 201
    else
      render json: { errors: @subject.errors.full_messages }, status: 503
    end
  end

  def update
    @topic.update(topic_params)
  end

  def destroy
    @topic.destroy
  end

  private

  def set_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.permit(:name, :study_hours, :user_id, :subject_id)
  end
end
