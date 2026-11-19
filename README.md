# 🌐 Canopy Workloads

This repository contains the decoupled, portable application stacks managed by the Canopy homelab platform behind a **Traefik Reverse Proxy** and the `nixos-core` `appctl` / `gitops_dispatcher` control plane.

---

## 🏗️ Architectural Concept

Each workload lives in its own top-level directory with a declarative `app.yaml` manifest (`schemaVersion: "1.0"`) and a `docker-compose.yml` baseline. Workloads attach to the shared external Docker network (`proxy-net`) and expose Traefik routing labels parameterized via runtime environment variables.

The root [`deployments.yaml`](deployments.yaml) serves as the authoritative workload admission registry, mapping each workload identity and its legacy webhook aliases to `~/Workloads/<app>`.

---

## 🔑 Environment Variable Injection

To prevent secret leakage and hardcoded host configuration, compose baselines do not embed personal domains, UIDs, or host-specific paths. Runtime values (`SERVICE_DOMAIN`, `PROXY_NETWORK`, `CERT_RESOLVER`, secrets, and app-specific overrides) are injected at execution time by the host control plane (`sops-nix` rendered environment + `appctl`) or a local `.env` file for standalone portability:

```bash
docker compose --env-file .env up -d
```

---

## 📁 Repository Structure

* **`deployments.yaml`**: Authoritative workload admission registry (`schemaVersion: "1.0"`).
* **`gitea/`**: Self-hosted Git service and code repository.
* **`gitea_runner/`**: Standalone Gitea Actions CI/CD runner (`act_runner`).
* **`snappymail/`**: Lightweight webmail client.
* **`jellyfin/`**: Media server and streaming hub.
* **`armonia/`**: Armonía del Ser API and operator dashboard.
