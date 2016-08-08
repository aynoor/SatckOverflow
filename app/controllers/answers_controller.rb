class AnswersController < ApplicationController

  def create
    @question = Question.find(params[:question_id])
    @answer = Answer.new(params[:answer].permit(:content))
    authorize! :create, @answer
    @answer.user_id = current_user.id
    @answer.question_id = @question.id
    
    if @answer.save
      if @question.update_attribute(:answers_count, @question.answers.count)
        redirect_to question_path(@question)
      else
        flash[:error] = "Quetion answer count not updated!"
        redirect_to @question
      end
    else 
      respond_to do |format|
        format.js   { render :layout => false }
      end
    end
  end

  def upvote
    @answer = Answer.find(params[:id])
    @answer.upvote_by current_user
    @answer.update_attribute(:upvotes_count, @answer.total_upvotes)
    respond_to do |format|
      format.js   { render :layout => false }
    end
  end

  def downvote
    @answer = Answer.find(params[:id])
    @answer.downvote_by current_user
    respond_to do |format|
      format.js   { render :layout => false }
    end
  end

end
