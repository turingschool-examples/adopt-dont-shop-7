Rails.application.routes.draw do
  get '/', to: 'application#welcome'

  get '/applicants', to: 'applicants#index', as: 'applicants'
  get '/applicants/:id/search', to: 'applicants#search', as: 'applicant_search'
  get '/applicants/new', to: 'applicants#new', as: 'new_applicant'
  get '/applicants/:id', to: 'applicants#show', as: 'applicant'
  post '/applicants', to: 'applicants#create', as: 'create_applicant'
  get '/applicants/:id/edit', to: 'applicants#edit', as: 'edit_applicant'
  patch '/applicants/:id', to: 'applicants#update', as: 'update_applicant'
  delete '/applicants/:id', to: 'applicants#destroy', as: 'delete_applicant'

  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  get '/shelters/:id', to: 'shelters#show'
  post '/shelters', to: 'shelters#create'
  get '/shelters/:id/edit', to: 'shelters#edit'
  patch '/shelters/:id', to: 'shelters#update'
  delete '/shelters/:id', to: 'shelters#destroy'

  get '/pets', to: 'pets#index'
  get '/pets/new', to: 'pets#new'
  get '/pets/:id', to: 'pets#show'
  get '/pets/:id/edit', to: 'pets#edit'
  patch '/pets/:id', to: 'pets#update'
  delete '/pets/:id', to: 'pets#destroy'

  get '/veterinary_offices', to: 'veterinary_offices#index'
  get '/veterinary_offices/new', to: 'veterinary_offices#new'
  get '/veterinary_offices/:id', to: 'veterinary_offices#show'
  post '/veterinary_offices', to: 'veterinary_offices#create'
  get '/veterinary_offices/:id/edit', to: 'veterinary_offices#edit'
  patch '/veterinary_offices/:id', to: 'veterinary_offices#update'
  delete '/veterinary_offices/:id', to: 'veterinary_offices#destroy'

  get '/veterinarians', to: 'veterinarians#index'
  get '/veterinarians/:id', to: 'veterinarians#show'
  get '/veterinarians/:id/edit', to: 'veterinarians#edit'
  patch '/veterinarians/:id', to: 'veterinarians#update'
  delete '/veterinarians/:id', to: 'veterinarians#destroy'

  get '/shelters/:shelter_id/pets', to: 'shelters#pets'
  get '/shelters/:shelter_id/pets/new', to: 'pets#new'
  post '/shelters/:shelter_id/pets', to: 'pets#create'

  get '/veterinary_offices/:veterinary_office_id/veterinarians', to: 'veterinary_offices#veterinarians'
  get '/veterinary_offices/:veterinary_office_id/veterinarians/new', to: 'veterinarians#new'
  post '/veterinary_offices/:veterinary_office_id/veterinarians', to: 'veterinarians#create'
end
