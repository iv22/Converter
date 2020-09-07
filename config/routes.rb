Rails.application.routes.draw do
  root to: 'converter#index'
  get 'converter/index'
  post 'converter/convert'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
