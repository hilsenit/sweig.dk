Rails.application.routes.draw do



  devise_for :users
resources :users do
	resources :works do
		get ":current_user" => "users#save_work_for_current_user", as: "current_user_save"
		get "skift-vaerks-status" => "users#toggle_status", as: "toggle-status"
	# get "show-navbar-cookie" => "works#navbar_cookie", as: "navbar-cookie"

	end
end


root "static_pages#index"

end
