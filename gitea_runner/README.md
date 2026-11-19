# Gitea Actions Runner (`gitea_runner`)

Standalone `act_runner` for Gitea Actions, built with Nix (`nix-command` and `flakes` enabled), `git`, `bash`, and `nodejs` for **host-mode (`:host`)** execution.

## Architecture

- **Host-Mode Execution (`:host`)**: Core platform security bans direct Docker socket mounts and enforces a read-only `socket-proxy` (`POST=0`), so `act_runner` cannot spawn `docker://` job containers. Jobs run directly inside the runner container via `:host` labels (`ubuntu-latest:host,nix:host`).
- **Persistent State & Nix Cache**:
  - Runner registration and workspace state: `~/var/lib/homelab/gitea_runner:/data` (under `HOMELAB_STATE_ROOT`, default `~/var/lib/homelab`).
  - Nix store cache: named Docker volume `nix-store:/nix` so evaluated derivations persist across rebuilds.

## Configuration

See [`.env-example`](.env-example) for required runtime variables:

- `GITEA_INSTANCE_URL`: Internal or external Gitea URL (default `http://gitea:3000` over `proxy-net`).
- `GITEA_RUNNER_TOKEN`: One-time runner registration token (injected into `GITEA_RUNNER_REGISTRATION_TOKEN` in Compose).
- `GITEA_RUNNER_NAME`: Runner display name (default `homelab-runner`).
- `GITEA_RUNNER_LABELS`: Comma-separated `:host` labels (default `ubuntu-latest:host,nix:host`).
