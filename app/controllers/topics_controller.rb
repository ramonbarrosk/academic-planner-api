class TopicsController < ApplicationController
  before_action :set_topic, only: %i[ show edit update destroy ]

  def index
    render json: Topic.where(user_id: current_user.id).all, status: 200
  end

  def show
    if @topic
      render json: @topic, status: 200
    else 
      render json: { errors: 'Topic not exists' }, status: 503
    end
  end

  def new
    @topic = Topic.new
  end

  def edit
  end

  def create
    @topic = Topic.new(topic_params)

    if @topic.save
      render json: @topic, status: 201
    else
      render json: { errors: @topic.errors.full_messages }, status: 503
    end
  end

  def update 
    if @topic.nil?
      render json: { errors: "Topic not exists" }, status: 503
      return []
    end

    if @topic.update(topic_params)
      render json: @topic, status: 200
    else  
      render json: { errors: @topic.errors.full_messages }, status: 503
    end
  end

  def destroy
    if @topic
      @topic.destroy
      render json: @topic, status: 200
    else 
      render json: { errors: 'Topic not exists' }, status: 503
    end
  end

  private

  def set_topic
    @topic = Topic.find_by(id: params[:id])
  end

  def topic_params
    params.permit(:name, :study_hours, :user_id, :subject_id)
  end
end
