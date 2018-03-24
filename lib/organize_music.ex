require Logger

defmodule OrganizeMusic do
  @first_release_year 1960

  def reorganize_directories(music_folder_path) do
    File.cd!(music_folder_path)

    File.ls!
    |> Enum.filter_map(&(File.dir?(&1)), &(rename_directory(&1)))
  end

  def export_to_csv(music_folder_path) do
    File.cd!(music_folder_path)
    File.rm_rf "music_collection.csv"
    {:ok, file} = File.open "music_collection.csv", [:append]

    File.ls!
    |> Enum.filter_map(&(File.dir?(&1)), &(band_to_csv(&1, file)))

    file |> File.close
  end

  def band_name(directory_name) do
    directory_name
    |> String.replace(~r/-|‎–.*/, "")
    |> String.trim
    |> String.downcase
  end

  def year(directory_name) do
    @first_release_year..(DateTime.utc_now().year + 1)
    |> Enum.find(&(String.match?(release(directory_name), ~r/#{&1}/)))
  end

  def release_without_year(directory_name) do
    release(directory_name)
    |> String.replace(~r/#{year(directory_name)}/, "")
    |> String.replace(~r/\[\]|\(\)/, "")
    |> String.replace(~r/  /, " ")
    |> String.downcase
    |> String.trim
  end

  defp band_to_csv(band_name, csv_file) do
    File.cd(band_name)
    File.ls!
    |> Enum.filter_map(&(File.dir?(&1)), &(release_to_csv(&1, band_name, csv_file)))
    File.cd("..")
  end

  defp release_to_csv(release_name, band_name, csv_file) do
    IO.binwrite(csv_file, "#{band_name};#{release_name};\r\n")
  end

  defp rename_directory(directory_name) do
    case band_name(directory_name) do
      ^directory_name -> 
        Logger.info "'#{directory_name}' do not have the format 'band_name' - 'release_name'"
      band_name -> 
        File.mkdir(band_name)

        new_album_path = "#{band_name}/#{release_with_year(directory_name)}"
        case File.rename(directory_name, new_album_path) do
          :ok -> ""
          {:error, reason} ->
            Logger.error "error #{reason} renaming directory from: #{directory_name} to #{new_album_path}"
        end
    end
  end

  defp release_with_year(directory_name) do
    case year(directory_name) do
      nil -> release_without_year(directory_name)
      release_year -> "(#{release_year}) #{release_without_year(directory_name)}"
    end
  end

  defp release(directory_name) do
    directory_name
    |> String.split(["-", "‎–"])
    |> Enum.drop(1)
    |> List.foldl("", &(&2 <> &1))
  end
end
