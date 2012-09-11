class RateLimit < ActiveRecord::Base
  attr_accessible :issue_id, :owner_id

  belongs_to :user
  belongs_to :question
end
