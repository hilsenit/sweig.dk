Rails.application.routes.draw do



	devise_for :users, controllers: { confirmations: 'confirmations' }

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
	get "laes" => "static_pages#laes"
	get "benyt/:show_partial" => "static_pages#opret", as: "benyt"

	post "kontakt-os" => "static_pages#kontakt"	
	
	root "static_pages#index"

end
