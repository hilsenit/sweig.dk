Rails.application.routes.draw do

	# NOT LOGGED IN MODAL
	get 'log-in-eller-opret-dig/:message' => 'shared#not_logged_in', as: :not_logged_in, message: /.*/
				
	get 'find' => 'static_pages#find'
	get 'find/nyeste' => 'static_pages#nyeste', as: :nyeste
	get 'find/alle-maerker' => 'static_pages#alle_maerker', as: :alle_maerker
	get 'find/alle-maerker/:maerker_id' => 'static_pages#show_maeker_works', as: :show_maerke_works

	# ADMIN
  	get 'admin' => 'admin#show', as: "admin"
  	get 'admin/edit', as: "rediger_admin"
  	get 'admin/vis-spoergsmål' => 'admin#edit_questions', as: :show_questions
  	#SPØRGSMÅL
  	resources :questions, path: "afstemning", except: :index do 
  		#STEMMER
	  	get 'stem-spoergsmaal/:vote_value' => 'votes#vote', as: :vote
	  	delete 'fjern-stemme/:vote_id' => 'votes#destroy', as: :delete_vote
		resources :comments
  	end
	get "stem" => "questions#index"
  	# DEVISE
	devise_for :users, skip: 'session', controllers: { registrations: 'registrations', sessions: 'sessions' }
	as :user do
	  get 'log-ind-her', to: 'devise/sessions#new', as: :new_user_session
	  post 'log-ind', to: 'devise/sessions#create', as: :user_session
	  delete 'log-ud-her', to: 'devise/sessions#destroy', as: :destroy_user_session
	end

	resources :users, except: :show do
		member do 
			get :followers, :following, :follow, :unfollow
		end

		get 'biblo' => 'users#show', as: :biblo
		get 'mine-tekster' => 'users#my_works', as: :my_works
		get "gemte-vaerker" => "users#saved_works", as: "saved_works"
		resources :works do
			get "work/:current_user" => "users#save_work_for_current_user", as: "current_user_save"
			delete ":current_user" => "users#delete_saved_work", as: "delete_current_user_save"
			get "skift-vaerks-status" => "users#toggle_status", as: "toggle-status"
		end
	end

	get "soegefelt/resultat" => "static_pages#search", as: "search"

	post "kontakt-os" => "static_pages#kontakt"	
	
	root "static_pages#index"

end
