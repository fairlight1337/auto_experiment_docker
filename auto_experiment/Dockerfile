FROM fairlight1337/auto-experiment-base:latest
MAINTAINER Jan Winkler <winkler@cs.uni-bremen.de>

RUN DEBIAN_FRONTEND=noninteractive apt-get -qq install -y ros-indigo-rosjava

USER experiment
RUN rosdep update

RUN cd ~/workspace/ros_kb/src
RUN wstool init
RUN wstool merge https://raw.github.com/knowrob/knowrob/master/rosinstall/knowrob-base.rosinstall
RUN wstool update
RUN rosdep install --ignore-src --from-paths stacks/
RUN cd ~/workspace/ros_kb
RUN catkin_make

RUN cd ~/workspace/ros_lisp/src
RUN wstool init
RUN wstool merge https://raw.githubusercontent.com/cram2/cram_projection_demos/master/cram-with-projection.rosinstall
RUN wstool update
RUN cd ~/workspace/ros_lisp
RUN rosdep update
RUN rosdep install --ignore-src --from-paths src/
RUN catkin_make

CMD ["echo", "Finished"]
