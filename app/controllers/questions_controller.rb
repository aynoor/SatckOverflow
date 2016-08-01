class QuestionsController < ApplicationController

  def index
    @questions = Question.paginate(page: params[:page], per_page: 10)
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    if user_signed_in?
      @question = Question.new  
    else
      render 'index'
    end
    #authorize! :new, @question
  end

  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id
    if @question.save
      flash[:success] = "Question posted."
      redirect_to action: :index
    else
      render 'new'
    end
    #authorize! :create, @question            #not needed?
  end

  private

  def question_params
    params.require(:question).permit(:description, :explanation)
  end

end
