id:

{
  wg0 = {
    address = [ "192.168.10.${builtins.toString id}" ];
     privateKey = builtins.readFile ../../secrets/wireguard/privatekey;
     listenPort = 21841;
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
