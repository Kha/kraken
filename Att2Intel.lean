import Kraken.Semantics
import Kraken.Parser

open Kraken.Parser

def main (args : List String) : IO UInt32 := do
  if args.isEmpty then
    IO.eprintln "Usage: att2intel <assembly.S>"
    return 1

  let asmCode ← IO.FS.readFile args[0]!

  match Kraken.Parser.parse asmCode with
  | .ok prog =>
      IO.println ".intel_syntax noprefix"
      for d in prog do
        IO.println (toString d)
      return 0
  | .error e =>
      IO.eprintln s!"Parse Error: {e}"
      return 1
