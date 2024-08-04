defmodule Entrepot.Ecto do
  @moduledoc "./README.md" |> File.stream!() |> Enum.drop(1) |> Enum.join()

  @doc """
  Uploads data with `Entrepot` using a function.

  ## Parameters
  - `changeset`: The changeset to update.
  - `params`: Parameters to upload.
  - `permitted`: List of permitted fields.
  - `function`: A function with arity 2 that handles the upload.

  ## Examples

      iex> changeset = %Ecto.Changeset{}
      iex> fun = fn (_params, _changeset) -> %Entrepot.Locator{} end
      iex> Entrepot.Ecto.upload(changeset, %{"field" => "value"}, ["field"], fun)
      %Ecto.Changeset{}

  """
  def upload(changeset, params, permitted, fun) when is_function(fun, 2),
    do:
      do_upload(
        changeset,
        params,
        permitted,
        {fun}
      )

  @doc """
  Uploads data with `Entrepot` using a module and function name.

  ## Parameters
  - `changeset`: The changeset to update.
  - `params`: Parameters to upload.
  - `permitted`: List of permitted fields.
  - `module`: The module containing the function.
  - `function`: The function name within the module.

  ## Examples

      iex> changeset = %Ecto.Changeset{}
      iex> Entrepot.Ecto.upload(changeset, %{"field" => "value"}, ["field"], SomeModule, :some_function)
      %Ecto.Changeset{}

  """
  def upload(changeset, params, permitted, module, func_name),
    do:
      do_upload(
        changeset,
        params,
        permitted,
        {module, func_name}
      )

  defp do_upload(changeset, params, permitted, locator_args) do
    stringified_permitted = Enum.map(permitted, &to_string/1)

    Enum.reduce(params, changeset, fn {field, _} = params_pair, changeset ->
      with true <- Enum.member?(stringified_permitted, to_string(field)),
           %Entrepot.Locator{} = locator <-
             do_upload(locator_args |> Tuple.append([params_pair, changeset])) do
        Ecto.Changeset.cast(changeset, %{field => locator}, permitted)
      end
      |> case do
        false -> changeset
        %Ecto.Changeset{} = changeset -> changeset
      end
    end)
  end

  defp do_upload({mod, func, args}), do: apply(mod, func, args)
  defp do_upload({func, args}), do: apply(func, args)
end
