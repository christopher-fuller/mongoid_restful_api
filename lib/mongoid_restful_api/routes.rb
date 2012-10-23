module ActionDispatch::Routing

  class Mapper

    def mongoid_restful_api_wildcard_routes
      json = { :format => :json }
      match ':model(.:format)'     => 'mongoid_restful_api#index'   , :via => :get    , :constraints => json
      match ':model(.:format)'     => 'mongoid_restful_api#create'  , :via => :post   , :constraints => json
      match ':model/:id(.:format)' => 'mongoid_restful_api#show'    , :via => :get    , :constraints => json
      match ':model/:id(.:format)' => 'mongoid_restful_api#update'  , :via => :put    , :constraints => json
      match ':model/:id(.:format)' => 'mongoid_restful_api#destroy' , :via => :delete , :constraints => json
    end

  end

end
