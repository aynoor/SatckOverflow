class AnswersController < ApplicationController
  def show
  end

  def index
    @answers = Answer.paginate(page: params[:page], per_page: 5)
   #@answers = @questions.answers
  end

  def new
    @answer = Answer.new  
    respond_to do |format|
      format.js   { render :layout => false }
    end
    #authorize! :new, @answer
  end

  def create
    @answer = Answer.new(answer_params)
    @answer.question_id = params[:id]
    if @answer.save
      flash[:success] = "Answer posted."
      redirect_to @question
    else
      redirect_to questions_path
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:ans_description)
  end

end
