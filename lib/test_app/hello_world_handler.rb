# frozen_string_literal: true

# This file was hand written
#
module TestApp
  class HelloWorldHandler
    def hello req, env
      if req.subject.empty?
        return Twirp::Error.invalid_argument("is mandatory", argument: "name")
      end

      TestApp::HelloResp.new(text: "Hello #{req.subject}")
    end
  end
end
