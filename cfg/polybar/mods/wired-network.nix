{ interface }:

{
  name = "wired-network";
  value = ''
    type = internal/network
    interface = ${interface}
  '';
}
