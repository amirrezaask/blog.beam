# blogerl

Simple blog engine, created for learning how to use OTP and erlang/elixir.
## Branches
there are two branches:
- [Erlang](https://github.com/amirrezaask/blogerl/tree/erlang)
- [Elixir](https://github.com/amirrezaask/blogerl/tree/elixir)<br>
Both branches use **cowboy** webserver and **dets** for storage.


## API
| Defenition | cURL |
|------------|------|
| List Of posts | curl localhost:8080 |
| Get Post body | curl localhost:8080/:title |
| New Post | curl -XPOST localhost:8080/ --data '{"title": "new title", "body": "new body"}'

