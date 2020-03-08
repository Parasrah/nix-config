{ hostname, interface }:

{
  hostName = hostname;
  # wpa_supplicant
  # wireless.enable = true;
  # network manager
  networkmanager.enable = true;

  interfaces."${interface}".useDHCP = true;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  useDHCP = false;

  firewall.enable = true;
  firewall.allowedTCPPorts = [ ];
  firewall.allowedUDPPorts = [ ];

  wg-quick.interfaces = {
    wg0 = {
      address = [ "192.168.10.2" ];
      privateKey = builtins.readFile ../../secrets/wireguard/privatekey;
      listenPort = 21841;
      peers = [
        {
          publicKey = builtins.readFile ../../secrets/wireguard/s_publickey;
          endpoint = "152.44.46.200:51820";
          allowedIPs = [ "0.0.0.0/0" "::/0" ];
          persistentKeepalive = 21;
        }
      ];
    };
  };
}
