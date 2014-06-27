Rails.application.routes.draw do
  root 'requests#sent_requests'
 
  resources :main do
    collection do
      get 'control_panel'
      get 'horarios'
      get 'area_manager'
      get 'extras'
    end
  end

  resources :notifications do
    collection do
      get 'index'
      get 'new'
      delete 'destroy'
      get 'edit'
      get 'read'
      post 'search'
      get 'show'
    end
  end

  resources :reports do
    collection do
      get 'index'
      get 'clients'
      get 'courses'
      get 'members'
      get 'reporte_preliminar'
      get 'user_report'
      get 'bulk_user_reports'
      get 'group_report'
      get 'show'
      get 'historical'
      get 'reports_for_course'
    end
  end

  resources :requests do
    collection do
      get 'index'
      get 'mark_solution'
      get 'confirm_solution'
      post 'create_request'
      post 'filter_requests'
      post 'update'
      post 'filter_pending'
      post 'filter_resolved'
      post 'mark_with_tag'
      post 'create_tag'
      get 'sent_requests'
      get 'new_request'
      get 'edit_request'
      get 'show'
      get 'area_requests'
      get 'filter_area_requests'
      post 'assign_requests'
      delete 'destroy'
    end
  end

  resources :users do
    collection do 
      get 'index'
      get 'course_members'
      post 'login'
      get 'logout'
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
