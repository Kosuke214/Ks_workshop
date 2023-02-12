# frozen_string_literal: true

Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }

  devise_for :users, skip: [:passwords], controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions'
  }
  
  root to: "public/homes#top"

  scope module: :public do
    resources :homes, only: [:top]
    resources :users, only: [:show, :edit, :update, :unsubscribe, :withdraw]
    resources :comments, only: [:show, :index, :create, :edit, :update, :destroy]
    resources :posts, only: [:new, :show, :index, :create, :edit, :update, :destroy]
    resources :favorites, only: [:show, :create, :update]

  end


  namespace :admin do
    resources :homes, only: [:top]
    resources :users, only: [:index, :edit, :update]
    resources :comments, only: [:edit, :update]
    resources :posts, only: [:index, :show, :edit, :update]

  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
