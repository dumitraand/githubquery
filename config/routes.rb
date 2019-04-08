Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'git_hub#index'
  post "/" => "git_hub#search"
end
