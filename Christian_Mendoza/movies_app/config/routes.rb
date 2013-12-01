MoviesApp::Application.routes.draw do
  root "movies#index"
  get "search/index"
  get "search", to: "search#index"
  
  # these are special :index, :create, :new, :edit, :show, :update, :destroy
  resources :movies #, only: [:index, :create, :new, :edit, :show, :update, :destroy]
end
