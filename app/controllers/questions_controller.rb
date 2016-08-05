class QuestionsController < ApplicationController
  #skip authentication
  load_and_authorize_resource

  def index
    @questions = @questions.paginate(page: params[:page], per_page: 10)
  end

  def show
    @answers = @question.answers.paginate(page: params[:page], per_page: 5)
  end

  def new
    @question = current_user.questions.build
  end

  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      flash[:success] = "Question posted."
      redirect_to @question
    else
      render 'new'
    end
  end

  def update
    if @question.update_attributes(question_params)
      flash[:success] = "Quetion updated!"
      redirect_to @question
    else
      render 'edit'
    end
  end

  def destroy
    @question.destroy
    flash[:success] = "Question deleted"
    redirect_to root_url
  end

  def upvote
    @question.upvote_by current_user
    respond_to do |format|
      format.js   { render :layout => false }
    end
  end

  def downvote
    @question.downvote_by current_user
    respond_to do |format|
      format.js   { render :layout => false }
    end
  end

  private
 
  def question_params
    params.require(:question).permit(:description, :explanation)
  end

end
