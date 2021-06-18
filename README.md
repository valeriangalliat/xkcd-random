# xkcd-random

> Get a random xkcd, CLI or as a service.

## Overview

This was created following [this tweet](https://twitter.com/valeriangalliat/status/685954780913659905),
allowing this service to be used as a random image placeholder service
taking images from [xkcd](https://xkcd.com/).

## Installation

Add the repository directory to your `PATH`.

## Usage

```sh
# Get the direct image URL of a random xkcd
xkcd-random

# Same as CGI (redirecting to the image)
xkcd-random-cgi
```

## Deployment

Example deployment on a NixOS system (import the following web server
configuration in your `configuration.nix`):

```nix
{ config, pkgs, ... }:

let xkcdRandom = pkgs.callPackage /path/to/xkcd-random {};
in {
  services.nginx.enable = true;

  services.nginx.httpConfig = ''
    server {
      listen       80;
      server_name  _;

      location / {
        fastcgi_pass   unix:${config.services.fcgiwrap.socketAddress};
        fastcgi_param  SCRIPT_FILENAME ${xkcdRandom}/bin/xkcd-random-cgi;
      }
    }
  '';

  services.fcgiwrap.enable = true;

  networking.firewall.allowedTCPPorts = [ 80 ];
}
```
