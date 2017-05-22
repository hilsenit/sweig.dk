Rails.application.routes.draw do

root "static_pages#index"
get "hvorfor" => "static_pages#why", as: "why"

resources :users do
	resources :works do
	get "toggle_status" => "users#toggle_status", as: "toggle-status"
	end
end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
