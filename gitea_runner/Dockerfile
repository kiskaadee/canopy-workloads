FROM nixos/nix:2.24.12 AS nix-src
RUN tar -czf /nix-seed.tar.gz -C /nix .

FROM gitea/act_runner:0.6.1

RUN apk add --no-cache nodejs npm bash git coreutils ca-certificates

# Regular file (never a symlink into /nix/store) so nix-store volume mounts cannot break it
RUN mkdir -p /etc/nix /nix && \
    printf '%s\n' \
      'sandbox = false' \
      'experimental-features = nix-command flakes' \
      'trusted-public-keys = cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=' \
      > /etc/nix/nix.conf

COPY --from=nix-src /nix /nix
COPY --from=nix-src /nix-seed.tar.gz /opt/nix-seed.tar.gz
COPY entrypoint-nix.sh /usr/local/bin/entrypoint-nix.sh
RUN chmod +x /usr/local/bin/entrypoint-nix.sh

ENV PATH="/usr/local/bin:/nix/var/nix/profiles/default/bin:/usr/bin:/bin"

ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/entrypoint-nix.sh"]
