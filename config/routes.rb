Rails.application.routes.draw do
  get 'cod_accounts/cc_date'
  get 'cod_accounts/selected'
  get 'cod_accounts/accounts'
  get 'cod_accounts/verified'
  resources :cod_accounts
  devise_for :users
  devise_scope :user do
    get '/signout', to: 'devise/sessions#destroy', as: :signout
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'cod_accounts#cc_date'
end
