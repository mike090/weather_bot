# frozen_string_literal: true

require_relative 'config/environment'
require 'telegram/bot'

class Dispatcher
  class << self
    attr_accessor :default_handler

    def handlers
      @handlers ||= []
    end

    def dispatch(api, message)
      handler = handlers.select { |hnd| hnd.accept? message }.first
      handler ||= default_handler
      handler&.handle api, message
    end
  end
end

Dir.glob './app/handlers/*rb', &method(:require)

if __FILE__ == $PROGRAM_NAME
  Telegram::Bot::Client.run(BOT_TOKEN) do |bot|
    bot.listen do |message|
      Dispatcher.dispatch(bot.api, message)
    end
  end
end
