# Changelog

All notable changes to this repository are documented here.
Format: [Keep a Changelog](https://keepachangelog.com), date-based sections.

## 2026-06-10

### Added

- `ci`: GitHub Actions CI workflow (`test` job) — `shellcheck -S error` on all shell scripts, every PR and push to `master` (this repo's default branch).
- `docs`: README (purpose, usage, output format, CI, known limitations).

### Fixed

- `fix`: `monitor_network.sh` had no shebang (shellcheck SC2148) — added `#!/bin/bash`; the script uses bash syntax (`[[ ]]`-free but `$(( ))`, process substitution).
