class QuestionsController < ApplicationController

  def index
    @questions = Question.paginate(page: params[:page])
    @users = User.paginate(page: params[:page])
  end

end
