defmodule Mix.Tasks.Showcase.Greeting do
  use Mix.Task

  @shortdoc "Sends a greeting to us from Showcase Phoenix"

  @moduledoc """
    This is where we would put any long form documentation or doctests.
  """

  def run(_args) do
    Mix.shell.info("Greetings from the Showcase Phoenix Application!")
    Mix.Task.run("app.start")
    Mix.shell.info("Now I have access to Repo and other goodies!")
  end

  # We can define other functions as needed here.
end