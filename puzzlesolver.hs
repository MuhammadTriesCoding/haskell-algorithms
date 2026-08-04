module PuzzleSolver (solve, Maze, Pos) where

import Data.List (find)

-- A maze is a grid of characters:
--   '#' = wall, '.' = open path, 'S' = start, 'E' = end
type Maze = [String]
type Pos  = (Int, Int) -- (row, col)

-- Solve a maze by backtracking (depth-first search): from the current
-- position, try each unvisited neighbour in turn; if a neighbour leads
-- to a dead end, backtrack and try the next one.
solve :: Maze -> Maybe [Pos]
solve maze = do
  start <- findChar 'S' maze
  end   <- findChar 'E' maze
  go [start] start end
  where
    go visited pos end
      | pos == end = Just (reverse visited)
      | otherwise =
          firstJust
            [ go (next : visited) next end
            | next <- neighbours maze pos
            , next `notElem` visited
            ]

    firstJust []           = Nothing
    firstJust (Nothing:xs) = firstJust xs
    firstJust (Just x:_)   = Just x

-- Find the (row, col) of the first occurrence of a character in the maze.
findChar :: Char -> Maze -> Maybe Pos
findChar c maze =
  fst <$> find ((== c) . snd)
    [ ((r, col), cell)
    | (r, row) <- zip [0 ..] maze
    , (col, cell) <- zip [0 ..] row
    ]

-- Valid, in-bounds, non-wall neighbours (up, down, left, right) of a cell.
neighbours :: Maze -> Pos -> [Pos]
neighbours maze (r, c) =
  [ (r', c')
  | (dr, dc) <- [(-1, 0), (1, 0), (0, -1), (0, 1)]
  , let r' = r + dr
  , let c' = c + dc
  , inBounds r' c'
  , cellAt r' c' /= '#'
  ]
  where
    inBounds r' c' = r' >= 0 && r' < length maze && c' >= 0 && c' < length (head maze)
    cellAt r' c' = (maze !! r') !! c'

-- Render the maze with the solution path marked as '*' (start/end kept as-is).
showSolved :: Maze -> [Pos] -> String
showSolved maze path =
  unlines
    [ [ markIfOnPath (r, c) cell | (c, cell) <- zip [0 ..] row ]
    | (r, row) <- zip [0 ..] maze
    ]
  where
    markIfOnPath pos cell
      | cell `elem` ("SE" :: String) = cell
      | pos `elem` path              = '*'
      | otherwise                    = cell

main :: IO ()
main = do
  let maze =
        [ "S.#...."
        , "..#.##."
        , "..#.#.."
        , "....#.#"
        , ".##.#.."
        , "......E"
        ]
  case solve maze of
    Just path -> putStrLn (showSolved maze path)
    Nothing   -> putStrLn "No path found."
