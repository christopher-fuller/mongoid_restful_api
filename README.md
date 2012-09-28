# mongoid_restful_api

A gem that simplifies the creation of restful Rails APIs backed by [MongoDB](http://mongodb.org) via the [Mongoid](http://mongoid.org) ODM. Defining models and/or controllers in Rails is now entirely optional during development.

## Purpose

The purpose of this gem is to simplify development and does so by exploiting dynamic attributes in MongoDB and Mongoid and also the dynamic nature of Ruby itself. This gem sets up wildcard routing so all ALL top-level resourceful routes are enabled and work even if models and/or controllers have not yet been created in the Rails application. And since all attributes are accepted into the database (when the Mongoid setting `allow_dynamic_fields` is set to `true`), a focus on client-side javascript work is made possible during the initial phases of prototyping and development. Then later in the development lifecycle, before deploying to production, the wildcard routes must be removed and the Mongoid setting `allow_dynamic_fields` should be set to `false`, since these are both security concerns. The controllers that are created in the application can now simply extend `MongoidRestfulApiController` and do not require further logic unless additional or overridden functionality is desired.

## Disclaimer

Using this gem introduces a security concern in the Rails application. The `mongoid_restful_api_wildcard_routes` **must only be used during development**. Please follow the instructions below to understand the production deployment workflow and the `mongoid_restful_api_wildcard_routes` **must be removed before deploying to production**.

## Mongoid Version

This gem supports Mongoid version 3.0 and greater. Use tagged version 0.0.2 for older Mongoid back to 2.4.

## Installation

    $ gem install mongoid_restful_api

## Rails Configuration

Add to Gemfile:

    gem 'mongoid_restful_api'

### Mongoid Configuration

Set `allow_dynamic_fields` to `true` in the Mongoid configuration file.

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

Before deploying to production, set the Mongoid setting `allow_dynamic_fields` to `false` and then ensure all of the application's APIs are backed by actual models and controllers.

Remove `mongoid_restful_api_wildcard_routes` from the application's routes file and just follow normal Rails application development practices.

Meaning, for each of the application's APIs, add resourceful routes, create a corresponding controller, extending the `MongoidRestfulApiController` base class, and create a corresponding Mongoid model.

Example Routes:

    WidgetsApp::Application.routes.draw do

      resources :widgets

    end

Example Controller:

    class WidgetsController < MongoidRestfulApiController

      # no other code is necessary unless additional or overridden functionality is desired
      # the MongoidRestfulApiController extended class simply needs to exist

    end

Example Model:

    class Widgets

      include ::Mongoid::Document

      # rest of the model definition goes here

    end

## Copyright

Copyright (c) 2012 Christopher Fuller. See MIT-LICENSE for details.
