class SubjectsController < ApplicationController
  before_action :find_subject, only: %i[ show edit update destroy ]

  def create
    @subject = Subject.new(api_params)

    if @subject.save
      subject_user = SubjectUser.new
      subject_user.user_id = current_user.id
      subject_user.subject_id = @subject.id
      subject_user.save
      render json: @subject, status: 201
    else 
      render json: { errors: @subject.errors.full_messages }, status: 503
    end
  end

  def index
    render json: current_user.subjects
  end

  def destroy
    if @subject
      @subject.destroy
      render json: @subject, status: 200
    else 
      render json: { errors: 'Subject not exists' }, status: 503
    end
  end

  def show
    if @subject
      render json: @subject, status: 200
    else 
      render json: { errors: 'Subject not exists' }, status: 503
    end
  end

  def update 
    if @subject.nil?
      render json: { errors: "Subject not exists" }, status: 503
      return []
    end

    if @subject.update(api_params)
      render json: @subject, status: 200
    else  
      render json: { errors: @subject.errors.full_messages }, status: 503
    end
  end

  private

  def find_subject
    @subject = Subject.find_by(id: params[:id])
  end

  def api_params
    params.permit(:name, :start_date, :end_date, :shift)
  end
end
