class QuestionsController < ApplicationController


  def index
    @questions = Question.all
    @question = Question.new
    #@answer = Answer.new
  end

  def create
    @question = Question.new(params[:question])
    @question.save
    #respond_with @question
  end

  #def answer
  #  @questions = Question.all
  #  @question = Question.new
  #  @answer = Answer.new(params[:answer])
  #  @answer.save
  #  redirect_to :action => "index"
  #end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @questions = Question.all
    @question = Question.find(params[:id])
    @question.update_attributes(params[:question])
    render :action => "index"
  end

  def destroy
    @questions = Question.all
    @question = Question.find(params[:id])
    @question.destroy
    render :action => "index"
  end
end
