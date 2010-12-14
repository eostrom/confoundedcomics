# This is an auto-generated file: don't edit!
# You can add your own routes in the config/routes.rb file
# which will override the routes in this file.

Comics::Application.routes.draw do


  # Resource routes for controller "pages"
  get 'pages(.:format)' => 'pages#index', :as => 'pages'
  get 'pages/:id(.:format)' => 'pages#show', :as => 'page', :constraints => { :id => %r([^/.?]+) }


  # Lifecycle routes for controller "users"
  post 'users/signup(.:format)' => 'users#do_signup', :as => 'do_user_signup'
  get 'users/signup(.:format)' => 'users#signup', :as => 'user_signup'
  put 'users/:id/reset_password(.:format)' => 'users#do_reset_password', :as => 'do_user_reset_password'
  get 'users/:id/reset_password(.:format)' => 'users#reset_password', :as => 'user_reset_password'

  # Resource routes for controller "users"
  get 'users/:id/edit(.:format)' => 'users#edit', :as => 'edit_user'
  get 'users/:id(.:format)' => 'users#show', :as => 'user', :constraints => { :id => %r([^/.?]+) }
  put 'users/:id(.:format)' => 'users#update', :as => 'update_user', :constraints => { :id => %r([^/.?]+) }
  delete 'users/:id(.:format)' => 'users#destroy', :as => 'destroy_user', :constraints => { :id => %r([^/.?]+) }

  # Show action routes for controller "users"
  get 'users/:id/account(.:format)' => 'users#account', :as => 'user_account'

  # User routes for controller "users"
  match 'login(.:format)' => 'users#login', :as => 'user_login'
  get 'logout(.:format)' => 'users#logout', :as => 'user_logout'
  match 'forgot_password(.:format)' => 'users#forgot_password', :as => 'user_forgot_password'

  namespace :admin do


    # Resource routes for controller "admin/books"
    get 'books(.:format)' => 'books#index', :as => 'books'
    get 'books/new(.:format)', :as => 'new_book'
    get 'books/:id/edit(.:format)' => 'books#edit', :as => 'edit_book'
    get 'books/:id(.:format)' => 'books#show', :as => 'book', :constraints => { :id => %r([^/.?]+) }
    post 'books(.:format)' => 'books#create', :as => 'create_book'
    put 'books/:id(.:format)' => 'books#update', :as => 'update_book', :constraints => { :id => %r([^/.?]+) }
    delete 'books/:id(.:format)' => 'books#destroy', :as => 'destroy_book', :constraints => { :id => %r([^/.?]+) }


    # Resource routes for controller "admin/pages"
    get 'pages(.:format)' => 'pages#index', :as => 'pages'
    get 'pages/new(.:format)', :as => 'new_page'
    get 'pages/:id/edit(.:format)' => 'pages#edit', :as => 'edit_page'
    get 'pages/:id(.:format)' => 'pages#show', :as => 'page', :constraints => { :id => %r([^/.?]+) }
    post 'pages(.:format)' => 'pages#create', :as => 'create_page'
    put 'pages/:id(.:format)' => 'pages#update', :as => 'update_page', :constraints => { :id => %r([^/.?]+) }
    delete 'pages/:id(.:format)' => 'pages#destroy', :as => 'destroy_page', :constraints => { :id => %r([^/.?]+) }

  end

end
