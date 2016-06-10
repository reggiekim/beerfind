require 'bundler/setup'
require "pg"
require "pry"
require "sinatra/base"
require "sinatra/reloader"
require "httparty"
require_relative "server"

run Sinatra::Server
