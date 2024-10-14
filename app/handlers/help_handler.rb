# frozen_string_literal: true

class HelpHandler
  class << self
    def accept?(message)
      message.text.match?(%r{/help})
    end

    def handle(api, message)
      api.send_message chat_id: message.chat.id,
                       text: 'Отправьте мне название города, чтобы узнать какая там сейчас погода'
    end
  end
end

Dispatcher.handlers << HelpHandler
