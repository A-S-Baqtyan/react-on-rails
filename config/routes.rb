Rails.application.routes.draw do
  get '/signin', to: 'v1/auth/sessions#signin'

  # Views apis
  # namespace :v1 do
  #   namespace :auth do
  #     get 'sessions/create'
  #     get 'sessions/destroy'
  #   end
  # end
  
  # Json apis
  namespace :v1 do
    namespace :apis do
      namespace :auth do
        resource :sessions, only: :create
      end
    end
  end
end
