ExUnit.start()

Application.put_env(:entrepot_ecto, :default_storage, Entrepot.Ecto.Test.TestStorage)
