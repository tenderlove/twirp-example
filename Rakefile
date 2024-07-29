require "rake/clean"

# Pull in the Protoboeuf parser / code generator
require "protoboeuf/parser"
require "protoboeuf/codegen"

generated_files = [
  "lib/proto/hello_world_service_twirp.rb",
  "lib/proto/hello_world.rb"
]

generated_files.each { CLEAN.include << _1 }

# Generate the service file
file "lib/proto/hello_world_service_twirp.rb" => "proto/hello_world_service.proto" do |t|
  FileUtils.mkdir_p "lib"

  # Generate the Twirp service
  sh "protoc --plugin=bin/protoc-gen-twirp_ruby --ruby_out=lib --twirp_ruby_out=lib proto/hello_world_service.proto"

  # Remove the require for the "protobuf" generated file
  File.binwrite t.name, File.readlines(t.name).grep_v(/require_relative/).join
end

# Generate the protobuf file
file "lib/proto/hello_world.rb" => ["proto/hello_world.proto", "lib/proto/hello_world_service_twirp.rb"] do |t|
  FileUtils.rm_f "lib/proto/hello_world_pb.rb"
  FileUtils.rm_f "lib/proto/hello_world_service_pb.rb"

  # Parse the protobuf file, then generate our Ruby classes
  unit = ProtoBoeuf.parse_file "proto/hello_world.proto"
  gen = ProtoBoeuf::CodeGen.new(unit, generate_types: false)
  File.binwrite t.name, gen.to_ruby
end

task default: "lib/proto/hello_world.rb"
