Rails.application.routes.draw do

root "static_pages#index"

resources :users do
	resources :works
end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
