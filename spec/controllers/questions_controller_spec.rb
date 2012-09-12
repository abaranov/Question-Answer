require 'spec_helper'

describe QuestionsController do
  render_views
  include Devise::TestHelpers

  def sign_in_as_user
    @user = FactoryGirl.create(:user)
    visit root_path
    click_link "Sign in"
    fill_in "Email", with: @user.email
    fill_in "Password", with: "FooBar8"
    click_button "Sign in"
    @question =  FactoryGirl.create(:question, :user_id => @user.id)
  end

  before :all do
    User.destroy_all
  end

  describe "GET 'new'" do

    it "should update question body" do
      sign_in_as_user
      visit question_path(@question.id)
      click_link "Edit question"
      fill_in "question_body", with: 'Question body'
      click_button "Update Question"

      @question.reload
      @question.body.should == "Question body"
    end

    it "user should update question rate" do
      sign_in_as_user
      visit question_path(@question.id)
      select "5", :from => "rate"
      click_button "set"

      @question.reload
      @question.rate.should == 5
    end

    it "one user should not update question rate twice" do
      sign_in_as_user
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
end