FROM fairlight1337/auto-experiment:latest
MAINTAINER Jan Winkler <winkler@cs.uni-bremen.de>

USER root
RUN rm /bin/sh && ln -sf /bin/bash /bin/sh
RUN DEBIAN_FRONTEND=noninteractive apt-get -qq install -y ros-indigo-gazebo-ros
USER experiment

RUN source ~/workspace/ros_top/devel/setup.bash && \
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
    wstool set -y longterm_fetch_and_place --git https://github.com/code-iai/longterm_fetch_and_place.git --version=master && \
    wstool update

RUN source ~/workspace/ros_top/devel/setup.bash && \
    cd ~/workspace/ros_top && \
    catkin_make

RUN export DISPLAY=:0.0 && \
    Xvfb :0 -screen 0 1024x768x16 & \
    sleep 2 && \
    DISPLAY=:0.0 xhost + && \
    cd ~/workspace/ros_top/src/longterm_fetch_and_place/ltfnp_executive/scripts && \
    source ~/workspace/ros_top/devel/setup.bash && \
    DISPLAY=:0.0 ./init.sh

ADD start.sh /

RUN /bin/bash -c "/start.sh init"

ENTRYPOINT ["/bin/bash", "/start.sh"]
