Rails.application.routes.draw do
  get "/", to: "application#welcome"

  get "/shelters", to: "shelters#index"
  get "/shelters/new", to: "shelters#new"
  post "/shelters", to: "shelters#create"
  get "/shelters/:id", to: "shelters#show", as: :show_shelters
  get "/shelters/:id/edit", to: "shelters#edit"
  patch "/shelters/:id", to: "shelters#update"
  delete "/shelters/:id", to: "shelters#destroy"

  get "/pets", to: "pets#index"
  get "/pets/new", to: "pets#new", as: :new_pets
  post "/pets", to: "pets#create", as: :create_pets
  get "/pets/:id", to: "pets#show"
  get "/pets/:id/edit", to: "pets#edit", as: :edit_pets
  patch "/pets/:id", to: "pets#update", as: :pets_update
  delete "/pets/:id", to: "pets#destroy", as: :delete_pets

  get "/veterinary_offices", to: "veterinary_offices#index"
  get "/veterinary_offices/new", to: "veterinary_offices#new"
  get "/veterinary_offices/:id", to: "veterinary_offices#show"
  post "/veterinary_offices", to: "veterinary_offices#create"
  get "/veterinary_offices/:id/edit", to: "veterinary_offices#edit"
  patch "/veterinary_offices/:id", to: "veterinary_offices#update"
  delete "/veterinary_offices/:id", to: "veterinary_offices#destroy"

  get "/veterinarians", to: "veterinarians#index"
  get "/veterinarians/:id", to: "veterinarians#show"
  get "/veterinarians/:id/edit", to: "veterinarians#edit"
  patch "/veterinarians/:id", to: "veterinarians#update"
  delete "/veterinarians/:id", to: "veterinarians#destroy"

  get "/shelters/:shelter_id/pets", to: "shelters#pets"
  get "/shelters/:shelter_id/pets/new", to: "pets#new"
  post "/shelters/:shelter_id/pets", to: "pets#create"

  get "/veterinary_offices/:veterinary_office_id/veterinarians", to: "veterinary_offices#veterinarians"
  get "/veterinary_offices/:veterinary_office_id/veterinarians/new", to: "veterinarians#new"
  post "/veterinary_offices/:veterinary_office_id/veterinarians", to: "veterinarians#create"

  get "/applications", to: "applications#index", as: :applications
  get "/applications/new", to: "applications#new", as: :new_applications
  get "/applications/:id", to: "applications#show", as: :show_applications
  post "/applications", to: "applications#create", as: :create_applications
  patch "/applications/:id", to: "applications#update", as: :update_applications

  post "/application_pets", to: "application_pets#create", as: :create_application_pets
  patch "/application_pets/:id", to: "application_pets#update", as: :update_application_pets

  get "/admin/applications", to: "admin/applications#index", as: :admin_applications
  get "/admin/applications/:id", to: "admin/applications#show", as: :show_admin_applications

  get "/admin/shelters", to: "admin/shelters#index", as: :admin_shelters
  get "/admin/shelters/:id", to: "admin/shelters#show", as: :show_admin_shelters
end
