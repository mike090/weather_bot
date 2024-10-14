# frozen_string_literal: true

ENV['BOT_ENV'] ||= 'development'

require 'bundler/setup'
Bundler.require(:default, ENV.fetch('BOT_ENV', nil))

require 'dotenv/load'
require_relative '../app/services/open_weather_loader'

OPEN_WEATHER_API_KEY = ENV.fetch('OPEN_WEATHER_API_KEY', nil)
BOT_TOKEN = ENV.fetch('BOT_TOKEN', nil)
