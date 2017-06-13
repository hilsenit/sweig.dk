Rails.application.routes.draw do

root "static_pages#index"
get "hvorfor" => "static_pages#why", as: "why"

resources :users do
	resources :works do

	get "skift-vaerks-status" => "users#toggle_status", as: "toggle-status"
	get "gem-vaerk" => "users#save_work", as: "save_work"
	delete "fjern-gemt-vaerk" => "users#remove_saved_work", as: "remove_saved_work" 
	
	end
end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
