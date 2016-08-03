class Answer < ActiveRecord::Base
  acts_as_votable

  belongs_to :question
  validates :answer, presence: true
end
