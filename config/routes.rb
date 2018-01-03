Rails.application.routes.draw do

  # COOKIE
  # post 'set-update-shown-cookie' => 'application#set_update_shown_cookie', as: :set_cookie

  get 'not_found' => 'application#not_found'
  get 'moede-raad' => 'static_pages#moede-raad'
  get 'kontakt' => 'static_pages#kontakt_vindue'
  post 'kontakt' => 'static_pages#kontakt'

  get 'fremtidsvision' => 'static_pages#fremtidsvision'
  get 'info' => 'static_pages#info'
  # NOT LOGGED IN MODAL
  get 'log-in-eller-opret-dig/:message' => 'shared#not_logged_in', as: :not_logged_in, message: /.*/

  get 'laes' => 'static_pages#laes'
  get 'find/nyeste' => 'static_pages#nyeste', as: :nyeste
  get 'find/alle-maerker' => 'static_pages#alle_maerker', as: :alle_maerker
  get 'find/alle-maerker/:maerker_id' => 'static_pages#show_maerke_works', as: :show_maerke_works
  get 'find/alle-maerker-vis/:maerker_id' => 'static_pages#show_maerke_works_link', as: :show_this_maerker

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
    get 'log-ind-her', to: 'sessions#new', as: :new_user_session
    post 'log-ind', to: 'devise/sessions#create', as: :user_session
    delete 'log-ud-her', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  resources :users do
    member do
      get :followers, :following, :follow, :unfollow
    end

    get 'din-biblo' => 'users#biblo', as: :biblo
    get 'din-biblo/:story_count' => 'stories#load_more', as: :load_stories

    get 'mine-tekster' => 'users#my_works', as: :my_works
    get "gemte-vaerker" => "users#saved_works", as: "saved_works"
    get 'skift-gemte-vaerkers-visning' => 'users#toggle_saved_works_publicity', as: :saved_works_publicity
    resources :works do
      get "work/:current_user" => "users#save_work_for_current_user", as: "current_user_save"
      delete ":current_user" => "users#delete_saved_work", as: "delete_current_user_save"
      get "skift-vaerks-status" => "users#toggle_status", as: "toggle-status"
    end
    resources :stories, only: :destroy

  end

  get "soegefelt/resultat" => "static_pages#search", as: "search"
  get "velkommen" => "static_pages#index", as: :forside
  root "static_pages#redirect"

end
