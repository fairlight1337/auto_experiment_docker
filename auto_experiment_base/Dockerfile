FROM ros:indigo-robot
MAINTAINER Jan Winkler <winkler@cs.uni-bremen.de>

RUN apt-get -qq update
RUN DEBIAN_FRONTEND=noninteractive apt-get -qq install -y ros-indigo-roslisp-repl python-rosinstall python-wstool ros-indigo-catkin build-essential g++

RUN useradd -m -d /home/experiment -p experiment experiment && chsh -s /bin/bash experiment

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

ENV HOME /home/experiment
USER experiment

# rosdep is already initialized in the ros:indigo-robot base image
RUN rosdep update


RUN mkdir -p ~/workspace/ros_kb/src
RUN mkdir -p ~/workspace/ros_lisp/src
RUN mkdir -p ~/workspace/ros_top/src

RUN source /opt/ros/indigo/setup.bash && \
    cd ~/workspace/ros_kb/src && \
    wstool init && \
    cd .. && \
    catkin_make && \
    source ~/workspace/ros_kb/devel/setup.bash && \
    cd ~/workspace/ros_lisp/src && \
    wstool init && \
    cd .. && \
    catkin_make && \
    source ~/workspace/ros_lisp/devel/setup.bash && \
    cd ~/workspace/ros_top/src && \
    wstool init && \
    cd .. && \
    catkin_make

RUN echo "source ~/workspace/ros_top/devel/setup.bash" >> ~/.bashrc
RUN echo "export PATH=/opt/ros/indigo/bin:$PATH" >> ~/.bashrc

# Expose home
#VOLUME /home/experiment
