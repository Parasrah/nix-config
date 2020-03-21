{
  name = "battery";
  value = ''
  type = internal/battery
  full-at = 98

  format-charging = <animation-charging> <label-charging>
  format-discharging = <ramp-capacity> <label-discharging>
  format-full = <ramp-capacity> <label-full>

  ramp-capacity-0 = 
  ramp-capacity-0-foreground = #f53c3c
  ramp-capacity-1 = 
  ramp-capacity-1-foreground = #ffa900
  ramp-capacity-2 = 
  ramp-capacity-3 = 
  ramp-capacity-4 = 

  bar-capacity-width = 10
  bar-capacity-format = %{+u}%{+o}%fill%%empty%%{-u}%{-o}
  bar-capacity-fill = █
  bar-capacity-fill-foreground = #ddffffff
  bar-capacity-empty = █
  bar-capacity-empty-foreground = #44ffffff

  animation-charging-0 = 
  animation-charging-1 = 
  animation-charging-2 = 
  animation-charging-3 = 
  animation-charging-4 = 
  animation-charging-framerate = 750
  '';
}
