# frozen_string_literal: true

RSpec.describe OpenWeatherLoader do
  subject(:service_result) { described_class.call(city) }

  context 'when city exists' do
    let(:city) { 'Kazan' }

    it 'returns success with weather data' do
      VCR.use_cassette 'with_valid_city' do
        expect(service_result).to include(status: :success)
        expect(service_result).to include(data: Hashie::Trash)
      end
    end
  end

  context 'when city not exists' do
    let(:city) { 'Hogsmeade' }

    it 'returns error with exception' do
      VCR.use_cassette 'with_invalid_city' do
        expect(service_result).to include(status: :error)
        expect(service_result).to include(message: String)
      end
    end
  end
end
