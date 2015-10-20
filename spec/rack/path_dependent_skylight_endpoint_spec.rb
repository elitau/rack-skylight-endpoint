require 'rack/lint'
require 'rack/mock'
require 'rack/path_dependent_skylight_endpoint'

describe Rack::PathDependentSkylightEndpoint do
  let(:base_app) do
    lambda do |env|
      [200, {'Content-Type' => 'text/plain'}, ["I'm base_app"]]
    end
  end

  describe 'with default options' do
    describe '/' do
      subject { app.call env('/') }

      it { status.should == 200 }
      it { body.should == "I'm base_app" }
    end

    describe '/rack_health' do
      subject { app.call env('/rack_health') }

      it { status.should == 200 }
      it { body.should == 'Rack::Health says "healthy"' }
    end
  end

end
