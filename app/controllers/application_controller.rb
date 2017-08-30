class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
  # include TitleInHeader
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_session_social

  def after_sign_in_path_for(resource)
    user_biblo_path(current_user.friendly_id)
  end

  def set_session_social
  	session[:social] = params[:q] if params[:q]
  end

  protected


  def generate_biblo_site_for_followers followed, work, type
    followed.followers.each do |user|
      user.stories << Story.create(story_type: type, fol_id: followed.id, fol_username: followed.username, work_id: work.id, work_title: work.title)
    end 
  end


  def configure_permitted_parameters
  	added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
  	devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
  	devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
