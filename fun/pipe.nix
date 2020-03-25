{ lib }:

with lib;

fns: input:
  lists.foldr
    (fn: aggregate:
      fn aggregate
    )
    input
    (lists.reverseList fns)
