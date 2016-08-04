class QuestionsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy, :downvote, :upvote]

  def index
    @questions = Question.paginate(page: params[:page], per_page: 10)
  end

  def show
    @answers = @question.answers.paginate(page: params[:page], per_page: 5)
  end

  def new
    @question = current_user.questions.build
    authorize! :new, @question
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

  def edit
    authorize! :update, @question
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
    authorize! :destroy, @question
    Question.find(params[:id]).destroy    #@question.destroy
    flash[:success] = "Question deleted"
    redirect_to root_url
  end

  def upvote
    authorize! :upvote, @question
    @question.upvote_by current_user
    respond_to do |format|
      format.js   { render :layout => false }
    end
  end

  def downvote
    authorize! :downvote, @question
    @question.downvote_by current_user
    respond_to do |format|
      format.js   { render :layout => false }
    end
  end

  def score
    respond_to do |format|
      format.js   { render :layout => false }
    end
  end

  private

  def find_post 
    @question = Question.find(params[:id])
  end 
  def question_params
    params.require(:question).permit(:description, :explanation)
  end

end
