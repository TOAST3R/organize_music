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

    `OrganizeMusic.refactor_directories('/Users/toaster/my_music')`

