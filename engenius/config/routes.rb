Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    get '/article'=> 'article#index'
    get 'article/show' => 'article#show'
    get '/category' => 'category#index'
end
