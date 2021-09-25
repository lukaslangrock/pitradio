# Raspberry Pi Setup

The project uses a Raspberry Pi (a Pi 3 in our case) to host the website on a local network which all users connect to.

Needless to say, before you set up PitRadio on a fresh Raspbian install, you should do an update/upgrade and reboot before starting.

## Access Point Setup

As there are already great guides out there, it would be unnecessary to write a new one, so I'll just link to the official one from [raspberrypi.org](https://www.raspberrypi.org/documentation/computers/configuration.html#setting-up-a-routed-wireless-access-point). Make sure to follow the guide for a **routed** WAP and not a bridged one, as we want the network to be independent in case we are offline or want to restrict clients from accessing other resources on the host network.

If you wish to block access to the host network, just don't set up Routing and IP Masquerading, as described in the article.

In our setup, we used the network `192.168.10.0/24` and used `radio.local` as the router name (as opposed to `gw.wlan`).
We also set the SSID and passphrase to `pitradio`.

## Webserver Setup

The website is written in .NET 5, so we need to install it. Just execute the following line to install it:
```sh
curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --channel Current
```
In case you get a version that is not compatible with the application, you can change the `--channel` to specify version 5. 
