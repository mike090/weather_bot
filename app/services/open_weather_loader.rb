# frozen_string_literal: true

class OpenWeatherLoader
  class << self
    def call(city, **options)
      options = { units: 'metric', lang: 'ru' }.merge options
      data = client.current_weather city:, **options
      { status: :success, data: }
    rescue Faraday::ConnectionFailed
      { status: :error, message: 'удаленный сервис не ответил' }
    rescue Faraday::ResourceNotFound
      { status: :error, message: 'не известно о таком городе' }
    rescue StandardError
      { status: :error, message: 'что-то пошло не так... ¯\_(ツ)_/¯' }
    end

    def client
      OpenWeather::Client.new api_key: OPEN_WEATHER_API_KEY
    end
  end
end
