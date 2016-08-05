class AnswersController < ApplicationController
  #load_resource
  def create
    @question = Question.find(params[:question_id])
    @answer = Answer.new(params[:answer].permit(:content))
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

  def upvote
    @answer = Answer.find(params[:id])
    @answer.upvote_by current_user
    respond_to do |format|
      format.js   { render :layout => false }
    end
  end

  def downvote
    @answer.downvote_by current_user
    respond_to do |format|
      format.js   { render :layout => false }
    end
  end

end
