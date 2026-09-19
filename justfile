#!/usr/bin/env -S just --justfile
set allow-duplicate-recipes

import? '.common-just/justfile'

# Use powershell for Windows so that 'Git Bash' and 'PyCharm Terminal' get the same result
set windows-powershell

system-info:
    @just _init
    @echo "This is an {{ arch() }} machine running on {{ os_family() }}"
    just --list

[unix]
_init:
    @bash -c 'target=".common-just"; if [ -d "$target" ] || git submodule | grep -q "$target"; then just _just_up; else just init "$([[ $(git remote get-url origin 2>/dev/null) == git@github.com:* ]] && echo "ssh")"; fi'

[windows]
_init command *args:
    # if (-Not (Test-Path '.common-just')) { just init } else { just _just_up }
    $target=".common-just"; if ((Test-Path $target -PathType Container) -or (git submodule | Select-String $target -Quiet)) { just _just_up } else { $remoteUrl = git remote get-url origin 2>$null; if ($remoteUrl -match "^git@github\.com:") { just init ssh } else { just init } }

init scheme="http":
    git submodule add {{ if scheme == "ssh" { "git@github.com:" } else { "https://github.com/" } }}waketzheng/python-backend-justfile .common-just

_just_up *args:
    git submodule update --init --merge --recursive --remote --force {{ args }}
