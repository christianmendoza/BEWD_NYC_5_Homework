RewslyApp::Application.routes.draw do
  root "stories#index"
  get "search/index"
  get "search", to: "search#index"
  resources :stories, only: [:index, :new, :create, :show]
end
