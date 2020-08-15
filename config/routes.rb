Rails.application.routes.draw do
  get 'upload/index'
  post 'upload/new'
  get 'upload/delete'
  get "product/list"
  get "products/:id" => "products#show"
  post 'review/new/:id' => "review#new"
  get 'review/new/:id' => "products#show"
  get 'review/list'
  post 'review/create'
  get 'mypage/index'
  get 'mypage/history'
  namespace :admin do
      resources :users
      resources :products do
        collection do
          post :upload
        end
      end
      resources :histories
      resources :reviews
      
      root to: "users#index"
    end
  match "admin/login", to: "admin#login", via: [:get, :post]
  
  get 'cart/purchase'
  get "/cart" => "cart#index"
  get "cart/confirm" => "cart#submit"
  get "cart/:id/" => "cart#cart"

  get "admin/users"
  get "item/list"
  devise_for :users, controllers: {
    sessions:      'user/sessions',
  }
  devise_scope :user do
    get "/users/sign_out" => "devise/sessions#destroy"
  end
  get "top/index"
  root to: "top#index"
  get 'matelpage/index' => 'matelpage#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
