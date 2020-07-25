{ lib, pipe }:

with lib;

let
  recursiveUpdateConcatUntil = pred: lhs: rhs:
    let
      f = attrPath:
        zipAttrsWith (
          name: values:
            let
              here = attrPath ++ [ name ];
            in
              if tail values == []
              || pred here (head (tail values)) (head values)
              then
                (
                  if all isList values
                  then pipe
                    [
                      concatLists
                      unique
                    ] values
                  else
                    head values
                )
              else
                f here values
        );
    in
      f [] [ rhs lhs ];
in
lhs: rhs:
  recursiveUpdateConcatUntil (
    path: lhs: rhs:
      !(isAttrs lhs && isAttrs rhs)
  ) lhs rhs
