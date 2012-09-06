class Answer < ActiveRecord::Base
  attr_accessible :body, :question_id, :rating, :user_id

  belongs_to :question
  belongs_to :user
end
