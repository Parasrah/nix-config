{}:
{
  name = "memory";
  value = ''
    type = internal/memory
    format = <label> <bar-used>
    label = RAM

    bar-used-width = 30
    bar-used-foreground-0 = #aaff77
    bar-used-foreground-1 = #aaff77
    bar-used-foreground-2 = #fba922
    bar-used-foreground-3 = #ff5555
    bar-used-indicator = |
    bar-used-indicator-foreground = #ff
    bar-used-fill = ─
    bar-used-empty = ─
    bar-used-empty-foreground = #444444
  '';
}
