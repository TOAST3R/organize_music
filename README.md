# OrganizeMusic

## Organize your music collection

All folders must have this format:
`/Karsten Pflum - Nemo Loon EP (2010)`
script will change it to this format:
`/Karsten Pflum/Nemo Loon EP (2010)`


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add organize_music to your list of dependencies in `mix.exs`:

        def deps do
          [{:organize_music, "~> 0.0.1"}]
        end

  2. Ensure organize_music is started before your application:

        def application do
          [applications: [:organize_music]]
        end

