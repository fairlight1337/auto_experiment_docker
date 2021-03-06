FROM fairlight1337/auto-experiment-base:latest
MAINTAINER Jan Winkler <winkler@cs.uni-bremen.de>

USER root

RUN rm /bin/sh && ln -sf /bin/bash /bin/sh

ENV PATH /usr/local/nvidia/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}

RUN DEBIAN_FRONTEND=noninteractive apt-get -qq install -y ros-indigo-rosjava ros-indigo-data-vis-msgs ros-indigo-json-prolog-msgs swi-prolog swi-prolog-java libjson-glib-1.0-0 libjson-glib-1.0-common libjson-glib-dev ros-indigo-ivcon ros-indigo-map-server ros-indigo-pr2-mechanism-msgs ros-indigo-pr2-moveit-config ros-indigo-pr2-msgs libbullet-dev ros-indigo-move-base-msgs ros-indigo-moveit-full-pr2 libompl-dev libompl7

RUN DEBIAN_FRONTEND=noninteractive apt-get -qq install -y ros-indigo-mjpeg-server ros-indigo-rosbridge-server

ENV LD_LIBRARY_PATH /opt/ros/indigo/lib/x86_64-linux-gnu/:$LD_LIBRARY_PATH

USER experiment
RUN rosdep update

RUN source ~/workspace/ros_top/devel/setup.bash && \
    cd ~/workspace/ros_kb/src && \
    wstool set -y iai_cad_tools --git https://github.com/code-iai/iai_cad_tools.git && \
    wstool set -y iai_common_msgs --git https://github.com/code-iai/iai_common_msgs.git && \
    wstool update && \
    cd .. && \
    catkin_make

RUN source ~/workspace/ros_top/devel/setup.bash && \
    cd ~/workspace/ros_kb/src && \
    rospack profile && \
    wstool set -y stacks/knowrob --git https://github.com/knowrob/knowrob.git --version=master && \
    wstool set -y stacks/knowrob_addons --git https://github.com/knowrob/knowrob_addons.git --version=master && \
    wstool update

RUN source ~/workspace/ros_top/devel/setup.bash && \
    touch ~/workspace/ros_kb/src/stacks/knowrob/knowrob_vis/CATKIN_IGNORE && \
    touch ~/workspace/ros_kb/src/stacks/knowrob_addons/knowrob_meshes/CATKIN_IGNORE && \
    touch ~/workspace/ros_kb/src/stacks/knowrob_addons/knowrob_openease/CATKIN_IGNORE && \
    touch ~/workspace/ros_kb/src/stacks/knowrob_addons/knowrob_roslog_launch/CATKIN_IGNORE && \
    touch ~/workspace/ros_kb/src/stacks/knowrob_addons/knowrob_chemlab/CATKIN_IGNORE && \
    touch ~/workspace/ros_kb/src/stacks/knowrob_addons/knowrob_robcog/CATKIN_IGNORE && \
    touch ~/workspace/ros_kb/src/stacks/knowrob_addons/knowrob_sim_games/CATKIN_IGNORE

RUN source ~/workspace/ros_top/devel/setup.bash && \
    cd ~/workspace/ros_kb && \
    catkin_make -j1

RUN source ~/workspace/ros_top/devel/setup.bash && \
    cd ~/workspace/ros_lisp/src && \
    wstool merge https://raw.githubusercontent.com/cram2/cram_projection_demos/master/cram-with-projection.rosinstall && \
    wstool set -y cl_giskard --git https://github.com/SemRoCo/cl_giskard && \
    wstool set -y giskard_msgs --git https://github.com/SemRoCo/giskard_msgs && \
    wstool update && \
    cd ~/workspace/ros_top/src && \
    wstool set -y designator_integration --git https://github.com/code-iai/designator_integration.git && \
    wstool update

RUN source ~/workspace/ros_top/devel/setup.bash && \
    cd ~/workspace/ros_top && \
    catkin_make

USER root
RUN DEBIAN_FRONTEND=noninteractive apt-get -qq install -y ros-indigo-convex-decomposition ros-indigo-pr2-moveit-plugins libconfig++-dev libconfig++9
RUN DEBIAN_FRONTEND=noninteractive apt-get -qq install -y libgsl0-dev ros-indigo-household-objects-database-msgs
USER experiment

RUN source ~/workspace/ros_top/devel/setup.bash && \
    cd ~/workspace/ros_lisp && \
    catkin_make

USER root
RUN DEBIAN_FRONTEND=noninteractive apt-get -qq install -y ros-indigo-interactive-markers libncurses5-dev automake autoconf libconfig++8-dev libjson0-dev mongodb-dev mongodb-clients
USER experiment

RUN source ~/workspace/ros_top/devel/setup.bash && \
    cd ~/workspace/ros_top && \
    catkin_make --pkg designator_integration_cpp && \
    cd ~/workspace/ros_top/src && \
    rospack profile && \
    wstool set -y semrec --git https://github.com/code-iai/semrec.git && \
    wstool set -y sr_plugin_knowrob --git https://github.com/code-iai/sr_plugin_knowrob.git && \
    wstool set -y semrec_plugins --git https://github.com/code-iai/semrec_plugins.git && \
    wstool set -y mongodb_log --git https://github.com/code-iai/ros-mongodb_log && \
    wstool set -y nav_pcontroller --git https://github.com/code-iai/nav_pcontroller && \
    wstool set  -y auto_experimenter --git https://github.com/code-iai/auto_experimenter.git  --version=master    && \
    wstool update

RUN source ~/workspace/ros_top/devel/setup.bash && \
    cd ~/workspace/ros_top && \
    catkin_make


CMD ["echo", "Raw auto_experimenter base image. No functionality here."]
