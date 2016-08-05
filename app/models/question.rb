class Question < ActiveRecord::Base
  acts_as_votable

  belongs_to :user
  has_many   :answers, dependent: :destroy

  validates  :description, presence: true
  validates  :user,        presence: true
  
  def total_upvotes
    get_upvotes.size
  end

  def total_downvotes
    get_downvotes.size
  end

  def destroy_votes
    votes_for = 0
  end

end
