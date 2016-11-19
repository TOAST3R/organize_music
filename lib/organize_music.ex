require Logger

defmodule OrganizeMusic do
  def refactor_directories(music_folder_path) do
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

  def rename_directory(directory_name) do
    case band_name(directory_name) do
      {:ok, ^directory_name} -> 
        Logger.debug "'#{directory_name}' folder is correct already"
      {:ok, band_name} -> 
        File.mkdir(band_name)
        File.cd(band_name)

        case album_name(directory_name) do
          {:ok, album_name} ->
          	new_album_path = band_name <> "/" <> album_name
            File.rename(directory_name, new_album_path)
            Logger.debug "new directory name: #{new_album_path}"
            File.cd("..")

          {:error, _} ->
            Logger.error "directory_name: #{directory_name}"
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
    |> album_with_year
  end

  defp album_with_year(album_name) do
    case 1960..(DateTime.utc_now().year + 1)
        |> Enum.filter(&(String.match?(album_name, ~r/#{&1}/)))
        |> Enum.fetch(0) do
    	{:ok, year} ->
        "(#{year}) " <> String.replace(album_name, ~r/#{year}/, "")
      :error ->
        album_name
    end
  end
end
