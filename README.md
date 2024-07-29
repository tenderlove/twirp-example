# Twirp + ProtoBoeuf

This is just a demo of Twirp working with ProtoBoeuf.

## Getting started

Just `bundle install` as usual, but you'll also need the
`protoc-gen-twirp_ruby` tool which you can get like this:

```
$ go install github.com/arthurnn/twirp-ruby/protoc-gen-twirp_ruby@latest
```

Then do `bundle exec rake` to generate files.

## Files

### `lib/test_app/hello_world_handler.rb`

This is the hand-written handler file for Twirp endpoints.

### `client.rb`

This is a test client

### `server.rb`

This is a test server

## Usage

In one terminal run the server like this:

```
$ bundle exec ruby -Ilib server.rb
```

In another terminal run the client like this:

```
$ bundle exec ruby -Ilib client.rb
```
