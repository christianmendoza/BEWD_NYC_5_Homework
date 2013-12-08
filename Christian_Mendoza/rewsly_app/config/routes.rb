RewslyApp::Application.routes.draw do
  root "stories#index"
  resources :stories, only: [:index, :show]
end
