HealthData::Application.routes.draw do
  match "/health_histories/find_patient_chart" => "health_histories#find_patient_chart", via: [:get, :post] ,as: :find_patient_chart
  get "/health_histories/search_history/:patient_id" => "health_histories#search_history"
  post "/health_histories/charts" => "health_histories#charts"
  get "/health_histories/find_patient/:patient_name" => "health_histories#find_patient_id_by_name"
  delete "/health_histories/:month/delete" => "health_histories#destroy_by_month", as: :destroy_demo

  resources :health_histories do
  end

  resources :patients do
  end
root :to => 'health_histories#select_action'
end
