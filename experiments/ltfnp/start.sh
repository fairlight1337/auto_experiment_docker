#!/bin/bash

source ~/workspace/ros_top/devel/setup.bash

export DISPLAY 0.0
Xvfb :0 -screen 0 1024x768x16 &
sleep 2
DISPLAY=:0.0 xhost +

#rosrun auto_experimenter entry_point.sh ltfnp_executive/assets/ltfnp_automation.yaml $@
DISPLAY=:0.0 rosrun auto_experimenter run.sh "--package ltfnp_executive/assets/ltfnp_automation.yaml"
#DISPLAY=:0.0 roslaunch ltfnp_executive ltfnp_simulation.launch
