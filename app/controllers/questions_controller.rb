class QuestionsController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:index, :show]
  
  load_and_authorize_resource

  # /questions
  def index
    @questions = @questions.paginate(page: params[:page], per_page: 10).order('answers_count DESC')
  end

  # /questions/:id
  def show
    @answers = @question.answers.paginate(page: params[:page], per_page: 5).order('upvotes_count DESC')
  end

  # /questions
  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      flash[:success] = "Question posted."
      redirect_to @question
    else
      render 'new'
    end
  end

  # /questions/:id
  def update
    if @question.update_attributes(question_params)
      flash[:success] = "Quetion updated!"
      redirect_to @question
    else
      render 'edit'
    end
  end

  # /questions/:id
  def destroy
    if @question.destroy
      flash[:success] = "Question deleted"
      redirect_to root_url
    else 
      redirect_to @question
    end
  end

  # /questions/:id/upvote
  def upvote
    @question.upvote_by current_user
    respond_to do |format|
      format.js   { render :layout => false }
    end
  end

  # /questions/:id/downvote
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
