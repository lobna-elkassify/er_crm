ErCrm::Engine.routes.draw do
  resources :lead_categories, :path => :categories
  resources :departments

  root to: "dashboard#show"
end
