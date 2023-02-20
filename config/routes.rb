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
end
