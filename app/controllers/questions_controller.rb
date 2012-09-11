class QuestionsController < ApplicationController

  before_filter :authenticate_user!, :except => [:show, :index]
  before_filter :fetch_question, :only => [:update, :show, :edit, :destroy]
  before_filter :redirect_if_cannot_modify, :only => [:destroy, :edit]

  def new
    @question = Question.new
  end
  
  def create
    @question = Question.create(params[:question].merge({user_id: current_user.id}))
    render :action => "show"
  end

  def update
    if params[:rate]
      if RateLimit.where(:owner_id => current_user.id, :issue_id => @question.id).first
        flash[:notice] = "You have entered a rating for this question"
      else
        @question.rate_limits.create(:owner_id => current_user.id, :issue_id => @question.id)
        @question.update_attribute("rate", @question.rate + params[:rate].to_i) if (-6 < params[:rate].to_i) && (params[:rate].to_i < 6)
      end
    else
      @question.update_attributes(params[:question])
    end
    redirect_to question_path(@question)
  end

  def show
    @answers = @question.answers
  end

  def index
    @questions = case
      when params[:by_rate]
        Question.order("rate").last(10)
      when params[:by_answers]
        Question.joins("LEFT JOIN `answers` ON `questions`.id = answers.question_id").group("questions.id").order("COUNT(answers.id)").last(10)
      when params[:commit]
        Question.search(params[:query])
      else
        Question.last(10)
    end
  end

  def destroy
    @question.destroy and redirect_to questions_path
  end

  private

  def fetch_question
    @question = Question.find_by_id(params[:id])
  end

  def redirect_if_cannot_modify
    redirect_to root_path if cannot?(:modify, @question)
  end
end

