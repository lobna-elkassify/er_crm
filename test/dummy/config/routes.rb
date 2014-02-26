Rails.application.routes.draw do
  get "dashboard/show"
  mount ErCrm::Engine => "/crm"
end
