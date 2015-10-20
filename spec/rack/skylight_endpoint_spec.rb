require 'rack/lint'
require 'rack/mock'
require 'rack/skylight_endpoint'
require 'singleton'

describe Rack::SkylightEndpoint do
  module Skylight
    class Instrumenter
      attr_accessor :endpoint
      include Singleton

      def try(_)
        self
      end
    end
  end

  def env(url = '/', *args)
    Rack::MockRequest.env_for(url, *args)
  end

  let(:status) { subject[0] }
  let(:body) { str = ''; subject[2].each {|s| str += s }; str }

  let(:base_app) do
    lambda do |_|
      [200, { 'Content-Type' => 'text/plain' }, ["I'm base_app"]]
    end
  end

  let(:options) { {} }

  let(:app) do
    Rack::Lint.new(Rack::SkylightEndpoint.new(base_app, options))
  end

  before do
    Skylight::Instrumenter.instance.endpoint = 'skylight_endpoint'
  end

  describe 'with default options' do
    describe '/' do
      subject { app.call env('/') }

      it { expect(status).to eq(200) }
      it { expect(body).to eq("I'm base_app") }

      it 'should not change endpoint' do
        app.call env('/')
        expect(Skylight::Instrumenter.instance.endpoint)
          .to eq('skylight_endpoint')
      end
    end

    describe '/health_check' do
      it 'should keep status' do
        expect(app.call(env('/health_check'))[0]).to eq(200)
      end

      it 'should change endpoint' do
        app.call env('/health_check')
        expect(Skylight::Instrumenter.instance.endpoint)
          .to eq('health_check')
      end
    end
  end

  describe 'with custom options' do
    describe '/' do
      subject { app.call env('/') }

      it { expect(status).to eq(200) }
      it { expect(body).to eq("I'm base_app") }

      it 'should not change endpoint' do
        expect(Skylight::Instrumenter.instance.endpoint)
          .to eq('skylight_endpoint')
      end
    end

    describe '/custom_endpoint' do
      let(:options) { { path: '/custom_path', endpoint: 'custom_endpoint' } }

      subject { app.call env('/custom_path') }

      it { expect(status).to eq(200) }

      it 'should change endpoint' do
        app.call env('/custom_path')
        expect(Skylight::Instrumenter.instance.endpoint)
          .to eq('custom_endpoint')
      end
    end
  end
end
