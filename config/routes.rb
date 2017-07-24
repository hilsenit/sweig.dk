Rails.application.routes.draw do



	devise_for :users, skip: 'session', controllers: { registrations: 'registrations', sessions: 'sessions' }
	# Jeg navngiver mine egne
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

	get "search/tag" => "static_pages#search", as: "search"

	get "nyt" => "static_pages#nyt"
	get "laes-litteratur" => "static_pages#laes", as: "laes"
	get "opret-mig-nu" => "static_pages#oprettelse", as: "oprettelse"
	get "log-in" => "static_pages#log_in"

	post "kontakt-os" => "static_pages#kontakt"	
	
	root "static_pages#index"

end
