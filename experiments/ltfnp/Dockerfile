FROM fairlight1337/auto-experiment:latest
MAINTAINER Jan Winkler <winkler@cs.uni-bremen.de>

USER root
RUN rm /bin/sh && ln -sf /bin/bash /bin/sh
RUN DEBIAN_FRONTEND=noninteractive apt-get -qq install -y ros-indigo-gazebo-ros
USER experiment

RUN source ~/workspace/ros_top/devel/setup.bash && \
    cd ~/workspace/ros_lisp/src/cram_moveit && git checkout on-event && \
    cd ~/workspace/ros_top/src && \
    wstool set -y cram_beliefstate --git https://github.com/cram2/cram_beliefstate --version=metadata && \
    wstool set -y cram_gazebo --git https://github.com/cram2/cram_gazebo.git --version=scene-observation && \
    wstool set -y cram_perception --git https://github.com/cram2/cram_perception && \
    wstool update

USER root
RUN DEBIAN_FRONTEND=noninteractive apt-get -qq install -y x11-xserver-utils x11-apps Xvfb ros-indigo-pr2-gazebo
USER experiment

RUN source ~/workspace/ros_top/devel/setup.bash && \
    cd ~/workspace/ros_top/src && \
    wstool set -y longterm_fetch_and_place --git https://github.com/code-iai/longterm_fetch_and_place.git  && \
    wstool update

RUN source ~/workspace/ros_top/devel/setup.bash && \
    cd ~/workspace/ros_top && \
    catkin_make

ADD dummy.xorg.conf /
ADD init_wrapper.sh /

USER root
RUN sudo -E apt-get -y -qq install mesa-utils xserver-xorg-video-dummy xvfb

RUN export DISPLAY=:0 && \
    sudo -E Xorg -noreset +extension GLX +extension RANDR +extension RENDER -logfile /tmp/xorg.log -config /dummy.xorg.conf $DISPLAY & \
    sleep 3 && \
    DISPLAY=:0 glxinfo | grep GLX && \
    export QT_X11_NO_MITSHM=1 && \
    cd / && chmod 0777 init_wrapper.sh && sudo -H -u experiment ./init_wrapper.sh

RUN rm /tmp/.X0-lock

ADD start.sh /

ENTRYPOINT ["/bin/bash", "-c", "/start.sh ${*}", "--"]

EXPOSE 11311 11312
