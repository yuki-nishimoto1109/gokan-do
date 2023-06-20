Rails.application.routes.draw do

  root to: 'homes#top'

  resources :users, only: [:create]
  resources :rooms, only: [:index, :show] do
    member do
      post "new"
      get "start"
      get "answer"
      get "vote"
      get "result"
      get "check"
      get "finish"
    end
    resources :votes,  only: [:create]
  end
  resources :answers, only: [:update]
  resources :rounds,  only: [:create]
end
