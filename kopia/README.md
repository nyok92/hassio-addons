# Home Assistant Add-on: Kopia add-on

## About

[![Builder](https://github.com/nyok92/hassio-addons/actions/workflows/builder.yaml/badge.svg?branch=main)](https://github.com/nyok92/hassio-addons/actions/workflows/builder.yaml)
[![Lint](https://github.com/nyok92/hassio-addons/actions/workflows/lint.yaml/badge.svg)](https://github.com/nyok92/hassio-addons/actions/workflows/lint.yaml)

![Supports amd64 Architecture][amd64-shield]
![Supports armhf Architecture][armhf-shield]
![Supports armv7 Architecture][armv7-shield]
![Supports aarch64 Architecture][aarch64-shield]
![Supports i386 Architecture][i386-shield]

This Addon-on allows you to run [Kopia](https://www.kopia.io/) on a device running [Home Assistant](https://www.home-assistant.io/).

## Introduction

[kopia](https://www.kopia.io/) is a Fast and Secure Open-Source Backup Software

It works with:

Amazon S3 and any cloud storage that is compatible with S3
Azure Blob Storage
Backblaze B2
Google Cloud Storage
Any remote server or cloud storage that supports WebDAV
Any remote server or cloud storage that supports SFTP
Some of the cloud storages supported by Rclone
Requires you to download and setup Rclone in addition to Kopia, but after that Kopia manages/runs Rclone for you
Rclone support is experimental: not all the cloud storages supported by Rclone have been tested to work with Kopia, and some may not work with Kopia; Kopia has been tested to work with Dropbox, OneDrive, and Google Drive through Rclone
Your own server by setting up a Kopia Repository Server

## Features

Backup Files and Directories Using Snapshots
Policies Control What and How Files/Directories are Saved in Snapshots
Save Snapshots to Cloud, Network, or Local Storage
Restore Snapshots Using Multiple Methods
End-to-End ‘Zero Knowledge’ Encryption
Compression
Error Correction
Verifying Backup Validity and Consistency
Recovering Backed Up Data When There is Data Loss
Regular Automatic Maintenance of Repositories
Caching
Both Command Line and Graphical User Interfaces
Optional Server Mode with API Support to Centrally Manage Backups of Multiple Machines
Speed

## Installation

Add the repository [https://github.com/nyok92/hassio-addons](https://github.com/nyok92/hassio-addons) in Home Assistant, see [https://www.home-assistant.io/hassio/installing_third_party_addons/](https://www.home-assistant.io/hassio/installing_third_party_addons/).

[![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL pre-filled.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Fnyok92%2Fhassio-addons)

## Support

Got questions?

You could also [open an issue here](https://github.com/nyok92/hassio-addons/issues/new/choose) GitHub.

## Contributing

This is an active open-source project. We are always open to people who want to
use the code or contribute to it.

Thank you for being involved! :heart_eyes:

## Authors & contributors

The original setup of this repository is by [nyok92](https://github.com/nyok92).

For a full list of all authors and contributors,
check [the contributor's page](https://github.com/nyok92/hassioo-addons/graphs/contributors).

## License

Duplicati is licensed under LGPL and available for Windows and Linux. The software is open source and free to use, even commercially. More information about the LGPL licensing model can be found in License Agreement.

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[armhf-shield]: https://img.shields.io/badge/armhf-yes-green.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
[i386-shield]: https://img.shields.io/badge/i386-yes-green.svg
