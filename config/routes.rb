Payback::Application.routes.draw do

  resources :groups do
    member do
      get 'leave'
      post 'invite'
    end

    collection do
      match 'join'
    end
  end

  match 'invitations/:token' => "groups#invitations", as: 'invitations'

  resources :users do
    member do
      get 'debts'
      get 'credits'
    end
  end

  match 'signup'  => 'users#new',     as: 'signup'
  match 'welcome' => 'users#welcome', as: 'welcome'

  resources :expenses do
    get 'condensed', on: :collection
  end
  match 'clear/:id' => 'expenses#clear', as: 'clear'

  resources :notifications, only: [:new, :create] do
    post 'read', on: :collection
  end

  resources :sessions, only: [:new, :create, :destroy]
  match 'login'  => 'sessions#new',     as: 'login'
  match 'logout' => 'sessions#destroy', as: 'logout'

  match 'start'     => 'static#start',     as: 'start'
  match 'not_found' => 'static#not_found', as: 'not_found'

  get 'contact'  => 'static#contact', as: 'contact'
  post 'contact' => 'static#mail',    as: 'contact'

  match 'forgot_password'       => 'sessions#forgot_password', as: 'forgot_password'
  match 'reset_password/:token' => 'sessions#reset_password',  as: 'reset_password'

  root :to => 'static#start'

  # Route page not found to 404 page
  match '*a' => 'static#not_found'

end
