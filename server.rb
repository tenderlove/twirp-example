require "proto/hello_world"
require "proto/hello_world_service_twirp"
require "test_app/hello_world_handler"
require "rackup/handler/webrick"
require "webrick"

# This is a hack to work around Twirp directly referencing a Google constant:
#   https://github.com/arthurnn/twirp-ruby/blob/a61951f2df21ccda465e9fd4c4f15d895d2fac23/lib/twirp/service.rb#L145
module Google
  module Protobuf
    class ParseError
    end
  end
end

# Rack bodies are no longer rewindable (I guess), so this is to work around
# the fact that Twirp-Ruby tries to rewind:
#   https://github.com/arthurnn/twirp-ruby/blob/a61951f2df21ccda465e9fd4c4f15d895d2fac23/lib/twirp/service.rb#L141
class Rackup::Handler::WEBrick::Input
  def rewind; end
end

handler = TestApp::HelloWorldHandler.new
service = TestApp::HelloWorldService.new handler

path_prefix = "/twirp/" + service.full_name
server = WEBrick::HTTPServer.new(Port: 3000)
server.mount path_prefix, Rackup::Handler::WEBrick, service
server.start
