require Logger

defmodule OrganizeMusic do
  @first_release_year 1960

  def reorganize_directories(music_folder_path) do
    case File.cd(music_folder_path) do
      :ok ->
        {:ok, directories} = File.ls
        directories
        |> Enum.filter_map(&(File.dir?(&1)), &(rename_directory(&1)))
      {:error, :enoent} ->
        Logger.error "#{music_folder_path} it is not a valid absolute path"
    end
  end

  def rename_directory(directory_name) do
    case band_name(directory_name) do
      ^directory_name -> 
        Logger.debug "'#{directory_name}' do not have the format 'band_name' - 'release_name'"
      band_name -> 
        File.mkdir(band_name)

        new_album_path = band_name <> release_with_year(directory_name)
        case File.rename(directory_name, new_album_path) do
          :ok ->
            File.rm_rf(directory_name)
            Logger.debug "new directory: #{new_album_path}"
          {:error, reason} ->
            Logger.error "error #{reason} renaming directory from: #{directory_name} to #{new_album_path}"
        end
    end
  end

  def band_name(directory_name) do
    directory_name
    |> String.replace(~r/-.*/, "")
    |> String.trim
    |> String.downcase
  end

  def year(directory_name) do
    case @first_release_year..(DateTime.utc_now().year + 1)
         |> Enum.filter(&(String.match?(release(directory_name), ~r/#{&1}/)))
         |> Enum.fetch(0) do
      {:ok, year} ->
        year
      :error ->
        ""
    end
  end

  def release_without_year(directory_name) do
    release(directory_name)
    |> String.replace(~r/#{year(directory_name)}/, "")
    |> String.replace(~r/\[\]|\(\)/, "")
    |> String.replace(~r/  /, " ")
    |> String.downcase
    |> String.trim
  end

  def release_with_year(directory_name) do
    case year(directory_name) do
      "" -> ""
      release_year -> "(#{release_year})"
    end <> release_without_year(directory_name)
  end

  defp release(directory_name) do
    directory_name
    |> String.split("-")
    |> Enum.drop(1)
    |> List.foldl("", &(&2 <>&1))
  end
end
