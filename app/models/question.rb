class Question < ActiveRecord::Base
  acts_as_votable

  def score
    self.get_upvotes.size - self.get_downvotes.size
  end

  def total_upvotes
    self.get_upvotes.size
  end

  def total_downvotes
    self.get_downvotes.size
  end

  belongs_to :user
  validates :description, presence: true
  has_many :answers, dependent: :destroy
end
