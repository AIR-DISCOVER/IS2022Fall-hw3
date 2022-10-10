FROM ros:noetic-ros-core-focal as ROS

##########################################################################
FROM docker.discover-lab.com:55555/rmus-2022-fall/client-cpu

COPY --from=ROS /etc/apt /etc/apt
RUN sed -i "s@http://.*archive.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list && \
    sed -i "s@http://.*security.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list && \
    echo "deb https://mirrors.tuna.tsinghua.edu.cn/ros/ubuntu/ focal main" > /etc/apt/sources.list.d/ros1-latest.list && \
    apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654 && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    ros-noetic-map-server && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

RUN pip install -i https://pypi.tuna.tsinghua.edu.cn/simple gnupg pycryptodomex
RUN pip install -i https://pypi.tuna.tsinghua.edu.cn/simple evo --upgrade --no-binary evo

WORKDIR /opt
RUN rm -rf /opt/ep_ws/src/sim2real_ep/carto_navigation
ARG CACHE_DATE="tmp"
ADD cartographer_navigation /opt/ep_ws/src/sim2real_ep/carto_navigation
WORKDIR /opt/ep_ws
RUN rm build/CMakeCache.txt && /opt/workspace/devel_isolated/env.sh catkin_make