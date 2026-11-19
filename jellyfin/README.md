# Jellyfin

Jellyfin is a free and open-source media system that lets you control media stream access to movies, shows, music, and more.

---

## 🚀 Deployment

This service is managed as part of the unified Traefik deployments stack.

To start:
```bash
appctl up jellyfin
```

Refer to the root [README.md](../README.md) for details on how environment variables are securely injected at runtime.

---

## 📦 Volumes

- `../../var/lib/homelab/jellyfin/config`: Application data and configuration.
- `../../var/lib/homelab/jellyfin/cache`: Metadata and transcode cache.
- `../../var/lib/homelab/jellyfin/media`: Media library (mounted read-only).
