{}:
{
  name = "backlight";
  value = ''
    type = internal/xbacklight
    format = <ramp> <bar>

    ramp-0 = 
    ramp-1 = 
    ramp-2 = 

    bar-width = 10
    bar-indicator = |
    bar-indicator-foreground = #ff
    bar-fill = ─
    bar-fill-foreground = #c9665e
    bar-empty = ─
    bar-empty-foreground = #44
  '';
}
