module ExprEval (Expr(..), parseExpr, eval) where

import Data.Char (isDigit, isSpace)

-- Algebraic Data Type representing an arithmetic expression tree.
data Expr
  = Num Double
  | Add Expr Expr
  | Sub Expr Expr
  | Mul Expr Expr
  | Div Expr Expr
  deriving Show

-- Evaluate an expression tree to a single numeric result.
eval :: Expr -> Double
eval (Num n)   = n
eval (Add a b) = eval a + eval b
eval (Sub a b) = eval a - eval b
eval (Mul a b) = eval a * eval b
eval (Div a b) = eval a / eval b

-- A minimal recursive-descent parser respecting + - * / and parentheses,
-- with the grammar structured so that * and / bind tighter than + and -:
--
--   expr   ::= term (('+' | '-') term)*
--   term   ::= factor (('*' | '/') factor)*
--   factor ::= number | '(' expr ')'

parseExpr :: String -> Expr
parseExpr s = case expr (filter (not . isSpace) s) of
  (e, "")   -> e
  (_, rest) -> error ("parseExpr: unexpected input near: " ++ rest)

expr :: String -> (Expr, String)
expr s = go t rest
  where
    (t, rest) = term s
    go acc ('+':r) = let (t', r') = term r in go (Add acc t') r'
    go acc ('-':r) = let (t', r') = term r in go (Sub acc t') r'
    go acc r       = (acc, r)

term :: String -> (Expr, String)
term s = go f rest
  where
    (f, rest) = factor s
    go acc ('*':r) = let (f', r') = factor r in go (Mul acc f') r'
    go acc ('/':r) = let (f', r') = factor r in go (Div acc f') r'
    go acc r       = (acc, r)

factor :: String -> (Expr, String)
factor ('(':rest) =
  case expr rest of
    (e, ')':rest') -> (e, rest')
    _               -> error "factor: expected closing parenthesis"
factor s =
  let (digits, rest) = span (\c -> isDigit c || c == '.') s
  in if null digits
       then error ("factor: expected a number, got: " ++ s)
       else (Num (read digits), rest)

main :: IO ()
main = do
  let inputs = ["3+4*2", "(1+2)*(3+4)", "10/2-3"]
  mapM_ (\i -> putStrLn (i ++ " = " ++ show (eval (parseExpr i)))) inputs
