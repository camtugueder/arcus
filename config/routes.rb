Rails.application.routes.draw do
  devise_for :users, path: '',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               registration: 'signup'
             },
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             }
  resources :courses
  resources :teachers
  resources :students
  resources :enrollments, only: :create
  resources :sessions, only: :create
  delete '/sessions' => 'sessions#destroy'
  # must be the last entry as it'll catch any other paths and return a 404 json
  match '*path', to: 'application#not_found', via: :all
end
