Rails.application.routes.draw do
  devise_for :customers,skip: [:passwords],controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  scope module: :public do
    root to: "homes#top"
    get 'about' => "homes#about",as: "about"
    resources :items,only:[:index,:show]
    scope :customers do
      get 'mypage' => 'customers#show',as: "mypage"
      get 'information/edit' => 'customers#edit',as: "edit_customers"
      patch 'information' => 'customers#update'
      get 'confirm' => 'customers#confirm',as: "confirm_customers"
      patch 'withdraw' => 'customers#withdraw'
    end
    resources :cart_items,except:[:new,:show,:edit] do
      collection do
        delete "all_destroy"
      end
    end
    resources :orders,except:[:edit,:update,:destroy] do
      collection do
        post 'comfirm'
        get 'complete'
      end
    end
    resources :addresses,except:[:new,:show]
  end
  devise_for :admin,skip: [:registrations,:passwords],controllers: {
    sessions: "admin/sessions"
  }
  namespace :admin do
    root to: "homes#top"
    resources :items,except:[:destroy]
    resources :genres,except:[:new,:show,:destroy]
    resources :customers,except:[:new,:create,:destroy]
    get "orders/:id" => "orders#show",as: "order"
    patch "orders/:id" => "orders#update_status",as: "update_status"
    patch "order_datails/:id" => "orders#update_making_process",as: "update_making_process"
  end
end