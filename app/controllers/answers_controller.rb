class AnswersController < ApplicationController

  def create
    @question = Question.find(params[:question_id])
    @answer = Answer.create(params[:answer].permit(:content))
    authorize! :create, @answer
    @answer.user_id = current_user.id
    @answer.question_id = @question.id

    if @answer.save
      redirect_to question_path(@question)
    else 
      respond_to do |format|
        format.js   { render :layout => false }
      end
    end
  end

end
