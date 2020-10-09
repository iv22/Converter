Rails.application.routes.draw do
  get 'rate/index'
  get 'rate', to: 'rate#index'
  get 'rate/load'
  post 'rate/load'
  root to: 'converter#index'
  get 'converter/index'
  post 'converter/convert'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
