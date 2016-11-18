require Logger

defmodule OrganizeMusic do
  def list_directories(music_folder_path) do
    case File.cd(music_folder_path) do
      {:ok, _} ->
        {:ok, directories} = File.ls
        directories
        |> Enum.filter(&(File.dir?(&1)))
        |> Enum.map(&(rename_directory(&1)))
      {:error, :enoent} ->
        Logger.error "#{music_folder_path} it is not a valid absolute path"
    end
  end

  def band_name(directory_name) do
    directory_name
    |> String.split("-")
    |> Enum.fetch(0)
  end
  
  def album_name(directory_name) do
    directory_name
    |> String.split("-")
    |> Enum.drop(1)
    |> Enum.concat
    |> String.downcase
    |> String.replace(~r/\[|\]|\(|\)/, "")
  end

  def rename_directory(directory_name) do
    case band_name(directory_name) do
      {:ok, directory_name} -> 
        Logger.debug "'#{directory_name}' folder is correct already"
      {:ok, band_bame} -> 
        File.mkdir(band_name)
        
        case album_name(directory_name) do
          {:ok, album_name}
            Logger.debug "new directory name: #{band_name <> "/" <> album_name}"
            File.rename(directory_name, band_name <> "/" <> album_name)
          {:error, _}
            Logger.error "directory_name: #{directory_name}"
        end
      end
    end
  end
end