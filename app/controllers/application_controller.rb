class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # include TitleInHeader


  before_action :set_session_social

  def set_session_social
  	session[:social] = params[:q] if params[:q]
  end
end
