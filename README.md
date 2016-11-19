# OrganizeMusic

## How should I organize my mp3 files?

This is a recurrent problem for melomaniacs

If you have digital-music Diogenes syndrome this problem could be even worse

A standar format for your folders is mandatory: It's the only way to organize your music collection


## This is one solution

All folders must have this format:

    /my_music/Karsten Pflum - Nemo Loon [EP] - [adn130] (2010)
    
    /my_music/band_name - album_name

Once script is executed you will have something like this:
  
    /my_music/Karsten Pflum/Nemo Loon EP adn130 2010
    
    /my_music/band_name/album_name

How to execute the script that will make this renaming:

    iex -S mix

    OrganizeMusic.refactor_directories('/Users/toaster/my_music')


** Note: **
[Elixir](http://elixir-lang.org/install.html) is needed to execute this script