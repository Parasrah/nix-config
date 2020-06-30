id:
let
  wgIpv4Address = id: "192.168.10.${builtins.toString id}";

  wgIpv6Address = id: "ed32:ed32:ed32:ed32::${builtins.toString id}";

  peerAddresses = id: [
    "${wgIpv4Address id}/24"
    "${wgIpv6Address id}/64"
  ];

in
{
  wg0 = {
    address = peerAddresses id;
    privateKey = builtins.readFile ../../secrets/wireguard/privatekey;
    peers = [
      {
        publicKey = builtins.readFile ../../secrets/wireguard/s_publickey;
        endpoint = builtins.readFile ../../secrets/wireguard/address;
        allowedIPs = [ "0.0.0.0/0" "::/0" ];
        persistentKeepalive = 21;
      }
    ];
  };
}
