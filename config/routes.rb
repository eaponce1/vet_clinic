Rails.application.routes.draw do
  devise_for :users

  # ROOT
  root "owners#index"

  # OWNERS
  resources :owners

  # PETS
  resources :pets

  # VETS
  resources :vets

  # APPOINTMENTS
  resources :appointments do
    collection do
      get :past
    end

    # TREATMENTS ANIDADOS
    resources :treatments, except: [:index, :show]
  end
end
