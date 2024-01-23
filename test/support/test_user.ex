defmodule Entrepot.Ecto.Test.TestUser do
  use Ecto.Schema

  schema "app_users" do
    field(:attachment, Entrepot.Ecto.Type)
  end
end
