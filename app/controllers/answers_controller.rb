class AnswersController < ApplicationController

  before_filter :authenticate_user!
  before_filter :fetch_answer, :only => [:update, :edit, :destroy]
  before_filter :redirect_if_cannot_modify, :only => [:update, :destroy, :edit]

  def new
    @answer = Answer.new(:question_id => params[:question_id])
  end

  def create
    @answer = Answer.create(params[:answer].merge({user_id: current_user.id}))
    redirect_to question_path(@answer.question)
  end

  def update
    @answer.update_attributes(params[:answer])
    redirect_to question_path(@answer.question)
  end

  def destroy
    @answer.destroy
    redirect_to question_path(@answer.question)
  end

  private

  def fetch_answer
    @answer = Answer.find_by_id(params[:id])
  end

  def redirect_if_cannot_modify
    redirect_to root_path if cannot?(:modify, @answer)
  end
end
