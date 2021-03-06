FROM gitpod/workspace-full-vnc:latest

USER root
# Install custom tools, runtime, etc.
RUN apt-get update \
    # window manager
    && apt-get install -y jwm \
    # electron
    && apt-get install -y libgtk-3-0 libnss3 libasound2 \
    # native-keymap
    && apt-get install -y libx11-dev libxkbfile-dev \
    && apt-get clean && rm -rf /var/cache/apt/* && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/*

USER gitpod
# Apply user-specific settings
RUN bash -c ". .nvm/nvm.sh \
    && nvm install 12 \
    && nvm use 12 \
    && npm install -g yarn"

RUN bash -c ". /home/gitpod/.sdkman/bin/sdkman-init.sh \
             && sdk install java 11.0.8.hs-adpt \
             && sdk default java 11.0.8.hs-adpt"

# Give back control
USER root