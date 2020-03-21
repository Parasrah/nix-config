{}:
{
  name = "i3";
  value = ''
  type = internal/i3

  ws-icon-0 = "1:code;"
  ws-icon-1 = "2:web;"
  ws-icon-2 = "3:data;"
  ws-icon-3 = "4:view;"
  ws-icon-4 = "5:;"
  ws-icon-5 = "6;"
  ws-icon-6 = "7;"
  ws-icon-7 = "8;"
  ws-icon-8 = "9;"
  ws-icon-9 = "10;"

  index-sort = true
  ws-icon-default = 

  format = <label-state> <label-mode>

  label-focused = %icon%
  label-focused-foreground = #fff
  label-focused-background = #773f3f3f
  label-focused-underline = #c9665e
  label-focused-padding = 4

  label-unfocused = %icon%
  label-unfocused-foreground = #dd
  label-unfocused-underline = #666
  label-unfocused-padding = 4

  label-urgent = %icon%
  label-urgent-foreground = #000000
  label-urgent-background = #bd2c40
  label-urgent-underline = #9b0a20
  label-urgent-padding = 4

  label-visible = %icon%
  label-visible-foreground = #55
  label-visible-padding = 4
  '';
}
