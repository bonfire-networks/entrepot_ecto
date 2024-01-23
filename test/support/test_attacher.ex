defmodule Entrepot.Ecto.Test.TestAttacher do
  def attach({_field, _upload}, %Ecto.Changeset{}) do
    %Entrepot.Locator{}
  end
end
