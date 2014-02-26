ErCrm::Engine.routes.draw do
  root to: "dashboard#show"
  resources :departments
end
