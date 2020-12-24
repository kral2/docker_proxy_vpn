# Container Proxy_VPN

Proxy_VPN is a Docker container image that combines Squid and Openconnect VPN for a better user experience when:

- you prefer to not install VPN client software on your local computer,
- you want to keep an unmodified network access for your local computer, without relying on the VPN policies or configuration.

In the current architecture, the Container assume two roles:

1. initiating a VPN session to your private resources,
2. exposing a Proxy to the container host, so private resources behind the VPN are reachable from your local computer.

## Requirements

- a Docker host running on your local computer,
- bash interpreter.

## How to get started?

- modify entrypoint.sh.sample script : change your vpn connection url, your user name and rename it to entrypoint.sh 
- execute entrypoint.sh and type your vpn password when prompted
- execute 0_build_image.sh to build the container image from the Dockerfile
- modify start_proxy_vpn.sh.sample script : change `TEST_URL`, `VPN_NAME` and rename it to start_proxy_vpn.sh
- execute start_proxy_vpn.sh to create container.
- configure your system or your internet browser to use localhost:3233 as your proxy

## macOS UX

A small helper script is provided for easier interaction with the solution: intranet.command
It is a wrapper script that will do the following actions:

- execute start_proxy_vpn.sh
- launch Chrome wih a specific profile.

For best usage of this helper, you should modify it to suit your environment then rename it (removing the `.sample` extension).

Some Browser configuration is implied for as a prerequisite:

- create a new browser profile dedicated for proxy_vpn usage and retrieve its id number (type `chrome://version/`in the address bar),
- install a Chrome extension that allows you to specify a proxy and configure it (I use Foxy Proxy), 

Once everything is setup, you can simply launch `intranet.command` from the spotlight launcher:

- proxy_vpn will be launched,
- Chrome with the profile configured for your local proxy usage will be launched.

Browser and extension may be changed for other components that better suit your needs.

## For more than HTTP/HTTPS

You can already reach your private resources with any protocol configured in Squid (ftp, ssh, gopher, etc ...)

But you can also combine this solution with tools like [corkscrew](https://github.com/bryanpkc/corkscrew) to reach SSH private targets.

## Visibility

Your Proxy logs are redirected to your computer in a local folder. Thanks Docker Volumes.

## Next versions

Some ideas about what could come next:

- Visibility: redirect Openconnect VPN logs to a Docker Volume
- Security: conceal the vpnpassword in a local vault solution
- Architecture: split to dedicated containers for proxy and vpn roles
- Availability: use a container orchestration solution to act as a watchdog 

## Maintainers and Contributors

The initial idea and prototype were created by Matthieu Bordonné.
Version 0.1.0 is the code adapted by [Christophe Pauliat](https://github.com/cpauliat), containing helper scripts for easier day-to-day interaction on a user computer.

Current version is actually maintained by [Çetin Ardal](https://github.com/kral2).

## Contributing

This project is open source : all contributions are welcome.

- for small typo/enhancements, just [Fork this on GitHub](https://github.com/kral2/docker_proxy_vpn/fork) and submit a [Pull Request](https://github.com/kral2/docker_proxy_vpn/pulls),
- for new features or substantial changes, please open an [Issue](https://github.com/kral2/docker_proxy_vpn/issues) first to discuss about the intended change.

## License

This project is licensed under the GNU GPLv3 License. see [COPYING](./COPYING)
