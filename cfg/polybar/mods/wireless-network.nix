{ interface }:

{
  name = "wireless-network";
  value = ''
  type = internal/network
  interface = ${interface}
  interval = 3.0
  ping-interval = 10

  format-connected = <ramp-signal> <label-connected>
  label-connected = %essid%
  label-disconnected =  
  label-disconnected-foreground = #66

  ramp-signal-0 = 
  ramp-signal-1 = 
  ramp-signal-2 = 
  ramp-signal-3 = 
  ramp-signal-4 = 
  ramp-signal-5 = 

  animation-packetloss-0 = 
  animation-packetloss-0-foreground = #ffa64c
  animation-packetloss-1 = 
  animation-packetloss-1-foreground = ${bar/top.foreground}
  animation-packetloss-framerate = 500
  '';
}
