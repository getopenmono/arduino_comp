FROM monolit/monofrm
MAINTAINER Kristoffer Andersen <ka@openmono.com>
ENV ARDUINO_URL "https://github.com/getopenmono/arduino_comp.git"
ENV ARDUINO_BRANCH master
ENV FRAMEWORK_BRANCH master
ENV MONOPROG_BRANCH master
CMD git clone -b $ARDUINO_BRANCH $ARDUINO_URL && cd arduino_comp && bash build_release.sh $RELEASE_VERSION $MONOPROG_RELEASE