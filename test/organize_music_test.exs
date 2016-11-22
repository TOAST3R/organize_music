defmodule OrganizeMusicTest do
  use ExUnit.Case
  doctest OrganizeMusic

  test "band_name" do
    assert OrganizeMusic.band_name("ZETA RETICULA - EP 5 (2016) [ELECTRIX008]") == "zeta reticula"
    assert OrganizeMusic.band_name("Zeta Reticula - EP 5") == "zeta reticula"
    assert OrganizeMusic.band_name("Zeta Reticula - [2016]") == "zeta reticula"
    assert OrganizeMusic.band_name("Zeta Reticula") == "zeta reticula"
  end

  test "release_without_year" do
    assert OrganizeMusic.release_without_year("Zeta Reticula - EP 5 (2016) [ELECTRIX008]") == "ep 5 [electrix008]"
    assert OrganizeMusic.release_without_year("Zeta Reticula - EP 5 [ELECTRIX008]") == "ep 5 [electrix008]"
    assert OrganizeMusic.release_without_year("Zeta Reticula - [2016]") == ""
    assert OrganizeMusic.release_without_year("Zeta Reticula") == ""
  end

  test "year" do
    assert OrganizeMusic.year("Zeta Reticula - EP 5 (2016)") == 2016
    assert OrganizeMusic.year("Zeta Reticula - EP 5") == ""
    assert OrganizeMusic.year("Zeta Reticula - [2016]") == 2016
    assert OrganizeMusic.year("Zeta Reticula") == ""
  end
end
