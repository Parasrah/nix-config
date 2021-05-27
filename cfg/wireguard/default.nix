{ id, config, name }:
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
    privateKeyFile = secrets."wireguard_${name}_private_key".path;
    peers = [
      {
        publicKey = "6QzVK+uE+N7WbCh+RuGUPUdfEVm3/a/kFCj3my7mIE8=";
        endpoint = "kali.parasrah.com:51820";
        allowedIPs = [ "0.0.0.0/0" "::/0" ];
        persistentKeepalive = 21;
      }
    ];
  };
}
