# Exercise - API Contracts

### Version elixir and erlang (You can install using ASDF)
* elixir 1.10.4-otp-23
* erlang 23.1.1



### Libraries
* Phoenix 1.4.9
* Absinthe 1.4

### Database
* Mysql
## Config:
* Set your config database in config/dev.exs and config/test.exs


To start your server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`
  * Run unit tests `mix test`

Now you can visit Graphiql Playground to test and see the queries and mutations [`localhost:4000/graphiql`](http://localhost:4000/graphiql) from your browser.


## Github Actions 
* `.github/workflows/elixir.yml`
