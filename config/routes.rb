Rails.application.routes.draw do
  root 'requests#sent_requests'

  resources :dashboard do
    collection do
      get "courses_list"
      post "courses_list"
      get "course"
      get "student"
      get "teachers_list"
      post "teachers_list"
      get "teacher"
      post "teacher"
      get "configuration"
      post "update_alarm_parameters"
      get "edit_course_observation"
      post "update_course_observation"
      post "create_course_observation"
    end
  end

  resources :courses do 
    collection do
      get "search"
      get "index"
      get "new"
      get "show"
      post "create"
      get "edit"
      post "update"
      post "change_status"
      post "cancel_course"
      post "template_selector_options"
      post "product_selector_options"
      post "sessions_per_week_inputs"
      #inicialización del curso
      get "init_course_dialog"
      #templates
      get "course_templates"
      get "new_template"
      post "create_template"
      delete "delete_template"
      get "edit_template"
      post "update_template"
      get "template_details"
      post "update_template_sessions"
      get "edit_session_types"
      post "create_session_type"
      post "update_session_type"
      #detalles del curso
      get "assign_teacher"
      post "bind_course_teacher"
      get "course_students"
      post "create_student"
      post "update_student"
      get "enrolement_management"
    end
  end

  resources :clients do
    collection do 
      get "search"
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
      get "new_products"
      post "create_product"
      delete "destroy_product"
      post "show_features"
    end
  end
 
  resources :moodle_courses do
    collection do
      get "search"
      get "index"
      get "new_course_agrupation"
      post "assign"
      post "create_group"
      get "show_group"
      delete "destroy_group"
      post "assign_course"
      delete "destroy_assignation"
      get "courses_list"
      post "courses_list"
      post "set_template"
      get "course_calendar"
    end
  end

  resources :main do
    collection do
      get "search"
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
      get "teachers_manager"
      get "teacher_availability"
      get "zoho_product_list"
      get "course_modes"
      post "create_course_mode"
      post "update_course_mode"
      get "disable_course_mode"
      post "save_products"
      #calendario
      get "calendar_management"
      post "upload_holydays"
      #disponibilidad de usuarios
      post "set_user_disponibility"
      delete "delete_disponibility"
    end
  end

  resources :notifications do
    collection do
      get "search"
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
      get "search"
      get 'index'
      get 'clients'
      get 'courses'
      get "course_members"
      get "department_members"
      get 'reporte_preliminar'
      get 'user_report'
      get "course_bulk_user_reports"
      get "department_bulk_user_reports"
      get "course_report"
      get "department_report"
      get 'show'
      get 'historical'
      post "historical"
      get 'reports_for_course'
      get "course_groups"
      get "course_group_report"
      get "institution_department_report"
    end
  end

  resources :requests do
    collection do
      post "search"
      get 'index'
      get 'mark_solution'
      get "area_for_request"
      get 'new_request'
      get 'delete_request'
      post 'create_request'
      post 'filter_requests'
      post 'update'
      post "create_request_tag"
      post "update_request_tag"
      post "bulk_request_status_change"
      get "edit_request_tag"
      delete "destroy_request_tag"
      get 'sent_requests'
      get 'filter_sent'
      get 'edit_request'
      get 'show'
      get 'area_requests'
      get "manage_area_requests"
      post 'assign_requests'
      delete 'destroy'
    end
  end

  resources :request_notes do
    collection do
      get "search"
      get "show"
      post "create"
      get "edit"
      post "update"
    end
  end

  resources :users do
    collection do
      post "search"
      get 'index'
      get 'course_members'
      get "user_profile"
      post "change_profile_picture"
      post 'login'
      get 'logout'
      get 'not_authorized'
      #panel de usuarios
      get "my_calendar"
      get "my_courses"
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
