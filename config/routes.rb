# frozen_string_literal: true

Rails.application.routes.draw do

  root to: 'public/homes#top'

  devise_for :admin, controllers: {
    registrations: 'public/registrations',
    sessions: 'admin/sessions'
  }

  devise_for :users, controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

    scope module: :public do
      get "users/:id/posts" => "users#posts", as: 'user_posts'
      get "users/unsubscribe" => "users#unsubscribe"
      patch "users/withdraw" => "users#withdraw"
      patch "comments/:id/soft_destroy" => "comments#soft_destroy", as: 'comments_soft_destroy'
      patch "posts/:id/soft_destroy" => "posts#soft_destroy", as: 'posts_soft_destroy'

      #resources :posts do #ransackのsearchアクション追加
      #  collection do
      #    get 'search'
      #  end
      #end

      resources :homes, only: [:top]
      resources :users, only: %i[show edit update]
      resources :comments, only: %i[show index create edit update]
      resources :posts, only: %i[new show index create edit update] do
        get :favorites, on: :member
        resource :favorites, only: %i[create destroy] # 単数でURLにidを含めない
      end


  end

  namespace :admin do
    resources :homes, only: [:top]
    resources :users, only: %i[index edit update]
    resources :comments, only: %i[edit update]
    resources :posts, only: %i[index show edit update]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
