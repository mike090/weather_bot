# frozen_string_literal: true

class AboutHandler
  class << self
    def accept?(message)
      message.text.match?(%r{/about})
    end

    def handle(api, message)
      api.send_message chat_id: message.chat.id, text: 'Easy telegram bot, written with telegram-bot-ruby gem'
    end
  end
end

Dispatcher.handlers << AboutHandler
