class Question < ActiveRecord::Base
  attr_accessible :body, :title, :user_id

  belongs_to :user
  has_many :answers

  has_many :rate_limits, :foreign_key => "issue_id"

  def self.search(query)
    where("title LIKE ?", "%#{query}%")
  end
end
