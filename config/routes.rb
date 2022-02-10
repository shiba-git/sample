Rails.application.routes.draw do
  get 'users/new'
  get  '/help',    to: 'static_pages#help'
  get  '/contact', to: 'static_pages#contact'
  get  './sign_up', to: 'users#new'
end
