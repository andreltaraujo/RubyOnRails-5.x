Rails.application.routes.draw do 
  namespace :site do
    get 'welcome/index'
    get 'search', to: 'search#questions'
    get 'subject', to: 'search#subject', as: 'search_subject'
    post 'answer', to: 'answer#question'

  end
  namespace :users_backoffice do
    get 'welcome/index'
    get 'profile', to: 'profile#edit'
    patch 'profile', to: 'profile#update'
  end
  
  namespace :admins_backoffice do
    get 'welcome/index'
    resources :admins 
    resources :subjects
    resources :questions
  end
  
  devise_for :admins, skip: [:registrations]
  devise_for :users

  root to: 'site/welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end