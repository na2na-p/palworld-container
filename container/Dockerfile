FROM cm2network/steamcmd:root

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
	xdg-user-dirs=0.17-2 \
    procps=2:3.3.17-5 \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists

USER steam

WORKDIR /palworld

RUN chown -R steam:steam /palworld

RUN /home/steam/steamcmd/steamcmd.sh +force_install_dir "/palworld" +login anonymous +app_update 2394010 validate +quit

HEALTHCHECK CMD pgrep "PalServer-Linux" > /dev/null || exit 1
CMD [ "./PalServer.sh", "-useperfthreads", "-NoAsyncLoadingThread", "-UseMultithreadForD" ]