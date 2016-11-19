defmodule OrganizeMusic do
  def refactor_directories(music_folder_path) do
    case File.cd(music_folder_path) do
      {:ok, _} ->
        {:ok, directories} = File.ls
        directories
        |> Enum.filter(&(File.dir?(&1)))
        |> Enum.map(&(rename_directory(&1)))
     
      {:error, :enoent} ->
        :logger.error "#{music_folder_path} it is not a valid absolute path"
    end
  end

  def rename_directory(directory_name) do
    case band_name(directory_name) do
      {:ok, ^directory_name} -> 
        :logger.debug "'#{directory_name}' folder is correct already"
      {:ok, band_name} -> 
        File.mkdir(band_name)
        File.cd(band_name)

        case album_name(directory_name) do
          {:ok, album_name} ->
          	new_album_path = band_name <> "/" <> album_name
            File.rename(directory_name, new_album_path)
            :logger.debug "new directory name: #{new_album_path}"
            File.cd("..")

          {:error, _} ->
            :logger.error "directory_name: #{directory_name}"
            File.cd("..")
        end
    end
  end

  defp band_name(directory_name) do
    directory_name
    |> String.split("-")
    |> Enum.fetch(0)
  end
  
  defp album_name(directory_name) do
    directory_name
    |> String.split("-")
    |> Enum.drop(1)
    |> Enum.concat
    |> String.downcase
    |> String.replace(~r/\[|\]|\(|\)/, "")
  end
end
