# blogerl

Simple blog engine, created for learning how to use OTP and erlang/elixir.
## Branches
there are two branches:
- [Erlang](https://github.com/amirrezaask/blogerl/tree/erlang)
- [Elixir](https://github.com/amirrezaask/blogerl/tree/elixir)
Both branches use **cowboy** webserver and **dets** for storage.


## API
### List of posts
curl localhost:8080/
### Post body
curl localhost:8080/:title

### New post
curl -XPOST localhost:8080/ --data '{"title": "new title", "body": "new body"}'
