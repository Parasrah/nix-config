{ id, config }:
let
  wgIpv4Address = id: "192.168.10.${builtins.toString id}";

  wgIpv6Address = id: "fdc9:ed32:ed32:ed32::${builtins.toString id}";

  peerAddresses = id: [
    "${wgIpv4Address id}/24"
    "${wgIpv6Address id}/64"
  ];

  inherit (config.sops) secrets;

in
{
  wg0 = {
    address = peerAddresses id;
    privateKeyFile = secrets.wireguard_client_private_key.path;
    peers = [
      {
        publicKey = "mnMS75gHAoSr/HyZ0NxppZt3B1IZ9Iq3uVoxay3BVxs=";
        endpoint = "kali.parasrah.com:51820";
        allowedIPs = [ "0.0.0.0/0" "::/0" ];
        persistentKeepalive = 21;
      }
    ];
  };
}
