Rails.application.routes.draw do
  resources :courses
  resources :teachers
  resources :students
  resources :enrollments, only: :create
  resources :sessions, only: :create
  delete '/sessions' => 'sessions#destroy'
end
