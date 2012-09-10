# mongoid_restful_api

A gem that simplifies the creation of restful APIs backed by [MongoDB](http://mongodb.org) via the [Mongoid](http://mongoid.org) ODM. Defining models and/or controllers in Rails is optional during development.

## Disclaimer

The purpose of this gem is to simplify development and does so by exploiting dynamic attributes in MongoDB and Mongoid and also the dynmaic nature of Ruby itself. Using the `mongoid_restful_api_wildcard_routes` introduces a major security issue in the applicaiton and should **only be used during development**. Once the `mongoid_restful_api_wildcard_routes` are removed (before deploying the application to production) and models are created for each the application's APIs, there are no security issues when simply extending the `MongoidRestfulApiController`. Please follow the instructions below to understand the development to production workflow.

Since there are only two small source files that contain the bulk of the functionality of the gem, please take a moment to look them over and decide for yourself if the gem is right for your application.

## Installation

    $ gem install mongoid_restful_api

## Rails Configuration

Add to Gemfile:

    gem 'mongoid_restful_api'

## Usage

During development only, add `mongoid_restful_api_wildcard_routes` to the application's routes file.

Example Routes:

    WidgetsApp::Application.routes.draw do
      mongoid_restful_api_wildcard_routes
    end

Now ALL top-level resourceful routes will route to the `MongoidRestfulApiController` base class. And on each request, a Mongoid model will be dynmaically created on-the-fly, taking it's name from the route. Or if an existing predefined model matches the name of the route, it will be used instead. So creating models during development is entirely optional.

Before deploying to production, all of the application's APIs need to be backed by actual models and controllers. First remove `mongoid_restful_api_wildcard_routes` from the application's routes file and add actual `resources` routes for each of the APIs. Then create a corresponding controller, extending the `MongoidRestfulApiController` base class.

Example Routes:

    WidgetsApp::Application.routes.draw do
      resources :widgets
    end

Example Controller:

    class WidgetsController < MongoidRestfulApiController
    end

And finally, create actual Mongoid models corresponding to each of the application's API controllers.

Example Model:

    class Widgets
      include Mongoid::Document
    end

## Copyright

Copyright (c) 2012 Christopher Fuller. See MIT-LICENSE for details.
