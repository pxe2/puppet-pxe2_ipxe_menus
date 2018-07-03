#! /usr/bin/env bash
openssl enc -d -aes256 -in secrets.tar.enc | tar xz -C .