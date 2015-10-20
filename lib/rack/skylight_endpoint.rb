module Rack
  class SkylightEndpoint
    def initialize(app, options = {})
      @app = app
      @options = {
        path:     '/health_check',
        endpoint: 'health_check',
      }.merge(options)
    end

    def call(env)
      if env['PATH_INFO'] == @options[:path]
        status, headers, body = @app.call(env)
        trace = Skylight::Instrumenter.instance.try(:current_trace)
        trace.endpoint = @options[:endpoint] if trace
        [status, headers, body]
      else
        @app.call(env)
      end
    end
  end
end
