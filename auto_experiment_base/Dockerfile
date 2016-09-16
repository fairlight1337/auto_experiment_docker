FROM ros:indigo-robot
MAINTAINER Jan Winkler <winkler@cs.uni-bremen.de>

RUN apt-get -qq update
RUN DEBIAN_FRONTEND=noninteractive apt-get -qq install -y ros-indigo-roslisp-repl python-rosinstall python-wstool ros-indigo-catkin build-essential g++
# ros-indigo-desktop

RUN useradd -m -d /home/experiment -p experiment experiment && chsh -s /bin/bash experiment

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

ENV HOME /home/experiment
USER experiment

# rosdep is already initialized in the ros:indigo-robot base image
RUN rosdep update


RUN mkdir -p ~/workspace/ros_kb/src
RUN /bin/bash -c "source /opt/ros/indigo/setup.bash; cd ~/workspace/ros_kb; catkin_make"

RUN mkdir -p ~/workspace/ros_lisp/src
RUN /bin/bash -c "source ~/workspace/ros_kb/devel/setup.bash; cd ~/workspace/ros_lisp; catkin_make"

RUN mkdir -p ~/workspace/ros_top/src
RUN /bin/bash -c "source ~/workspace/ros_lisp/devel/setup.bash; cd ~/workspace/ros_top; catkin_make"

RUN echo "source $HOME/workspace/ros_top/devel/setup.bash" >> ~/.bashrc

# Expose home
VOLUME /home/experiment
