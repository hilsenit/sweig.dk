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


  def generate_biblo_story_work_publish followed, work
    followed.followers.each do |user|
      user.stories << Story.create(story_type: "work", t_other_friendly_id: followed.slug, t_other_username: followed.username, work_friendly_id: work.slug, work_title: work.title)
    end 
  end

  def generate_biblo_follow action_user, t_other_user
    action_user.stories << Story.create(story_type: "following", t_other_friendly_id: t_other_user.slug, t_other_username: t_other_user.username) # Du følger nu t_other_user.username
    t_other_user.stories << Story.create(story_type: "followed", t_other_friendly_id: action_user.slug, t_other_username: action_user.username) # Se du følges nu af user.username
    
  end

  def generate_biblo_save action_user, t_other_user, work_friendly_id, work_title
    action_user.stories << Story.create(story_type: "saved_work", t_other_friendly_id: t_other_user.slug, t_other_username: t_other_user.username, work_friendly_id: work_friendly_id, work_title: work_title) # Du har gemt det her værk
    t_other_user.stories << Story.create(story_type: "work_saved", t_other_friendly_id: action_user.slug, t_other_username: action_user.username, work_friendly_id: work_friendly_id, work_title: work_title) # "BIIIB" har gemt dit værk "værktitle"
  end

  def destroy_biblo_stories
    
  end

  def configure_permitted_parameters
  	added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
  	devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
  	devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
