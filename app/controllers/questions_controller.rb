class QuestionsController < ApplicationController

  def index
    @questions = Question.paginate(page: params[:page], per_page: 10)
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new  
    authorize! :new, @question
  end

  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id
    if @question.save
      flash[:success] = "Question posted."
      redirect_to @question
    else
      render 'new'
    end
  end

  def edit
    @question = Question.find(params[:id])
    authorize! :update, @question
  end

  def update
    @question = Question.find(params[:id])
    if @question.update_attributes(question_params)
      flash[:success] = "Quetion updated!"
      redirect_to @question
    else
      render 'edit'
    end
  end

  def destroy
    @question = Question.find(params[:id])
    authorize! :destroy, @question
    Question.find(params[:id]).destroy
    flash[:success] = "Question deleted"
    redirect_to root_url
  end

  def upvote
    @question = Question.find(params[:id])
    authorize! :upvote, @question
    @question.upvote_by current_user
    respond_to do |format|
      format.js   { render :layout => false }
    end
  end

  def downvote
    @question = Question.find(params[:id])
    authorize! :downvote, @question
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
