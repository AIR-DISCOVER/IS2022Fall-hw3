cmake_minimum_required(VERSION 3.0.2)
project(cartographer_navigation)

add_compile_options(-std=c++11)

find_package(catkin REQUIRED COMPONENTS
  cartographer_ros
  cartographer_ros_msgs
  rospy
  std_msgs
  message_generation
)

find_package(cartographer)

add_service_files(
  FILES
  SetPath.srv
)

generate_messages(
  DEPENDENCIES
  std_msgs
)

catkin_package(
  CATKIN_DEPENDS  cartographer_ros_msgs cartographer_ros rospy std_msgs message_runtime
)

include_directories(
  ${catkin_INCLUDE_DIRS}
)


