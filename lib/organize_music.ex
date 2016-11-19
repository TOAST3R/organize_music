require Logger

defmodule OrganizeMusic do
  @first_release_year 1960

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
      ^directory_name -> 
        Logger.debug "'#{directory_name}' folder is correct already"
      band_name -> 
        File.mkdir(band_name)
        File.cd(band_name)

        case release(directory_name) do
          {:ok, release} ->
            # TODO: consider year can be nil
          	new_album_path = "#{band_name}/(#{release[:year]}) #{release[:name]}"
            File.rename(directory_name, new_album_path)
            Logger.debug "new directory name: #{new_album_path}"
            File.cd("..")

          {:error, _} ->
            Logger.error "directory_name: #{directory_name}"
            File.cd("..")
        end
    end
  end

  def band_name(directory_name) do
    case directory_name |> String.split("-") |> Enum.fetch(0) do
      {:ok, word} ->
        word 
        |> String.downcase
        |> String.trim
      {:error, _} ->
        directory_name
    end   
  end
  
  def release(directory_name) do
    directory_name
    |> String.replace(~r/\[|\]|\(|\)/, "")
    |> String.downcase
    |> String.trim
    |> String.split("-")
    |> Enum.drop(1)
    |> Enum.concat
    |> album_with_year
  end

  defp album_with_year(album_name) do
    case @first_release_year..(DateTime.utc_now().year + 1)
        |> Enum.filter(&(String.match?(album_name, ~r/#{&1}/)))
        |> Enum.fetch(0) do
      {:ok, year} ->
        %{name: String.replace(album_name, ~r/#{year}/, ""), year: year}
      :error ->
        %{name: album_name}
    end
  end
end
