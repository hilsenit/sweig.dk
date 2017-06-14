Rails.application.routes.draw do

  devise_for :users
root "static_pages#index"
get "hvorfor" => "static_pages#why", as: "why"

resources :users do
	resources :works do
	put :sort, on: :collection
	get "skift-vaerks-status" => "users#toggle_status", as: "toggle-status"
	# get "show-navbar-cookie" => "works#navbar_cookie", as: "navbar-cookie"

	end
end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
