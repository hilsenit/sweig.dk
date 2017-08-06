Rails.application.routes.draw do


	# ADMIN
  	get 'admin/show'
  	get 'admin/edit'
  	get 'admin/vis-spoergsmål' => 'admin#edit_questions', as: :show_questions
  	#SPØRGSMÅL
  	resources :questions, except: :index do 
  		#STEMMER
	  	get 'stem-spoergsmaal/:vote_value' => 'votes#vote', as: :vote
	  	delete 'fjern-stemme/:vote_id' => 'votes#destroy', as: :delete_vote
  	end
	get "nyt" => "questions#index"
  	# DEVISE
	devise_for :users, skip: 'session', controllers: { registrations: 'registrations', sessions: 'sessions' }
	as :user do
	  get 'log-ind-her', to: 'devise/sessions#new', as: :new_user_session
	  post 'log-ind', to: 'devise/sessions#create', as: :user_session
	  delete 'log-ud-her', to: 'devise/sessions#destroy', as: :destroy_user_session
	end

	resources :users do
		get "gemte-vaerker" => "users#saved_works", as: "saved_works"
		resources :works do
			get "work/:current_user" => "users#save_work_for_current_user", as: "current_user_save"
			delete ":current_user" => "users#delete_saved_work", as: "delete_current_user_save"
			get "skift-vaerks-status" => "users#toggle_status", as: "toggle-status"

		end
	end

	get "soegefelt/resultat" => "static_pages#search", as: "search"

	get "laes-litteratur" => "static_pages#laes", as: "laes"
	get "opret-mig-nu" => "static_pages#oprettelse", as: "oprettelse"
	get "log-in" => "static_pages#log_in"

	post "kontakt-os" => "static_pages#kontakt"	
	
	root "static_pages#index"

end
