require 'sidekiq/web'

Rails.application.routes.draw do
  resources :students
  resources :parents
  resources :families
  resources :staffs
  resources :schools
  resources :classrooms
  resources :subjects
  resources :activities
  devise_for :users

  get 'staffs/:id/activate', to: 'staffs#activate', as: 'activate_staff'
  get 'staffs/:id/deactivate', to: 'staffs#deactivate', as: 'deactivate_staff'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  mount Sidekiq::Web => '/sidekiq'
end
