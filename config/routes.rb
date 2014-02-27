ErCrm::Engine.routes.draw do
  resources :lead_types
  resources :lead_categories
  resources :departments

  root to: "dashboard#show"
end
