require 'sidekiq/web'

Rails.application.routes.draw do
  resources :announcements do
    resources :comments
  end
  resources :attendances
  resources :marks
  resources :observations
  resources :students
  resources :parents
  resources :families
  resources :staffs
  resources :schools
  resources :classrooms
  resources :subjects
  resources :activities
  resources :likes
  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :classrooms
      resources :schools
      resources :students
    end
  end

  get 'gradebook/:classroom_id', to: 'gradebooks#show_classroom', as: 'gradebook_classroom'
  get 'gradebook', to: 'gradebooks#index', as: 'gradebook'

  get 'user_activities/:id', to: 'user_activities#index', as: 'user_activities'

  get 'staffs/:id/activate', to: 'staffs#activate', as: 'activate_staff'
  get 'staffs/:id/deactivate', to: 'staffs#deactivate', as: 'deactivate_staff'

  get 'students/:id/remove_student_from_classroom/:classroom_id', to: 'students#remove_student_from_classroom', as: 'remove_student_from_classroom'
  get 'transfer_student_to_form', to: 'students#transfer_student_to_form', as: 'transfer_student_to_form'
  get 'add_student_to_optional_classroom', to: 'students#add_student_to_optional_classroom', as: 'add_student_to_optional_classroom'

  get 'staffs/:id/remove_staff_from_classroom/:classroom_id', to: 'staffs#remove_staff_from_classroom', as: 'remove_staff_from_classroom'

  get 'profile', to: 'profile#index', as: 'profile'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  mount Sidekiq::Web => '/sidekiq'
end
