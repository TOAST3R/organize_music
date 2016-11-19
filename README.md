# OrganizeMusic

## Organize your music collection

How should I organize my mp3 files? 

This is a recurrent problem for melomaniacs

If you have digital-music Diogenes syndrome this problem is even worse

Is mandatory to think in a standar format of folders:

it's the only way to organize your music collection



## This is one solution

All folders must have this format:

    `/Karsten Pflum - Nemo Loon [EP] - [adn130] (2010)`
    
    `band_name - album_name`

script will change it to this format:
  
    `/Karsten Pflum/Nemo Loon EP adn130 2010`
    
    `band_name/album_name`

To execute the script that will make this renaming in all folders
inside `music_folder_path` you have to:

    `iex -S mix`

    `OrganizeMusic.refactor_directories(music_folder_path)`


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

