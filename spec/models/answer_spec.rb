require 'spec_helper'

describe Answer do

  before :all do
    User.destroy_all
    Question.destroy_all
    Answer.destroy_all
  end

  before(:each) do
    @user = FactoryGirl.create(:user)
    @question =  FactoryGirl.create(:question, :user_id => @user.id)
    @attr = { :body => "Answer body", :user_id => @user.id, :question_id => @question.id }
  end

  it "should create a new instance given valid attributes" do
    Answer.create!(@attr)
  end

  it "should require an body" do
    no_body = Answer.new(@attr.merge(:body => ""))
    no_body.should_not be_valid
  end

  it "should require an user_id" do
    no_user_id = Answer.new(@attr.merge(:user_id => ""))
    no_user_id.should_not be_valid
  end

  it "should require an question_id" do
    no_question_id = Answer.new(@attr.merge(:question_id => ""))
    no_question_id.should_not be_valid
  end
end