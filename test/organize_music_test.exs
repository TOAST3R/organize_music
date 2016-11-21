defmodule OrganizeMusicTest do
  use ExUnit.Case
  doctest OrganizeMusic

  test "release with all meta data" do
    directory = "Zeta Reticula - EP 5 (2016)"
    assert OrganizeMusic.band_name(directory), "zeta reticula"
    assert OrganizeMusic.release_without_year(directory), "ep 5"
    assert OrganizeMusic.year(directory), "2016"
    assert OrganizeMusic.compose_folder_name("zeta reticula", "2016", "ep 5"), "zeta reticula/(2016) ep 5"
  end

  test "release without year" do
    directory = "Zeta Reticula - EP 5"
    assert OrganizeMusic.band_name(directory), "zeta reticula"
    assert OrganizeMusic.release_without_year(directory), "ep 5"
    assert OrganizeMusic.year(directory), ""
  end

  test "release without album" do
    directory = "Zeta Reticula - [2016]"
    assert OrganizeMusic.band_name(directory), "zeta reticula"
    assert OrganizeMusic.release_without_year(directory), ""
    assert OrganizeMusic.year(directory), "2016"
  end

  test "release without album and year" do
    directory = "Zeta Reticula"
    assert OrganizeMusic.band_name(directory), "zeta reticula"
    assert OrganizeMusic.release_without_year(directory), ""
    assert OrganizeMusic.year(directory), ""
  end
end
