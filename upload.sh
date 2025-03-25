#! /bin/bash

sftp -i coderox.se.key -oPort=2022 coderox@localhost <<< $'put ./1password-latest.deb'