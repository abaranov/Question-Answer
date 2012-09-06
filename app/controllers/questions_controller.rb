class QuestionsController < ApplicationController

  before_filter :authenticate_user!, :except => [:show, :index]

  def new
    @question = Question.new
  end
  
  def create
    @question = Question.new(params[:question].merge({user_id: current_user.id}))
    @question.save
    render :action => "show"
  end

  def update
    @question = Question.find(params[:id])
    @question.update_attributes(params[:question])
    render :action => "show"
  end

  def show
    @question = Question.find(params[:id])
    @answers = Answer.where(:question_id => params[:id])
    set_rate
  end

  def set_rate
    if params[:commit]
      exit

    end
  end

  def index

    #if qewr
    #  @questions = Question.order("rate ASC").last(10)
    #elsif  dsgesr
    #  @questions = Answer.select("question_id")
    #else
      @questions = Question.last(10)
    #end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    @questions = Question.all
    render :action => "index"
  end
end
