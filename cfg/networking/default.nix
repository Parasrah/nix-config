{ hostname, interface }:

{
  hostName = hostname;
  # wpa_supplicant
  # wireless.enable = true;
  # network manager
  networkmanager.enable = true;

  interfaces."${interface}".useDHCP = true;
  # interfaces.wlp2s0.useDHCP = true;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  useDHCP = false;

  firewall.enable = true;
  firewall.allowedTCPPorts = [ ];
  firewall.allowedUDPPorts = [ ];
}
