# mongoid_restful_api

A gem that simplifies the creation of restful APIs backed by [MongoDB](http://mongodb.org) via the [Mongoid](http://mongoid.org) ODM. Defining models and/or controllers in Rails is optional during development.

## Disclaimer

The purpose of this gem is to simplify development and does so by exploiting dynamic attributes in MongoDB and Mongoid and also the dynmaic nature of Ruby itself. Using the `mongoid_restful_api_wildcard_routes` introduces a major security issue in the applicaiton and should **only be used during development**. Once the `mongoid_restful_api_wildcard_routes` are removed (before deploying the application to production) and models are created for each the application's APIs, simply extending the `MongoidRestfulApiController` does not introduce any security issues. Please follow the instructions below to understand the production deployment workflow.

Since there are only two small source files that contain the bulk of the functionality of the gem, please take a moment to look them over and decide for yourself if the gem is right for your application.

## Mongoid Version

This gem supports Mongoid version 3.0 and greater. Use tagged version 0.0.2 for older Mongoid back to 2.4.

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

Now ALL top-level resourceful routes will route to the `MongoidRestfulApiController` base class.

For example, a GET request to `http://localhost:3000/widgets.json` will load all widget documents from the widgets collection in the database. And a POST request would create a widget document with all supplied attributes. Similarly, PUT and DELETE requests also work as expected. Requests to `http://localhost:3000/whatever.json`, meaning any top-level resourceful route, just work.

On each request, a Mongoid model is dynamically created on-the-fly, taking it's name from the route, so creating models during development is entirely optional. Or if an existing predefined model matches the name of the route, it will be used instead.

### Production Deployment Workflow

Before deploying to production, all of the application's APIs need to be backed by actual models and controllers.

First remove `mongoid_restful_api_wildcard_routes` from the application's routes file and just follow normal Rails application development practices.

Meaning, for each of the application's APIs, add `resources` routes, create a corresponding controller, extending the `MongoidRestfulApiController` base class, and create an actual Mongoid model.

Example Routes:

    WidgetsApp::Application.routes.draw do
      resources :widgets
    end

Example Controller:

    class WidgetsController < MongoidRestfulApiController
    end

Example Model:

    class Widgets
      include Mongoid::Document
    end

## Copyright

Copyright (c) 2012 Christopher Fuller. See MIT-LICENSE for details.
