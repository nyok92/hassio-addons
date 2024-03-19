# Home Assistant Add-on: Kopia add-on

## About

This Addon-on allows you to run [Kopia](https://www.kopia.io/) on a device running [Home Assistant](https://www.home-assistant.io/).

## Introduction

[Kopia](https://www.kopia.io/) Fast and Secure Open-Source Backup Software.

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

-Backup Files and Directories Using Snapshots
-Policies Control What and How Files/Directories are Saved in Snapshots
-Save Snapshots to Cloud, Network, or Local Storage
-Restore Snapshots Using Multiple Methods
-End-to-End ‘Zero Knowledge’ Encryption
-Compression
-Error Correction
-Verifying Backup Validity and Consistency
-Recovering Backed Up Data When There is Data Loss
-Regular Automatic Maintenance of Repositories
-Caching
-Both Command Line and Graphical User Interfaces
-Optional Server Mode with API Support to Centrally Manage Backups of Multiple Machines
-Speed

## Installation

Add the repository [https://github.com/nyok92/hassio-addons](https://github.com/nyok92/hassio-addons) in Home Assistant, see [https://www.home-assistant.io/hassio/installing_third_party_addons/](https://www.home-assistant.io/hassio/installing_third_party_addons/).

## Configuration

**Note**: _Remember to restart the add-on when the configuration is changed._

Example add-on configuration:

```json
{
  "ssl": false,
  "certfile": "fullchain.pem",
  "keyfile": "privkey.pem"
}
```

### Option: `ssl`

Enables or disables encrypted SSL/TLS (HTTPS) connections to the web server of this add-on.
Set it to `true` to encrypt communications, `false` otherwise.
Please note that if you set this to `true` you must also generate the key and certificate
files for encryption. For example using [Let's Encrypt](https://www.home-assistant.io/addons/lets_encrypt/)
or [Self-signed certificates](https://www.home-assistant.io/docs/ecosystem/certificates/tls_self_signed_certificate/).

### Option: `certfile`

The certificate file to use for SSL. If this file doesn't exist, the add-on start will fail.

**Note**: The file MUST be stored in `/ssl/`, which is the default for Home Assistant

### Option: `keyfile`

The private key file to use for SSL. If this file doesn't exist, the add-on start will fail.

**Note**: The file MUST be stored in `/ssl/`, which is the default for Home Assistant

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
check [the contributor's page](https://github.com/nyok92/hassio-addons/graphs/contributors).

## License

Duplicati is licensed under LGPL and available for Windows and Linux. The software is open source and free to use, even commercially. More information about the LGPL licensing model can be found in License Agreement.
