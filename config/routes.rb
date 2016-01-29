Rails.application.routes.draw do
  get '/', to: 'home#index'

  get '/register', to: 'home#register', as: 'users'
  post '/register', to: 'home#create'
  get '/login', to: 'home#login'
  post '/login_attempt', to: 'home#login_attempt'
  get '/logout', to: 'home#logout'
  post '/create', to: 'home#create'
  root 'home#index'
  get 'product/new', to: 'product#new', as: 'products'
  post 'product/new', to: 'product#create'
  get 'product/edit', to: 'product#edit', as: 'product'
  patch 'product/edit.:id', to: 'product#update'
  delete 'product/destroy.:id', to: 'product#destroy', as: 'product_destroy'
  get 'product/view', to: 'product#view'
  post 'product/view', to: 'product#add'
  post 'product/buy', to: 'product#buy'
  get '/view_cart', to: 'product#view_cart'
  post '/view_cart', to: 'product#check_out'
  get '/orders/all', to: 'product#view_orders'

end
