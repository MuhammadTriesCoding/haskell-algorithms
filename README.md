# haskell-algorithms

Recursive algorithms and functional programming exercises in Haskell — sorting, tree traversal, and a backtracking puzzle solver.

## Overview

This repo collects functional programming work built while studying COMP1100 (Programming as Problem Solving) at the Australian National University, plus self-directed practice beyond the course. The focus throughout is on writing correct, composable solutions using Haskell's core features — recursion, pattern matching, and algebraic data types — rather than translating imperative habits into a new syntax.

## What's inside

- **`RadixSort.hs`** — An LSD radix sort implementation, sorting by digit/character position from least to most significant. Demonstrates recursion over data and complexity-aware algorithm design.
- **`PuzzleSolver.hs`** — A backtracking solver (maze) that explores candidate states recursively and prunes invalid branches. Demonstrates pattern matching and problem decomposition.
- **`ExprEval.hs`** — A small expression parser and evaluator for arithmetic expressions, built around a custom Algebraic Data Type to represent the expression tree. Demonstrates ADTs and structural recursion working together.


## Concepts demonstrated

- Pure functions and immutable data
- Recursion and structural induction
- Algebraic Data Types (ADTs)
- Pattern matching
- Higher-order functions
- Complexity analysis and algorithm design

## Running the code

Each file can be loaded directly into GHCi:

```bash
ghci RadixSort.hs
```

Or compiled and run with GHC:

```bash
ghc -o radixsort RadixSort.hs
./radixsort
```

## Background

Written using Haskell, Git, and a Linux/VS Code development environment as part of coursework at ANU. This repo is part of a broader portfolio spanning object-oriented programming (Java), relational databases (SQL), and formal verification (Dafny) — see [profile](https://github.com/MuhammadTriesCoding) for the rest.
