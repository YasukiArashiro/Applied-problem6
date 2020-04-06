Rails.application.routes.draw do
  get 'users/show'
  get 'homes/top'
  get 'home/about' => "homes#about"

  root to: "homes#top"

  devise_for :users, :controllers => {
   :registrations => 'users/registrations',
   :sessions => 'users/sessions'
 }


 delete '/books/:book_id/favorites', to: 'favorites#destroy' ,as: :favorite_delete

 resources :users, only: [:index, :show, :edit, :update] do
  resource :relationships, only: [:create, :destroy] do
    member do
      get :follows
      get :followers
    end
  end
end


resources :books, only: [:index, :show, :create, :edit, :update, :destroy] do
  resources :favorites, only: [:create, :destory]
  resource :book_comments, only: [:create, :destroy]
end

resource :search, only: [:serch_user, :search_book] do
  collection do
    get 'search'
    get 'search_user'
    get 'search_book'
  end
end

end
