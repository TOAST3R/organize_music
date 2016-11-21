# OrganizeMusic

## How should I organize my mp3 files?

This is a recurrent problem for melomaniacs, is hard to order your music collection. If you have digital-music Diogenes syndrome this problem could be even worse. A standar naming format for folders is mandatory: It's the only way to organize your music collection


## This is one solution

All directories must have this format:

    /my_music/Karsten Pflum - Nemo Loon [EP] - (2010) [adn130] 
    /my_music/band_name - album_name

Once the script is executed you will have something like this:
  
    /my_music/Karsten Pflum/(2010) Nemo Loon EP adn130
    /my_music/band_name/album_name

How to execute the script that will make this renaming:

    iex -S mix 
    OrganizeMusic.reorganize_directories('/Users/toaster/my_music')

#### Be carefull when running the script, make sure that you are selecting the correct folder

#### Note:

[Elixir](http://elixir-lang.org/install.html) is needed to execute this script
