ErCrm::Engine.routes.draw do
  resources :customers
  resources :lead_types
  resources :lead_categories
  resources :departments

  root to: "dashboard#show"
end
