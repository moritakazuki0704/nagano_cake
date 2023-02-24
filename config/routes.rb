Rails.application.routes.draw do
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
    get "orders/:id" => "orders#show",as: "order"
    patch "orders/:id" => "orders#update_status",as: "update_status"
    patch "order_datails/:id" => "orders#update_making_process",as: "update_making_process"
  end
end