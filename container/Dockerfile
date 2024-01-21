FROM ubuntu:jammy-20240111 AS base

# HACK: To agree to the EULA when installing steamcmd
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN echo steam steam/question select "I AGREE" | debconf-set-selections \
	&& echo steam steam/license note '' | debconf-set-selections

RUN dpkg --add-architecture i386 \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends \
	ca-certificates locales steamcmd \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists \
	&& ln -s /usr/games/steamcmd /usr/bin/steamcmd

# Add unicode support
RUN locale-gen en_US.UTF-8
ENV LANG 'en_US.UTF-8'
ENV LANGUAGE 'en_US:en'

FROM base AS runner

ARG UID=1000
ARG GID=1000

RUN groupadd -g $GID palworld \
	&& useradd -m -u $UID -g $GID -s /bin/bash palworld \
	&& mkdir -p /palworld \
	&& chown -R palworld:palworld /palworld \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends \
	xdg-user-dirs procps \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists

USER palworld

# HACK: workaround for missing directories and libraries
RUN steamcmd +quit
RUN mkdir -p $HOME/.steam \
	&& ln -s $HOME/.local/share/Steam/steamcmd/linux32 $HOME/.steam/sdk32 \
	&& ln -s $HOME/.local/share/Steam/steamcmd/linux64 $HOME/.steam/sdk64 \
	&& ln -s $HOME/.steam/sdk32/steamclient.so $HOME/.steam/sdk32/steamservice.so \
	&& ln -s $HOME/.steam/sdk64/steamclient.so $HOME/.steam/sdk64/steamservice.so

WORKDIR /palworld

COPY --link --chown=palworld:palworld ./container/entrypoint.sh /palworld/entrypoint.sh
RUN chmod +x /palworld/entrypoint.sh

HEALTHCHECK --start-period=5m \
    CMD pgrep "PalServer-Linux" > /dev/null || exit 1

CMD [ "./entrypoint.sh" ]