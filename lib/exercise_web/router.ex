defmodule ExerciseWeb.Router do
  use ExerciseWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ExerciseWeb do
    pipe_through :api
  end

  forward("/graphiql", Absinthe.Plug.GraphiQL, schema: ExerciseWeb.Graphql.Schema)
end
