require "proto/hello_world"
require "proto/hello_world_service_twirp"

client = TestApp::HelloWorldClient.new("http://localhost:3000/twirp")
resp = client.hello(TestApp::HelloReq.new(subject: "World"))
if resp.error
  puts resp.error # <Twirp::Error code:... msg:"..." meta:{...}>
else
  p resp.data  # <TestApp::HelloResp: message:"Hello World">
end
