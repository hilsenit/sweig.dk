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


  def generate_biblo_story_work_publish followed, work, type
    followed.followers.each do |user|
      user.stories << Story.create(story_type: type, t_other_friendly_id: followed.slug, t_other_username: followed.username, work_friendly_id: work.slug, work_title: work.title)
    end 
  end

  def generate_biblo_story_follow_user action_user, action_user_type, t_other_user, t_other_user_type
    binding.pry
    action_user.stories << Story.create(story_type: action_user_type, t_other_friendly_id: t_other_user.slug, t_other_username: t_other_user.username) # Du følger nu t_other_user.username
    t_other_user.stories << Story.create(story_type: t_other_user_type, t_other_friendly_id: action_user.slug, t_other_username: action_user.username) # Se du følges nu af user.username
    
  end


  def configure_permitted_parameters
  	added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
  	devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
  	devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
