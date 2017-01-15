# OrganizeMusic

## Dependencies

[Elixir](http://elixir-lang.org/install.html) is needed to execute this script  

## How should I organize my mp3 files?

This is a recurrent problem for melomaniacs, is hard to order your music collection. If you have digital-music Diogenes syndrome this problem could be even worse. A standar naming format for folders is mandatory: It's the only way to organize your music collection  

## Reorganize music collection folders

All directories must have this format:

    /my_music/Karsten Pflum - Nemo Loon [EP] - (2010) [adn130] 
    /my_music/band_name - album_name

Once the script is executed the folder structure will be like this:
  
    /my_music/Karsten Pflum/(2010) Nemo Loon EP adn130
    /my_music/band_name/(release year) album_name

To rename all folder in the given music folder, just execute:

    iex -S mix 
    OrganizeMusic.reorganize_directories('/Users/toaster/Music')

## Export collection to a csv

To export a resume of releases in your collection to a file "music_collection.csv" execute:  

    iex -S mix 
    OrganizeMusic.export_to_csv('/Users/toaster/Music')

#### Be carefull when running the script, make sure that you are selecting the correct folder
