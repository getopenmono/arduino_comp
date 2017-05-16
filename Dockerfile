FROM monolit/monofrm
MAINTAINER Kristoffer Andersen <ka@openmono.com>
ENV ARDUINO_URL "https://github.com/getopenmono/arduino_comp.git"
ENV MONOPROG_RELEASE 0.9.3
ENV MONOPROG_MAC_URL "https://github.com/getopenmono/arduino_comp/releases/download/1.6.1/monoprog0.9.3.tar.bz2"
ENV MONOPROG_WIN_URL "https://github.com/getopenmono/arduino_comp/releases/download/1.6.1/monoprog_win0.9.3.tar.bz2"
ENV ARDUINO_BRANCH master
ENV FRAMEWORK_BRANCH master
ENV MONOPROG_BRANCH master
CMD export PATH=$PATH:$HOME/gcc-arm-none-eabi-5_2-2015q4/bin && \
  git clone -b $ARDUINO_BRANCH $ARDUINO_URL && \
  cd arduino_comp && \
  bash build_release.sh $RELEASE_VERSION