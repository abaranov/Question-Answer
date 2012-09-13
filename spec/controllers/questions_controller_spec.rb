require 'spec_helper'

describe QuestionsController do
  render_views
  include Devise::TestHelpers

  before :all do
    User.destroy_all
    Question.destroy_all
    Answer.destroy_all
  end

  def sign_in_as_user
    @user = FactoryGirl.create(:user)
    visit root_path
    click_link "Sign in"
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_button "Sign in"
  end

  describe "Create Question" do
    before :each do
      sign_in_as_user
    end

    it "should create question" do
      visit questions_path
      click_link "New question"
      fill_in "question_title", with: 'Question title'
      fill_in "question_body", with: 'Question body'
      click_button "Create Question"

      response.should be_success
      page.should have_content("Question title")
    end
  end

  describe "Update Question" do

    before :each do
      sign_in_as_user
      @question =  FactoryGirl.create(:question, :user_id => @user.id)
    end

    it "should update question body" do
      visit question_path(@question.id)
      click_link "Edit question"
      fill_in "question_body", with: 'Question body'
      click_button "Update Question"

      @question.reload
      @question.body.should == "Question body"
    end

    it "user should update question rate" do
      visit question_path(@question.id)
      select "5", :from => "rate"
      click_button "set"

      @question.reload
      @question.rate.should == 5
    end

    it "one user should not update question rate twice" do
      visit question_path(@question.id)
      select "5", :from => "rate"
      click_button "set"
      select "5", :from => "rate"
      click_button "set"

      page.should have_content("You have entered a rating for this question")

      @question.reload
      @question.rate.should == 5
    end
  end

  describe "Delete Question" do
    before :each do
      sign_in_as_user
      @question =  FactoryGirl.create(:question, :user_id => @user.id)
    end

    it "should delete question" do
      visit question_path(@question.id)
      click_link "Delete question"

      response.should be_success

      fill_in "query", :with => @question.title
      click_button "search"

      page.should_not have_link(@question.title)
    end
  end

  describe "Edit And Delete Foreign Question" do
    before :each do
      sign_in_as_user
      @question =  FactoryGirl.create(:question)
    end

    it "user should not edit and delete foreign question" do
      visit question_path(@question.id)

      page.should_not have_link("Edit question")
      page.should_not have_link("Delete question")
    end
  end
end