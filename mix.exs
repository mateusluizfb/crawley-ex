defmodule Crawley.MixProject do
  use Mix.Project

  def project() do
    [
      app: :crawley,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      applications: [:tentacat],
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:tentacat, "~> 1.0"},
      {:ex_aws, "~> 2.0"},
      {:ex_aws_s3, "~> 2.0"},
      {:sweet_xml, "~> 0.6"},
      {:hackney, "~> 1.9"},
      {:poison, "~> 3.0"},
      {:git_cli, "~> 0.3"},
      {:exvcr, "~> 0.10", only: :test},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end

  defp description() do
    """
    Crawley is an elixir package that mine the Github API searching for repos to download and then zip and upload them
    to a S3 bucket.
    """
  end

  defp package() do
    [
      # This option is only needed when you don't want to use the OTP application name
      name: "crawley_ex",
      # These are the default files included in the package
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/mateusluizfb/crawley-ex"}
    ]
  end
end
