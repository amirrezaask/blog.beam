blogerl
=====

Simple blog engine, created for learning erlang.


## API
### List of posts
curl localhost:8080/
### Post body
curl localhost:8080/post_title

### New post
curl -XPOST localhost:8080/ --data '{"title": "new title", "body": "new body"}'


Build
-----

    $ rebar3 compile
