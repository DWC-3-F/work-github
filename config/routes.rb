Rails.application.routes.draw do
  
  root to: 'public/homes#top'
  get "/about"=>"public/homes#about",as: 'about'
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  scope module: :public do
    get '/customers/my_page', to: 'customers#show'
    get '/customers/information/edit', to: 'customers#edit'
    get '/customers/check', to: 'customers#check'
    patch '/customers/withdraw', to: 'customers#withdraw'
    patch '/customers/information', to: 'customers#update'
    get 'addresses/index'
    get 'addresses/edit'
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:create, :index, :update, :destroy]
    delete '/cart_items/destory_all', to: 'cart_items#destroy_all'
    resources :orders, only: [:new, :create, :index, :show, :confilm, :success]
  end
  
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
}
  
  get '/admin', to: 'admin/homes#top'
  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:create, :index, :edit, :update]
    resources :items, only: [:new, :create, :index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end
  devise_for :users
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
