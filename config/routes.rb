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
    resources :items, only: [:index, :show]
    resources :cart_items, only:[:index, :create, :update, :destroy] do
      collection do
        delete 'destroy_all', to: 'cart_items#destroy_all'
      end
    end
    resources :orders, only: [:new, :create, :index, :show] do
      collection do
        post 'confilm', to: 'orders#confilm'
        get 'success', to: 'orders#success'
      end
    end
    resources :addresses, only: [:create, :index, :edit, :update, :destroy]
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

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
