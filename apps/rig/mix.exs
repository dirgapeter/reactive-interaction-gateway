defmodule Rig.MixProject do
  @moduledoc false
  use Mix.Project

  alias Rig.Umbrella.Mixfile, as: Umbrella

  def project do
    [
      app: :rig,
      version: Umbrella.release_version(),
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: Umbrella.elixir_version(),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {Rig.Application, []},
      extra_applications: [:logger],
      included_applications: [:peerage]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:rig_kafka, in_umbrella: true},
      # Read and use application configuration from environment variables:
      {:confex, "~> 3.3"},
      # For providing the global Phx PubSub server:
      {:phoenix_pubsub, "~> 1.0"},
      # for Kafka, partition from MurmurHash(key):
      {:murmur, "~> 1.0"},
      {:peerage, "~> 1.0"},
      # For running external commands in Mix tasks:
      {:porcelain, "~> 2.0"},
      # HTTP request handling (wraps Cowboy):
      {:plug, "~> 1.4"},
      # JSON parser, for cloud_event and event_hub:
      {:poison, "~> 2.0 or ~> 3.0"},
      # JSON parser that's supposedly faster than poison:
      {:jason, "~> 1.1"},
      # JSON Pointer (RFC 6901) implementation for subscriptions:
      {:odgn_json_pointer, "~> 2.3"},
      # Apache Kafka Erlang client library:
      {:brod, "~> 3.3"},
      # For distributed_set:
      {:timex, "~> 3.1.22"},
      {:ex2ms, "~> 1.5"},
      {:uuid, "~> 1.1"},
      # For doing HTTP requests, e.g., in kafka_as_http:
      {:httpoison, "~> 1.3"}
    ]
  end

  defp aliases do
    [
      compile: ["compile", "update_docs"]
    ]
  end
end
