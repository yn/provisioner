#!/bin/sh
finger $(whoami) | perl -ne '/Name: ([a-zA-Z0-9 ]{1,})/ && print "$1\n"'
