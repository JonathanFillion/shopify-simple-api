Rails.application.routes.draw do
	resources :articles
	get 'purchase', to: 'articles#purchase'

	root to: 'articles#index'
end
