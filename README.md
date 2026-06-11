# netqlty

Continuous network-quality logger for macOS. Loops forever: runs Apple's
built-in `networkQuality -v` tool every 5 minutes, parses the results, appends
them as CSV to `netqlty.txt`, and displays the most recent samples in the
terminal.

## Prerequisites

- macOS 12 (Monterey) or later — `networkQuality` ships with the OS
- bash (script is bash; invoked via its shebang)

## Usage

```bash
./monitor_network.sh
```

Leave it running in a terminal window. Stop with `Ctrl-C`.

## Output

Each sample appends one CSV row to `netqlty.txt` in the working directory:

```
date,upload_capacity,download_capacity,upload_flows,download_flows,responsiveness_level,responsiveness_rpm,rtt
```

A scratch file `netqlty.tmp` is created and removed on each cycle.

## Files

| File | Purpose |
|---|---|
| `monitor_network.sh` | The monitor loop: run `networkQuality`, parse, log, display |
| `netqlty.txt` | Accumulated CSV samples (runtime output, not committed) |

## CI

Every pull request, and every push to `main`, runs the `test` job of the CI
workflow ([.github/workflows/ci.yml](.github/workflows/ci.yml)): `shellcheck -S error`
on all shell scripts. The `test` check is required on `main` — PRs cannot
merge until it passes.

## Known limitations

- Output paths are relative to the working directory, not the script location.
- The 5-minute interval is hardcoded in `countdown()`.
- Parsing depends on `networkQuality -v` output wording; an OS update that
  rewords fields (e.g. `Responsiveness`) would log empty columns.
