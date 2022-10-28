FROM ubuntu:22.04

# Change /bin/sh to /bin/bash
SHELL ["/bin/bash", "-c"]

ARG FLUTTER_VERSION

# Install Dependencies.
RUN apt-get update -y
RUN apt-get install -y \
  git \
  wget \
  curl \
  unzip \
  lib32stdc++6 \
  libglu1-mesa \
  default-jdk \
  clang \
  cmake \
  ninja-build \
  pkg-config \
  android-sdk

RUN ls /usr/lib/android-sdk/tools/bin

# Install the Android SDK Dependency.
ENV ANDROID_SDK_ROOT="/usr/lib/android-sdk"
ENV ANDROID_HOME="${ANDROID_TOOLS_ROOT}"
ENV ANDROID_TOOLS_ROOT="/usr/lib/android-sdk/tools"

ENV CMD_TOOLS_URL="https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip"
ENV ANDROID_SDK_ARCHIVE="${ANDROID_TOOLS_ROOT}/archive"
RUN wget -q "${CMD_TOOLS_URL}" -O "${ANDROID_SDK_ARCHIVE}"
RUN unzip -q -d "${ANDROID_TOOLS_ROOT}" "${ANDROID_SDK_ARCHIVE}"
ENV ANDROID_CMD_TOOLS="${ANDROID_TOOLS_ROOT}/cmdline-tools/bin"

ENV PATH="${ANDROID_CMD_TOOLS}/:${PATH}"
ENV PATH="${ANDROID_TOOLS_ROOT}/:${PATH}"
ENV PATH="${ANDROID_SDK_ROOT}/:${PATH}"
ENV PATH="${ANDROID_SDK_ROOT}/bin:${PATH}"

RUN yes "y" | "${ANDROID_CMD_TOOLS}/sdkmanager" --sdk_root="${ANDROID_SDK_ROOT}" "platforms;android-31"
RUN yes "y" | "${ANDROID_CMD_TOOLS}/sdkmanager" --sdk_root="${ANDROID_SDK_ROOT}" "platform-tools"
RUN yes "y" | "${ANDROID_CMD_TOOLS}/sdkmanager" --sdk_root="${ANDROID_SDK_ROOT}" --install "cmdline-tools;latest"

# Install Flutter.
ENV FLUTTER_ROOT="/opt/flutter"
RUN if [ "${FLUTTER_VERSION}" = "latest" ] ; then git clone https://github.com/flutter/flutter "${FLUTTER_ROOT}" ; else git clone -b "${FLUTTER_VERSION}" https://github.com/flutter/flutter "${FLUTTER_ROOT}" ; fi
ENV PATH="${FLUTTER_ROOT}/bin:${PATH}"

# Disable analytics and crash reporting on the builder.
RUN flutter config --no-analytics

# Perform an artifact precache so that no extra assets need to be downloaded on demand.
RUN flutter precache

# Accept licenses.
RUN yes "y" | flutter doctor --android-licenses

# Perform a doctor run.
RUN flutter doctor -v

# Switch to the correct channel
#ARG channel=stable
RUN if [ "${FLUTTER_VERSION}" = "latest" ] ; then flutter channel stable ; fi

RUN flutter --version

ENTRYPOINT [ "flutter" ]
