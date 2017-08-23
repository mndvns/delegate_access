defmodule DelegateAccess.Mixfile do
  use Mix.Project

  def project do
    [
      app: :delegate_access,
      version: "0.1.0",
      description: "delegate Access callbacks to another module",
      package: package(),
      deps: deps()
    ]
  end

  def package do
    [
      files: ["lib", "mix.exs", "README.md"],
      maintainers: ["Michael Vanasse"],
      licenses: ["MIT"],
      links: %{"Github" => "https://github.com/mndvns/delegate_access"},
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end
end
