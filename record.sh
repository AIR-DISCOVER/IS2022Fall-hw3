#!/bin/bash -vx
echo "Start recording"
docker exec -it client \
    /opt/ep_ws/devel/env.sh \
    rm output*
docker exec -it client \
    /opt/ep_ws/devel/env.sh \
    rosbag record /odom_gt /ep/odom /tf -O output.bag --duration 15
echo "Stop recording"
docker exec -it client \
    /opt/ep_ws/devel/env.sh \
    evo_rpe bag output.bag /odom_gt /tf:map.base_link -av --t_max_diff 0.05 --plot --plot_mode xy