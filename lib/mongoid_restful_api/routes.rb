module ActionDispatch::Routing

  class Mapper

    def mongoid_restful_api_wildcard_routes
      match ':model(.:format)'     => 'mongoid_restful_api#index'   , :via => :get
      match ':model(.:format)'     => 'mongoid_restful_api#create'  , :via => :post
      match ':model/:id(.:format)' => 'mongoid_restful_api#show'    , :via => :get
      match ':model/:id(.:format)' => 'mongoid_restful_api#update'  , :via => :put
      match ':model/:id(.:format)' => 'mongoid_restful_api#destroy' , :via => :delete
    end

  end

end
