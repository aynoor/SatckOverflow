class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:secret]
  
  def index
    @users = User.paginate(page: params[:page])
    @pages = Page.paginate(page: params[:page])
  end
  
end
