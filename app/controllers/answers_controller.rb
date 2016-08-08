class AnswersController < ApplicationController
  load_and_authorize_resource

  # /questions/:question_id/answers
  def create
    @question = Question.find(params[:question_id])
    @answer.user = current_user
    @answer.question = @question
    @saved = false
    @answer.transaction do 
      if @answer.save
        if @question.update_attribute(:answers_count, @question.answers.count)
          @saved = true
          redirect_to question_path(@question)
        else
          flash[:error] = "Question answer count not updated!"
          respond_to do |format|
            format.js   { render :layout => false }
          end
        end
      else 
        respond_to do |format|
          format.js   { render :layout => false }
        end
      end
    end
  end

  # /questions/:question_id/answers/:id/upvote
  def upvote
    #@answer = Answer.find(params[:id])
    @answer.upvote_by current_user
    @answer.update_attribute(:upvotes_count, @answer.total_upvotes)
    respond_to do |format|
      format.js   { render :layout => false }
    end
  end

  # /questions/:question_id/answers/:id/downvote
  def downvote
    #@answer = Answer.find(params[:id])
    @answer.downvote_by current_user
    respond_to do |format|
      format.js   { render :layout => false }
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:content)
  end

end
