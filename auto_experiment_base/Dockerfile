FROM ros:indigo-robot
MAINTAINER Jan Winkler <winkler@cs.uni-bremen.de>

RUN apt-get -qq update
RUN DEBIAN_FRONTEND=noninteractive apt-get -qq install -y ros-indigo-roslisp-repl python-rosinstall python-wstool ros-indigo-catkin # ros-indigo-desktop

RUN useradd -m -d /home/experiment -p experiment experiment && chsh -s /bin/bash experiment

ENV HOME /home/experiment
USER experiment

# rosdep is already initialized in the ros:indigo-robot base image
RUN rosdep update

RUN mkdir -p ~/workspace/ros_kb/src
RUN cd ~/workspace/ros_kb
RUN catkin_make
RUN source devel/setup.bash

RUN mkdir -p ~/workspace/ros_lisp/src
RUN cd ~/workspace/ros_lisp
RUN catkin_make
RUN source devel/setup.bash

RUN mkdir -p ~/workspace/ros_top/src
RUN cd ~/workspace/ros_top
RUN catkin_make
RUN source devel/setup.bash

echo "source $HOME/workspace/ros_top/devel/setup.bash" >> ~/.bashrc

# Expose home
VOLUME /home/experiment
