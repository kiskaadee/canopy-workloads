FROM gitea/act_runner:latest AS act-runner

FROM nixos/nix:latest

# Enable flakes and nix-command for CI workflows
RUN echo "experimental-features = nix-command flakes" >> /etc/nix/nix.conf

# Install Node.js (required by standard GitHub/Gitea Actions JS actions)
RUN nix-env -iA nixpkgs.nodejs \
    && nix-collect-garbage -d

# Ensure /bin/sleep exists (required by act_runner init)
RUN mkdir -p /bin \
    && ln -sf "$(command -v sleep)" /bin/sleep

# Copy static act_runner binary and entrypoint from official image
COPY --from=act-runner /usr/local/bin/act_runner /usr/local/bin/act_runner
COPY --from=act-runner /usr/local/bin/run.sh /usr/local/bin/run.sh

ENV PATH="/usr/local/bin:/root/.nix-profile/bin:/nix/var/nix/profiles/default/bin:/usr/bin:/bin"

ENTRYPOINT ["/usr/local/bin/run.sh"]
