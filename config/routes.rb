Rails.application.routes.draw do
  namespace :admin do
    get 'customers/index'
    get 'customers/show'
    get 'customers/edit'
  end
  namespace :admin do
    get 'genres/index'
    get 'genres/edit'
  end
  devise_for :customers
  # ,skip: [:passwords],controllers: {
  #   registrations: "public/registrations",
  #   sessions: "public/sessions"
  # }
  get "admin" => "admin/homes#top"
  devise_for :admins
  # ,skip: [:registrations,:passwords],controllers: {
  #   sessions: "admin/sessions"
  # }
  namespace :admin do
    resources :items,except:[:destroy]
    resources :genres,except:[:new,:show,:destroy]
    resources :customers,except:[:new,:create,:destroy]
  end
end
