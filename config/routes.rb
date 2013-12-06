Rspp::Application.routes.draw do
  get "cp_business/create"
  get "cp_business/list"
  get "cp_business/destroy"
  get "cp_business/update"

  get "cp_business/submit_configure"
  get "cp_business/occupied"
  post "cp_business/submit_create"
  post "cp_business/submit_configure"

  get "cp_business/list_for_table"
  get "cp_business/configure"

  match "/cp_business/create/:id" => "cp_business#create", :as => :cp_business
  match "/cp_business/occupied/:spid/:cmd" => "cp_business#occupied", :as => :cp_business
  match "/cp_business/configure/:id" => "cp_business#configure", :as => :cp_business

  get "sp_business/create"
  get "sp_business/list"
  get "sp_business/destroy"
  get "sp_business/update"
  get "sp_business/list_for_table"
  get "sp_business/configure"

  match "/sp_business/configure/:id" => "sp_business#configure", :as => :sp_business
  match "/sp_business/list/:id" => "sp_business#list", :as => :sp_business


  get "cp_info/list"
  get "cp_info/create"
  get "cp_info/list_for_table"
  get "cp_info/configure"
  get "cp_info/assignment" , to: "cp_info#cmd_assignment"
  get "cp_info/list_for_assignment_table"
  post "cp_info/submit_configure"
  post "cp_info/submit_create"
  

  match "/cp_info/configure/:id" => "cp_info#configure", :as => :cp_info
  match "/cp_info/submit_configure/:id" => "cp_info#submit_configure", :as => :cp_info


  authenticated :user do
    root :to => 'cp#dashboard'
  end
  
  root :to => 'home#index'
  devise_for :users

  devise_for :users, :path => "usuarios", :path_names => { 
    :sign_in => 'login', 
    :sign_out => 'logout', 
    :password => 'secret', 
    :confirmation => 'verification', 
    :unlock => 'unblock', 
    :registration => 'register', 
    :sign_up => 'cmon_let_me_in' 
  }

  devise_for :admins

  post "sp_info/indexdata"
  get  "sp_info/list_for_table"
  get  "sp_info/list"
  get  "sp_info/create"
#  get  "sp_info/configure"
  post "sp_info/submit_create_spinfo"
  post "sp_info/submit_configure"
  post "sp_info/submit_create_and_configure_spinfo"

  match "/sp_info/configure/:id" => "sp_info#configure", :as => :sp_info
  match "/sp_info/submit_configure/:id" => "sp_info#submit_configure", :as => :sp_info

  post "report/statdata"
  post "report/stat_by_hour"
  get  "report/view_by_hour"
  get  "report/export_detail"
  post "report/stat_by_province"
  get  "report/view_by_province"
  post "report/get_detail_data"

  get  "report/stat"

  get  "report/detail"


  get "report/list_stat_for_table"
  get "report/list_detail_for_table"
  resource :sp_info

  post "report/moindex"
  get "report/moindex"
  get "report/mo"
  get "report/mt"
  get "report/ivr"
  get "report/alert"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
