# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) and the versioning try follows the [Semantic Versioning 2.0.0](https://semver.org/) specification.

Given a version number MAJOR.MINOR.PATCH:

- MAJOR version when making incompatible API changes,
- MINOR version when adding functionality in a backwards compatible manner,
- PATCH version when making backwards compatible bug fixes.

Each CHANGELOG entry may have these type of changes : added, changed, deprecated, removed, fixed, security

## [unreleased] 2021-01-02

### Changed

- Docker/entrypoint.sh now use environment variables passed by `docker run` command
- 0_build_image.sh now generates a local file with environemnt variables

### Removed

- Docker/entrypoint.sh.sample is no longer needed.
- mysecret.txt is no longer needed

## [0.2.0] 2020-12-25

### Added

#### More documentation

- Start this CHANGELOG
- README translated to english
- README gives context about why would you use this solution
- All Scripts now have a header metadata section for minimal documentation (last update, author, description)
- Script comments to explain code goal/flow

#### UX enhacement

- All interactive scripts now start with some metadata information printed in console
- start/stop_proxy_vpn scripts have more informative messages about the current task
- a wrapper script for macOS to launch start_proxy_vpn script and then launch Chrome browser with a specific profile

#### Container image

- Build script add an image tag YYYY.MM
- Build script removes dangling images
- add a .dockerignore file
- If mysecret.txt do not exists, VPN password is read from console at build time and output is written to mysecret.txt
- mysecret.txt is copied in `WORKDIR`

#### Repo grooming

- .gitignore file : exclude mysecret.txt from repo
- rename start/stop scripts

### Changed

#### Container image

- change base image for the latest available Ubuntu LTS version (18.04 > 20.04)
- maintainer (cpauliat > kral2)
- configure `/app` as the `WORKDIR`
- adjust squid.conf localnet cidr to 172.17.0.0/16
- image name is now proxy_vpn
- build script now use /bin/bash
- openconnect now starts with ipv6 disabled
- entrypoint.sh is renamed to entrypoint.sh.sample and need to be edited/renamed before usage

#### Faster ready time

- The 5s pause after container launch is not needed anymore
- Proxy and VPN readiness test starts as soon as the container is running
- Wait for 30s max if `TEST_URL` is not reachable yet
- If `TEST_URL`is reachable and with no error, print version information and exit

### Fixed

#### a Dockerfile more aligned with best practices

- declare the `maintainer` with the `LABEL` instruction (`MAINTAINER` is deprecated)
- declare the `WORKDIR` to put appplication files in it
- use relative paths to `WORKDIR`

#### Idempotency for start/stop scripts

- start_vpn_proxy script do not create a new container only if it is already running
- start_vpn_proxy scrupt refresh to container if it is in `EXITED` state
- stop_vpn_proxy script now check if a container with the given name exists (either RUNNING or EXITED) before trying to stop and remove 

#### Packages install with Ubuntu 20.04

- squid installation now requires to be explicitely run in non-interactive mode

### Security

- vpn password is no longer in the entrypoint script
- mysecret.txt is in .gitignore and set with `600` POSIX rights
- entrypoint script now reads vpn password from mysecret.txt

## [0.1.0] 2020-12-24

Initial commit:

- we already have a working proxy/vpn container.
- Initial work by mbordonne & cpauliat
