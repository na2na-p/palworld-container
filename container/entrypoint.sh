#!/usr/bin/env bash

# NOTE: コンテナイメージに含めると再配布にあたりそうなのでここでやる
steamcmd +force_install_dir /palworld +login anonymous +app_update 2394010 validate +quit

START_OPTIONS=""
if [[ -n $MULTI_THREAD ]] && [[ $MULTI_THREAD == "true" ]]; then
    START_OPTIONS="$START_OPTIONS -useperfthreads -NoAsyncLoadingThread -UseMultithreadForDS"
fi
if [[ -n $COMMUNITY_SERVER ]] && [[ $COMMUNITY_SERVER == "true" ]]; then
    START_OPTIONS="$START_OPTIONS EpicApp=PalServer"
fi

./PalServer.sh "$START_OPTIONS"