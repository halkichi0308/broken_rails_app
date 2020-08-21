Rails.application.routes.draw do

  root to: 'top#index'
  get '/top', to: 'top#index'


  # resources でやったほうが rails の作法に則っています
  # その関係で、 /upload/index ではなく、 /upload にパスが変わってしまってます
  # 
  # delete は get なので delete パラメータを追加しています
  # 参考: https://railsguides.jp/routing.html#%E3%82%B3%E3%83%AC%E3%82%AF%E3%82%B7%E3%83%A7%E3%83%B3%E3%83%AB%E3%83%BC%E3%83%86%E3%82%A3%E3%83%B3%E3%82%B0%E3%82%92%E8%BF%BD%E5%8A%A0%E3%81%99%E3%82%8B
  # 
  # 
  # resources: upload, only: [:index, :create]
  # 生成されたルーティング
  # - get 'upload', to: 'upload#index'
  # - post 'upload', to: 'upload#create'
  #
  #   collection do 
  #     get 'delete', to: 'upload#delete'
  #   end
  # 生成されたルーティング
  # - get 'upload/delete', to: 'upload#delete'
  resources :upload, only: [:index, :create] do
    collection do
      get 'delete', to: 'upload#delete'
    end
  end


  # ProductsController は rails の標準に則ってメソッド定義されていたので、 resources で定義しています
  # ReviewModel は ProductModel を親に持つので、ネストして定義しました。
  #
  # resources :products do
  # 生成されたルーティング（省略）
  #
  #   resources :reviews, only: [:index, :create] do
  # 生成されたルーティング
  # - get 'products/:product_id/reviews', to: 'reviews#index'
  # - post 'products/:product_id/reviews', to: 'reviews#create'
  # - get  'products/:product_id/reviews/list', to: 'reviews#list'
  #
  resources :products do
    resources :reviews, only: [:index, :create] do
      collection do
        get 'list', to: 'reviews#list'
      end
    end
  end

  resources :mypage, only: [:index] do
    collection do
      get 'history', to: 'mypage#history'
    end
  end


  namespace :admin do
      resources :users
      resources :products do
        collection do
          post :upload
        end
      end
      resources :histories
      resources :reviews
      
      root to: 'users#index'
    end
  match 'admin/login', to: 'admin#login', via: [:get, :post]
  

  get '/cart', to: 'cart#index'
  get '/cart/confirm', to: 'cart#submit'
  get '/cart/:id', to: 'cart#cart'

  devise_for :users, controllers: {
    sessions:      'user/sessions',
  }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
