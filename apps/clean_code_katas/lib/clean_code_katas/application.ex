defmodule Katas.Application do
  @moduledoc """
  The Katas Application Service.

  The clean_code_katas system business domain lives in this application.

  Exposes API to clients such as the `KatasWeb` application
  for use in channels, controllers, and elsewhere.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Supervisor.start_link(
      [
        supervisor(Katas.Repo, [])
      ],
      strategy: :one_for_one,
      name: Katas.Supervisor
    )
  end
end
