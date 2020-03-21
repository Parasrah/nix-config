{ lib }:

let
  lists =
    lib.lists;

in
fns: input:
  lists.foldr
    (fn: aggregate:
      fn aggregate
    )
    input
    fns
