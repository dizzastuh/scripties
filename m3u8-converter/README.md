# `m3u8` to `mp4` Converter

## Usage

Requires a config file, for now using a hard-coded name `stream-input.json`

The file should look like this:

```json
[
    {
        "src": "https://<SOURCE-OF-THE-M3U8-FILE>.m3u8",
        "name": "DestFileName" // NO FILE EXTENSION, mp4 will be appended
    },
    ...
]
```

This directory also includes a template `JSON` file for your convenience.

Each of streams included in the config will be downloaded in parallel to the current directory.  **SO MAKE SURE YOUR SYSTEM CAN WRITE TO THE CURRENT DIRECTORY.**

## Installation

Requires NodeJS

## Upcoming Upgrades

- better config file existence checking
- handling file format checking
