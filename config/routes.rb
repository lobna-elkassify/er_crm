ErCrm::Engine.routes.draw do
  resources :leads
  resources :customers do
    member do
      post :update_single_attribute
    end
  end
  resources :lead_types
  resources :lead_categories
  resources :departments

  root to: "dashboard#show"
end
