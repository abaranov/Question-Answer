require 'spec_helper'

describe AnswersController do
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

  describe "Create Answer" do
    before :each do
      sign_in_as_user
      @question =  FactoryGirl.create(:question, :user_id => @user.id)
    end

    it "should create answer" do
      visit question_path(@question.id)
      click_link "New answer"
      fill_in "answer_body", with: 'Answer body'
      click_button "Create Answer"

      response.should be_success
      page.should have_content("Answer body")
    end
  end

  describe "Update Answer" do
    before :each do
      sign_in_as_user
      @question =  FactoryGirl.create(:question, :user_id => @user.id)
      @answer =  FactoryGirl.create(:answer, :question_id => @question.id, :user_id => @user.id)
    end

    it "should update answer body" do
      visit question_path(@question.id)
      click_link "Edit answer"
      fill_in "answer_body", with: 'Answer body'
      click_button "Update Answer"

      @answer.reload
      @answer.body.should == "Answer body"
    end
  end

  describe "Delete Answer" do
    before :each do
      sign_in_as_user
      @question =  FactoryGirl.create(:question, :user_id => @user.id)
      @answer =  FactoryGirl.create(:answer, :question_id => @question.id, :user_id => @user.id)
    end

    it "should delete answer" do
      visit question_path(@question.id)
      page.should have_content(@answer.body)
      click_link "Delete answer"

      response.should be_success
      page.should_not have_content(@answer.body)
    end
  end

  describe "Edit And Delete Foreign Answer" do
    before :each do
      sign_in_as_user
      @question =  FactoryGirl.create(:question)
      @answer =  FactoryGirl.create(:answer, :question_id => @question.id)
    end

    it "user should not edit and delete foreign answer" do
      visit question_path(@question.id)

      page.should have_content(@answer.body)
      page.should_not have_link("Edit answer")
      page.should_not have_link("Delete answer")
    end
  end
end