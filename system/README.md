# system/

Scripts that must be installed **root-owned into a system path**, rather than
symlinked into `~/.local/bin` like everything in `bin/`.

They live here instead of `bin/` for one reason: they are invoked with `sudo`.
A `sudo`-invoked script that is writable by your user is a privilege-escalation
path — anything that can write your dotfiles gets root. So the repo holds the
source of truth, and the matching `runs/` script installs a **copy** owned by
root with mode 755.

That means editing a script here does not change the installed copy. Re-run its
`runs/` script to push the change out.

| Script | Installed to | Installed by | Needs |
|--------|--------------|--------------|-------|
| `kfrgb-retry` | `/usr/local/bin/kfrgb-retry` | `runs/97-kfrgb` | `kfrgb` at `/usr/local/bin/kfrgb`; `i2c-tools`, `yad`, `lshw` (installed by `runs/97-kfrgb`) |

## kfrgb-retry

Wraps [kfrgb](https://github.com/KeyofBlueS/kfrgb) (GPL-3.0, by KeyofBlueS) to
drive the Kingston Fury RAM lighting. SMBus detection for one of the two sticks
on this board is intermittently flaky even with `--wait` tuning, so the wrapper
retries the whole call up to five times, stays silent on success, and prints
kfrgb's last output only if every attempt fails.

Driven by the `ramon` / `ramoff` aliases in `.zshrc`.

**Machine-specific values** — `SMBUS=22` and `SLOTS=2,4` are correct for the
Gigabyte Z790 UD AX. On different hardware, find yours with
`kfrgb --list-smbus` and adjust.

**kfrgb itself is not vendored here.** It is a 116 KB third-party script under a
different licence, and it self-updates (note the `.bak-<version>` file it leaves
in `/opt/kfrgb`). `runs/97-kfrgb` checks for it and tells you how to install it
if missing, rather than shipping a stale copy.
