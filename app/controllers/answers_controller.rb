class AnswersController < ApplicationController

  before_filter :authenticate_user!

  def new
    @answer = Answer.new(:question_id => params[:question_id])
  end

  def create
    @answer = Answer.new(params[:answer].merge({user_id: current_user.id}))
    @answer.save
    redirect_to question_path(@answer.question)
  end

  def edit
    @answer = Answer.find(params[:question_id])
  end

  def update
    @answer = Answer.find(params[:id])
    @answer.update_attributes(params[:answer])
    redirect_to question_path(@answer.question)
  end

  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy
    redirect_to question_path(@answer.question)
  end
end
