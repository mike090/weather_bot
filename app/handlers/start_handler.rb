# frozen_string_literal: true

class StartHandler
  class << self
    def accept?(message)
      message.text.match?(%r{/start})
    end

    def handle(api, message)
      api.send_message chat_id: message.chat.id, text: 'Доступные команды: /start, /help, /about'
      api.send_message chat_id: message.chat.id, text: 'Или отправьте город, погода в котором Вас интересует'
    end
  end
end

Dispatcher.handlers << StartHandler
