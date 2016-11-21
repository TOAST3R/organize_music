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
        Logger.debug "'#{directory_name}' folder is not valid"
      band_name -> 
        File.mkdir(band_name)
        
        case release_without_year(directory_name) do
          {:ok, release_name} ->
            # TODO: consider year can be nil
            new_album_path = compose_folder_name(band_name, year(directory_name), release_name)
            File.rename(directory_name, new_album_path)
            Logger.debug "new directory name: #{new_album_path}"
          
          {:error, _} ->
            Logger.error "directory_name: #{directory_name}"
        end
    end
  end

  def compose_folder_name(band_name, release_year, release_name) do
    case release_year do
      "" -> "#{band_name}/#{release_name}"
      _ -> "#{band_name}/(#{release_year}) #{release_name}"
    end
  end

  def band_name(directory_name) do
    {:ok, band_name} = directory_name 
                       |> String.split("-") 
                       |> Enum.fetch(0)
    band_name
  end
  
  def release(directory_name) do
    directory_name
    |> String.replace(~r/\[|\]|\(|\)/, "")
    |> String.downcase
    |> String.trim
    |> String.split("-")
    |> Enum.drop(1)
    |> List.foldl("", &(&2 <>&1))
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
    String.replace(release(directory_name), ~r/#{year(directory_name)}/, "")
  end
end
