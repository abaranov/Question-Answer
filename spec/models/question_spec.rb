require 'spec_helper'

describe Question do

  before :all do
    User.destroy_all
    Question.destroy_all
    Answer.destroy_all
  end

  before(:each) do
    @user = FactoryGirl.create(:user)
    @attr = { :title => "Question title", :body => "Question body", :user_id => @user.id }
  end

  it "should create a new instance given valid attributes" do
    Question.create!(@attr)
  end

  it "should require an title" do
    no_title = Question.new(@attr.merge(:title => ""))
    no_title.should_not be_valid
  end

  it "should require an body" do
    no_body = Question.new(@attr.merge(:body => ""))
    no_body.should_not be_valid
  end

  it "should require an user_id" do
    no_user_id = Question.new(@attr.merge(:user_id => ""))
    no_user_id.should_not be_valid
  end
end