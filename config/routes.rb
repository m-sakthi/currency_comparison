Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "pages#index"
  get '/api/compare_currency', to: "pages#compare_currency"
end
