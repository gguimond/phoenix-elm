defmodule Showcase.Repo do
  use Ecto.Repo, otp_app: :showcase, adapter: Mongo.Ecto
end