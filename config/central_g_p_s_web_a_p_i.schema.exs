@moduledoc """
A schema is a keyword list which represents how to map, transform, and validate
configuration values parsed from the .conf file. The following is an explanation of
each key in the schema definition in order of appearance, and how to use them.

## Import

A list of application names (as atoms), which represent apps to load modules from
which you can then reference in your schema definition. This is how you import your
own custom Validator/Transform modules, or general utility modules for use in
validator/transform functions in the schema. For example, if you have an application
`:foo` which contains a custom Transform module, you would add it to your schema like so:

`[ import: [:foo], ..., transforms: ["myapp.some.setting": MyApp.SomeTransform]]`

## Extends

A list of application names (as atoms), which contain schemas that you want to extend
with this schema. By extending a schema, you effectively re-use definitions in the
extended schema. You may also override definitions from the extended schema by redefining them
in the extending schema. You use `:extends` like so:

`[ extends: [:foo], ... ]`

## Mappings

Mappings define how to interpret settings in the .conf when they are translated to
runtime configuration. They also define how the .conf will be generated, things like
documention, @see references, example values, etc.

See the moduledoc for `Conform.Schema.Mapping` for more details.

## Transforms

Transforms are custom functions which are executed to build the value which will be
stored at the path defined by the key. Transforms have access to the current config
state via the `Conform.Conf` module, and can use that to build complex configuration
from a combination of other config values.

See the moduledoc for `Conform.Schema.Transform` for more details and examples.

## Validators

Validators are simple functions which take two arguments, the value to be validated,
and arguments provided to the validator (used only by custom validators). A validator
checks the value, and returns `:ok` if it is valid, `{:warn, message}` if it is valid,
but should be brought to the users attention, or `{:error, message}` if it is invalid.

See the moduledoc for `Conform.Schema.Validator` for more details and examples.
"""
[
  extends: [],
  import: [],
  mappings: [
    "logger.utc_log": [
      commented: false,
      datatype: :atom,
      default: true,
      doc: "Provide documentation for logger.utc_log here.",
      hidden: false,
      to: "logger.utc_log"
    ],
    "logger.console.format": [
      commented: false,
      datatype: :binary,
      default: "$date $time [$level] $metadata - $message\n",
      doc: "Provide documentation for logger.console.format here.",
      hidden: false,
      to: "logger.console.format"
    ],
    "logger.console.metadata": [
      commented: false,
      datatype: [
        list: :atom
      ],
      default: [
        :request_id
      ],
      doc: "Provide documentation for logger.console.metadata here.",
      hidden: false,
      to: "logger.console.metadata"
    ],
    "logger.debug_log.path": [
      commented: false,
      datatype: :binary,
      default: "logs/debug.log",
      doc: "Provide documentation for logger.debug_log.path here.",
      hidden: false,
      to: "logger.debug_log.path"
    ],
    "logger.debug_log.level": [
      commented: false,
      datatype: :atom,
      default: :debug,
      doc: "Provide documentation for logger.debug_log.level here.",
      hidden: false,
      to: "logger.debug_log.level"
    ],
    "logger.error_log.path": [
      commented: false,
      datatype: :binary,
      default: "logs/error.log",
      doc: "Provide documentation for logger.error_log.path here.",
      hidden: false,
      to: "logger.error_log.path"
    ],
    "logger.error_log.level": [
      commented: false,
      datatype: :atom,
      default: :error,
      doc: "Provide documentation for logger.error_log.level here.",
      hidden: false,
      to: "logger.error_log.level"
    ],
    "logger.info_log.path": [
      commented: false,
      datatype: :binary,
      default: "logs/info.log",
      doc: "Provide documentation for logger.info_log.path here.",
      hidden: false,
      to: "logger.info_log.path"
    ],
    "logger.info_log.level": [
      commented: false,
      datatype: :atom,
      default: :info,
      doc: "Provide documentation for logger.info_log.level here.",
      hidden: false,
      to: "logger.info_log.level"
    ],
    "logger.warn_log.path": [
      commented: false,
      datatype: :binary,
      default: "logs/warn.log",
      doc: "Provide documentation for logger.warn_log.path here.",
      hidden: false,
      to: "logger.warn_log.path"
    ],
    "logger.warn_log.level": [
      commented: false,
      datatype: :atom,
      default: :warn,
      doc: "Provide documentation for logger.warn_log.level here.",
      hidden: false,
      to: "logger.warn_log.level"
    ],
    "central_g_p_s_web_a_p_i.Elixir.CentralGPSWebAPI.Endpoint.root": [
      commented: false,
      datatype: :binary,
      default: "/usr/bin/central_g_p_s_web_a_p_i/lib/central_g_p_s_web_a_p_i-1.2.1",
      doc: "Provide documentation for central_g_p_s_web_a_p_i.Elixir.CentralGPSWebAPI.Endpoint.root here.",
      hidden: false,
      to: "central_g_p_s_web_a_p_i.Elixir.CentralGPSWebAPI.Endpoint.root"
    ],
    "central_g_p_s_web_a_p_i.Elixir.CentralGPSWebAPI.Endpoint.secret_key_base": [
      commented: false,
      datatype: :binary,
      default: "aLIFKvszPTOoXoAYQ3RL9qdUfmhEyEesWFMi5OwQd80sME26l3tyrZzb9digCZXj",
      doc: "Provide documentation for central_g_p_s_web_a_p_i.Elixir.CentralGPSWebAPI.Endpoint.secret_key_base here.",
      hidden: false,
      to: "central_g_p_s_web_a_p_i.Elixir.CentralGPSWebAPI.Endpoint.secret_key_base"
    ],
    "central_g_p_s_web_a_p_i.Elixir.CentralGPSWebAPI.Endpoint.server": [
      commented: false,
      datatype: :atom,
      default: true,
      doc: "Provide documentation for central_g_p_s_web_a_p_i.Elixir.CentralGPSWebAPI.Endpoint.server here.",
      hidden: false,
      to: "central_g_p_s_web_a_p_i.Elixir.CentralGPSWebAPI.Endpoint.server"
    ],
    "central_g_p_s_web_a_p_i.Elixir.CentralGPSWebAPI.Endpoint.http.port": [
      commented: false,
      datatype: :integer,
      default: 4000,
      doc: "Provide documentation for central_g_p_s_web_a_p_i.Elixir.CentralGPSWebAPI.Endpoint.http.port here.",
      hidden: false,
      to: "central_g_p_s_web_a_p_i.Elixir.CentralGPSWebAPI.Endpoint.http.port"
    ],
    "central_g_p_s_web_a_p_i.Elixir.CentralGPSWebAPI.Endpoint.debug_errors": [
      commented: false,
      datatype: :atom,
      default: true,
      doc: "Provide documentation for central_g_p_s_web_a_p_i.Elixir.CentralGPSWebAPI.Endpoint.debug_errors here.",
      hidden: false,
      to: "central_g_p_s_web_a_p_i.Elixir.CentralGPSWebAPI.Endpoint.debug_errors"
    ],
    "central_g_p_s_web_a_p_i.Elixir.CentralGPSWebAPI.Endpoint.code_reloader": [
      commented: false,
      datatype: :atom,
      default: true,
      doc: "Provide documentation for central_g_p_s_web_a_p_i.Elixir.CentralGPSWebAPI.Endpoint.code_reloader here.",
      hidden: false,
      to: "central_g_p_s_web_a_p_i.Elixir.CentralGPSWebAPI.Endpoint.code_reloader"
    ],
    "central_g_p_s_web_a_p_i.Elixir.CentralGPSWebAPI.Endpoint.cache_static_lookup": [
      commented: false,
      datatype: :atom,
      default: false,
      doc: "Provide documentation for central_g_p_s_web_a_p_i.Elixir.CentralGPSWebAPI.Endpoint.cache_static_lookup here.",
      hidden: false,
      to: "central_g_p_s_web_a_p_i.Elixir.CentralGPSWebAPI.Endpoint.cache_static_lookup"
    ],
    "central_g_p_s_web_a_p_i.Elixir.CentralGPSWebAPI.Endpoint.live_reload.patterns": [
      commented: false,
      datatype: [
        list: :binary
      ],
      default: [
        ~r/priv\/static\/.*(js|css|png|jpeg|jpg|gif)$/,
        ~r/web\/views\/.*(ex)$/,
        ~r/web\/templates\/.*(eex)$/
      ],
      doc: "Provide documentation for central_g_p_s_web_a_p_i.Elixir.CentralGPSWebAPI.Endpoint.live_reload.patterns here.",
      hidden: false,
      to: "central_g_p_s_web_a_p_i.Elixir.CentralGPSWebAPI.Endpoint.live_reload.patterns"
    ],
    "central_g_p_s_web_a_p_i.Elixir.CentralGPS.Repo.adapter": [
      commented: false,
      datatype: :atom,
      default: Ecto.Adapters.Postgres,
      doc: "Provide documentation for central_g_p_s_web_a_p_i.Elixir.CentralGPS.Repo.adapter here.",
      hidden: false,
      to: "central_g_p_s_web_a_p_i.Elixir.CentralGPS.Repo.adapter"
    ],
    "central_g_p_s_web_a_p_i.Elixir.CentralGPS.Repo.extensions.Elixir.CentralGPS.Repo.Extensions.Postgrex.JSON.library": [
      commented: false,
      datatype: :atom,
      default: Poison,
      doc: "Provide documentation for central_g_p_s_web_a_p_i.Elixir.CentralGPS.Repo.extensions.Elixir.CentralGPS.Repo.Extensions.Postgrex.JSON.library here.",
      hidden: false,
      to: "central_g_p_s_web_a_p_i.Elixir.CentralGPS.Repo.extensions.Elixir.CentralGPS.Repo.Extensions.Postgrex.JSON.library"
    ],
    "central_g_p_s_web_a_p_i.Elixir.CentralGPS.Repo.username": [
      commented: false,
      datatype: :binary,
      default: "postgres",
      doc: "Provide documentation for central_g_p_s_web_a_p_i.Elixir.CentralGPS.Repo.username here.",
      hidden: false,
      to: "central_g_p_s_web_a_p_i.Elixir.CentralGPS.Repo.username"
    ],
    "central_g_p_s_web_a_p_i.Elixir.CentralGPS.Repo.password": [
      commented: false,
      datatype: :binary,
      default: "!pgsql@94#",
      doc: "Provide documentation for central_g_p_s_web_a_p_i.Elixir.CentralGPS.Repo.password here.",
      hidden: false,
      to: "central_g_p_s_web_a_p_i.Elixir.CentralGPS.Repo.password"
    ],
    "central_g_p_s_web_a_p_i.Elixir.CentralGPS.Repo.database": [
      commented: false,
      datatype: :binary,
      default: "centralgps",
      doc: "Provide documentation for central_g_p_s_web_a_p_i.Elixir.CentralGPS.Repo.database here.",
      hidden: false,
      to: "central_g_p_s_web_a_p_i.Elixir.CentralGPS.Repo.database"
    ],
    "central_g_p_s_web_a_p_i.Elixir.CentralGPS.Repo.hostname": [
      commented: false,
      datatype: :binary,
      default: "184.171.247.181",
      doc: "Provide documentation for central_g_p_s_web_a_p_i.Elixir.CentralGPS.Repo.hostname here.",
      hidden: false,
      to: "central_g_p_s_web_a_p_i.Elixir.CentralGPS.Repo.hostname"
    ],
    "central_g_p_s_web_a_p_i.Elixir.CentralGPS.Repo.port": [
      commented: false,
      datatype: :integer,
      default: 6543,
      doc: "Provide documentation for central_g_p_s_web_a_p_i.Elixir.CentralGPS.Repo.port here.",
      hidden: false,
      to: "central_g_p_s_web_a_p_i.Elixir.CentralGPS.Repo.port"
    ]
  ],
  transforms: [],
  validators: []
]
