FROM fairlight1337/auto-experiment-base:latest
MAINTAINER Jan Winkler <winkler@cs.uni-bremen.de>

USER root

RUN DEBIAN_FRONTEND=noninteractive apt-get -qq install -y ros-indigo-rosjava ros-indigo-data-vis-msgs ros-indigo-json-prolog-msgs swi-prolog swi-prolog-java libjson-glib-1.0-0 libjson-glib-1.0-common libjson-glib-dev ros-indigo-ivcon ros-indigo-map-server ros-indigo-pr2-mechanism-msgs ros-indigo-pr2-moveit-config ros-indigo-pr2-msgs libbullet-dev ros-indigo-move-base-msgs

RUN DEBIAN_FRONTEND=noninteractive apt-get -qq install -y ros-indigo-mjpeg-server ros-indigo-rosbridge-server

USER experiment
RUN rosdep update

RUN /bin/bash -c "cd ~/workspace/ros_kb/src && \
    wstool init && \
    wstool set -y stacks/knowrob --git https://github.com/knowrob/knowrob.git --version=robohow && \
    wstool set -y stacks/knowrob_addons --git https://github.com/knowrob/knowrob_addons.git --version=robohow && \
    wstool set -y iai_cad_tools --git https://github.com/code-iai/iai_cad_tools.git && \
    wstool set -y iai_common_msgs --git https://github.com/code-iai/iai_common_msgs.git && \
    wstool update && \
    source ~/workspace/ros_kb/devel/setup.bash && \
    rospack profile && \
    rosdep install --ignore-src --from-paths stacks/"

RUN /bin/bash -c "cd ~/workspace/ros_kb && \
    source ~/workspace/ros_kb/devel/setup.bash && \
    catkin_make"

RUN /bin/bash -c "cd ~/workspace/ros_lisp/src && \
    wstool init && \
    wstool merge https://raw.githubusercontent.com/cram2/cram_projection_demos/master/cram-with-projection.rosinstall && \
    wstool set -y cram_motion_manager --git https://github.com/mpomarlan/cram_motion_manager && \
    wstool set -y cram_moveit_manager --git https://github.com/mpomarlan/cram_moveit_manager && \
    wstool set -y cram_giskard_manager --git https://github.com/mpomarlan/cram_giskard_manager && \
    wstool set -y cl_giskard --git https://github.com/SemRoCo/cl_giskard && \
    wstool set -y giskard_msgs --git https://github.com/SemRoCo/giskard_msgs && \
    wstool set -y giskard --git https://github.com/SemRoCo/giskard && \
    wstool set -y qpoases --git https://github.com/SemRoCo/qpOASES && \
    wstool set -y expressiongraph --git https://github.com/SemRoCo/expressiongraph && \
    wstool update && \
    rosdep update"

USER root
RUN DEBIAN_FRONTEND=noninteractive apt-get -qq install -y ros-indigo-convex-decomposition ros-indigo-pr2-moveit-plugins
USER experiment

RUN /bin/bash -c "cd ~/workspace/ros_lisp && \
    rosdep install --ignore-src --from-paths src/"

RUN /bin/bash -c "cd ~/workspace/ros_lisp && \
    source ~/workspace/ros_lisp/devel/setup.bash && \
    catkin_make"
