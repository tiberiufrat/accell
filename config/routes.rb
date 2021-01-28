require 'sidekiq/web'

Rails.application.routes.draw do
  resources :observations
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
  get 'students/:id/remove_student_from_classroom/:classroom_id', to: 'students#remove_student_from_classroom', as: 'remove_student_from_classroom'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  mount Sidekiq::Web => '/sidekiq'
end
