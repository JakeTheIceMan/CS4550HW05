defmodule Memory.Game do

  def new do
    getBlankGame();
  end

  def getBlankGame do
    %{
      tiles: Enum.shuffle([%{value: "A", matched: false}, %{value: "A", matched: false},
                           %{value: "B", matched: false}, %{value: "B", matched: false},
                           %{value: "C", matched: false}, %{value: "C", matched: false},
                           %{value: "D", matched: false}, %{value: "D", matched: false},
                           %{value: "E", matched: false}, %{value: "E", matched: false},
                           %{value: "F", matched: false}, %{value: "F", matched: false},
                           %{value: "G", matched: false}, %{value: "G", matched: false},
                           %{value: "H", matched: false}, %{value: "H", matched: false}]),
      t1: -1,
      t2: -1,
      clicks: 0,
      flipped: false,
    }
  end

  def client_view(game) do
    %{ 
      tiles: Enum.map(game.tiles, fn x ->
                                    if x.matched do
                                      x.value
                                    else
                                      "?"
                                    end
                                  end),
      clicks: game.clicks,
      flipped: game.flipped,
    }
  end

  def checkMatches(game) do
    if (Enum.at(game.tiles, game.t1).value != Enum.at(game.tiles, game.t2).value) do
      game = %{ game | tiles: List.replace_at(game.tiles, game.t1, %{Enum.at(game.tiles, game.t1) | matched: false})}
      game = %{ game | tiles: List.replace_at(game.tiles, game.t2, %{Enum.at(game.tiles, game.t2) | matched: false})}
      game = %{game | flipped: false}
      game = %{game | t1: -1}
      game = %{game | t2: -1}
    else
      game = %{game | flipped: false}
      game = %{game | t1: -1}
      game = %{game | t2: -1}
    end
  end

  def deflip(game) do
    checkMatches(game)
  end

  def flip(game, tileNum) do
    IO.puts tileNum
    tileNum = Integer.parse(tileNum) |> elem(0)
    if (Enum.at(game.tiles, tileNum).matched == false) do
      if (tileNum != game.t1 && tileNum != game.t2) do
        if (game.t1 == -1) do
          game = %{game | t1: tileNum}
          game = %{game | clicks: game.clicks + 1}
          game = %{ game | tiles: List.replace_at(game.tiles, game.t1, %{Enum.at(game.tiles, game.t1) | matched: true})}
        else 
          if (game.t2 == -1) do
            game = %{game | t2: tileNum};
            game = %{game | flipped: true}
            game = %{game | clicks: game.clicks + 1}
            game = %{ game | tiles: List.replace_at(game.tiles, game.t2, %{Enum.at(game.tiles, game.t2) | matched: true})}
          else
            game
          end
        end
      else
        game
      end
    else 
      game
    end
  end

  def restart(game) do
    game = getBlankGame();
  end
end
