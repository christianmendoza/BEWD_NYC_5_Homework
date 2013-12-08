RewslyApp::Application.routes.draw do
  root "stories#index"
  get "stories/all", to: "stories#all"
  get "search/index"
  get "search", to: "search#index"
  resources :stories, only: [:index, :new, :create, :show]
end
