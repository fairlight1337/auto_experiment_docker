#!/bin/bash

source ~/workspace/ros_top/devel/setup.bash

sudo -E apt-get -y -qq install meta-utils xserver-xorg-video-dummy xvfb
export DISPLAY=:0
sudo -E Xorg -noreset +extension GLX +extension RANDR +extension RENDER -logfile /tmp/xorg.log -config dummy.xorg.conf $DISPLAY &
sleep 3
DISPLAY=:0 xhost +
glxinfo | grep GLX
export QT_X11_NO_MITSHM=1

echo "Arguments: $@"

ifconfig

export ROS_IP=`/sbin/ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'`
export ROS_HOSTNAME=${ROS_IP}
export ROS_MASTER_URI=http://${ROS_IP}:11311

#rosrun auto_experimenter entry_point.sh ltfnp_executive/assets/ltfnp_automation.yaml $@
DISPLAY=:0 rosrun auto_experimenter run.sh "--package ltfnp_executive/assets/ltfnp_automation.yaml" $@
#DISPLAY=:0.0 roslaunch ltfnp_executive ltfnp_simulation.launch
