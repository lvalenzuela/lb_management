Rails.application.routes.draw do
  root 'requests#sent_requests'

  resources :courses do 
    collection do
      get "index"
      get "new"
      get "show"
      post "create"
      get "edit"
      post "update"
      post "cancel_course"
    end
  end

  resources :clients do
    collection do 
      get 'index'
      get 'manage_accounts'
      post 'create_account'
      get "new"
      get "edit"
      post "update"
      post "create_client"
      get "show_account"
      get "account_managers"
      post "modify_account_managers"
      post "assign_client"
      get "quotations"
      get "quotation_templates"
      get "generate_quotation"
      post "create_quotation_format"
      post "edit_quotation_format"
      get "set_default_format"
      get "new_quotation"
      get "edit_quotation"
      post "update_quotation"
      post "set_discount"
      get "show_quotation"
      post "create_quotation"
      get "new_products"
      post "create_product"
      delete "destroy_product"
      post "show_features"
    end
  end
 
  resources :moodle_courses do
    collection do
      get "index"
      post "assign"
      post "create_group"
      get "show_group"
      delete "destroy_group"
      post "assign_course"
      delete "destroy_assignation"
    end
  end

  resources :main do
    collection do
      get 'system_manager'
      post "assign_system_manager"
      delete "unassign_system_manager"
      get 'control_panel'
      get 'horarios'
      get 'area_manager'
      get 'area_dashboard'
      post 'assign_to_area'
      post 'modify_assignation'
      get 'extras'
      delete 'destroy'
      get "manage_products"
      get "new_product"
      get "edit_product"
      post "update_product"
      post "create_product"
      delete "delete_product"
      get "enable_product"
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
      get "course_groups"
      get "course_group_report"
      get "institution_department_report"
    end
  end

  resources :requests do
    collection do
      get 'index'
      get 'mark_solution'
      get 'confirm_solution'
      get "area_for_request"
      get 'new_request'
      post 'create_request'
      post 'filter_requests'
      post 'update'
      post 'filter_pending'
      post 'filter_resolved'
      post 'mark_with_tag'
      post 'create_tag'
      post "create_default_title"
      post "update_default_title"
      get "edit_default_title"
      get 'sent_requests'
      get 'filter_sent'
      get 'edit_request'
      get 'show'
      get 'area_requests'
      get "manage_area_requests"
      post 'assign_requests'
      delete 'destroy'
      delete "destroy_default_title"
    end
  end

  resources :request_notes do
    collection do 
      get "show"
      post "create"
      get "edit"
      post "update"
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
