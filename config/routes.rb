Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "callbacks" }
  root to: 'moods#new_smiley'
  get '/redirect', to: 'callbacks#redirect', as: 'redirect'
  get '/callback', to: 'callbacks#callback', as: 'callback'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :moods, only: [:index, :new, :create]

  get '/moods/calendar', to: 'moods#calendar', as: :calendar_moods
  get '/moods/habits', to: 'moods#habits', as: :habit_moods
  get '/moods/:date', to: 'moods#show', as: :date_moods
  get '/insights', to: 'moods#insights', as: :insights
  get '/moods/new/smiley', to: 'moods#new_smiley', as: :new_smiley_mood

  get '/qr_code', to: 'pages#qr_code', as: :display_qr_code

  resources :users, only: [:show]
  get '/users/:id/community', to: 'users#community', as: :community

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post 'callback', to: 'line_bot#callback'
    end
  end
end
