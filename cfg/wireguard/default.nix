{ id, config }:
let
  wgIpv4Address = id: "192.168.10.${builtins.toString id}";

  wgIpv6Address = id: "fdc9:ed32:ed32:ed32::${builtins.toString id}";

  peerAddresses = id: [
    "${wgIpv4Address id}/24"
    "${wgIpv6Address id}/64"
  ];

in
{
  wg0 = {
    address = peerAddresses id;
    privateKey = builtins.readFile config.sops.secrets.wireguard_client_private_key.path;
    peers = [
      {
        publicKey = builtins.readFile config.sops.secrets.wireguard_server_public_key.path;
        endpoint = builtins.readFile config.sops.secrets.wireguard_address.path;
        allowedIPs = [ "0.0.0.0/0" "::/0" ];
        persistentKeepalive = 21;
      }
    ];
  };
}
