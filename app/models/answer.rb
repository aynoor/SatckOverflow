class Answer < ActiveRecord::Base
  acts_as_votable
  
  belongs_to :question
  belongs_to :user
  
  validates  :content,  presence: true
  validates  :question, presence: true
  validates  :user,     presence: true


  def total_upvotes
    get_upvotes.size
  end

  def total_downvotes
    get_downvotes.size
  end
  
end
