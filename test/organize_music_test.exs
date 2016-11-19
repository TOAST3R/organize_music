defmodule OrganizeMusicTest do
  use ExUnit.Case
  doctest OrganizeMusic

  test "release name" do
    directory = "Zeta Reticula - EP 5 (2016)"
    assert OrganizeMusic.band_name(directory), "zeta reticula"
    #assert OrganizeMusic.release(directory)[:name], "ep 5"
    #assert OrganizeMusic.release(directory)[:year], "2016"
  end

  test "release name without year" do
    directory = "Zeta Reticula - EP 5"
    assert OrganizeMusic.band_name(directory), "zeta reticula"
    #assert OrganizeMusic.release(directory)[:name], "ep 5"
    #assert OrganizeMusic.release(directory)[:year], nil
  end
end
