FROM nixpkgs/devcontainer

ARG PUID=1000
ARG PGID=1000
ARG USER=anvil

ARG PROJECT_NAME
ARG HOST_PROJECT_PATH
ARG TZ
ENV TZ=${TZ}

RUN groupadd --gid ${PGID} ${USER} \
  && useradd -s /bin/bash --uid ${PUID} --gid ${PGID} -m ${USER}

RUN mkdir -p /workspace/${PROJECT_NAME} && \
    chown -R ${USER}:${USER} /workspace/${PROJECT_NAME}

COPY --chmod=755 <<-"EOF" /etc/nix/nix.conf
filter-syscalls = false
experimental-features = nix-command flakes
extra-platforms = x86_64-linux aarch64-linux
build-users-group = nixbld
trusted-users = @admin @wheel ${USER}
EOF

COPY --chmod=755 <<-"EOF" /usr/local/bin/docker-entrypoint.sh
#!/bin/bash
echo "Running: $@"
exec $@
EOF

ADD default.nix /etc/nix/default.nix
RUN nix-env -if /etc/nix/default.nix

#USER ${USER}
  
# https://code.visualstudio.com/remote/advancedcontainers/start-processes#_adding-startup-commands-to-the-docker-image-instead
ENTRYPOINT [ "docker-entrypoint.sh" ]
CMD [ "sleep", "infinity" ]