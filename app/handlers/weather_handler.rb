# frozen_string_literal: true

class WeatherHandler
  class << self
    def handle(api, message)
      api.send_message chat_id: message.chat.id, text: 'Секунду... уточняю...'
      remote_result = OpenWeatherLoader.call(message.text)
      message_text = if remote_result[:status] == :success
                       format_message(remote_result[:data])
                     else
                       "Не удалось получить данные: #{remote_result[:message]}"
                     end

      api.send_message chat_id: message.chat.id, text: message_text
    end

    def format_message(data)
      template = ERB.new <<~TEMPLATE
        Сейчас в городе <%= data.name %> <%= data.weather.first.description %>
        Температура воздуха <%= data.main.temp %> °C
        Ветер <%= data.wind.speed %> м/с
        Давление <%= data.main.pressure %> кПа
      TEMPLATE

      template.result(binding)
    end
  end
end

Dispatcher.default_handler = WeatherHandler
