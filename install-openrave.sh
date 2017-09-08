#!/bin/bash
#
# Authors:
#   Francisco Suarez-Ruiz <fsuarez6.github.io>
#
# Description:
#   OpenRAVE Installation Script

echo ""
echo "#--------------------------------#"
echo "#  OpenRAVE Installation Script  #"
echo "#--------------------------------#"

# Install dependencies
echo ""
echo "Installing OpenRAVE dependencies..."
echo ""
echo "Requires root privileges:"
# Update
if [ $(lsb_release -sr) = '14.04' ]; then
  # ROS Indigo repository
  sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
  sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
  # Additional PPAs
  sudo apt-add-repository -y ppa:imnmfotmal/libccd
fi
sudo apt-get update
# Programs
sudo apt-get install -y --no-install-recommends build-essential cmake doxygen \
g++ git ipython octave python-dev python-h5py python-numpy python-pip         \
python-scipy
if [ $(lsb_release -sr) = '14.04' ]; then
  sudo apt-get install -y --no-install-recommends qt4-dev-tools zlib-bin
elif [ $(lsb_release -sr) = '16.04' ]; then
  sudo apt-get install -y --no-install-recommends qt5-default minizip
fi
# Libraries
sudo apt-get install -y --no-install-recommends ann-tools libann-dev          \
libassimp-dev libavcodec-dev libavformat-dev libboost-python-dev              \
libboost-all-dev libbullet-dev libccd libeigen3-dev libfaac-dev libflann-dev  \
libfreetype6-dev liblapack-dev libglew-dev libgsm1-dev libmpfi-dev            \
libmpfr-dev liboctave-dev libode-dev libogg-dev libpcre3-dev libqhull-dev     \
libsoqt-dev-common libsoqt4-dev libswscale-dev libtinyxml-dev libvorbis-dev   \
libx264-dev libxml2-dev libxvidcore-dev
if [ $(lsb_release -sr) = '14.04' ]; then
  # TODO: Install collada from ROS Indigo
  sudo apt-get install -y --no-install-recommends collada-dom-dev libpcrecpp0 \
  liblog4cxx10-dev libqt4-dev
elif [ $(lsb_release -sr) = '16.04' ]; then
  sudo apt-get install -y --no-install-recommends libccd-dev                  \
  libcollada-dom2.4-dp-dev liblog4cxx-dev libminizip-dev octomap-tools
fi

# OpenSceneGraph
echo ""
echo "Installing OpenSceneGraph 3.4 from source..."
echo ""
mkdir -p ~/git
cd ~/git
git clone https://github.com/openscenegraph/OpenSceneGraph.git
cd OpenSceneGraph; git reset --hard OpenSceneGraph-3.4
mkdir build; cd build
cmake .. -DDESIRED_QT_VERSION=4
make -j `nproc`
sudo make install

# FCL - The Flexible Collision Library
echo ""
echo "Installing FCL 0.5.0 from source..."
echo ""
cd ~/git
git clone https://github.com/flexible-collision-library/fcl
cd fcl; git reset --hard 0.5.0
mkdir build; cd build
cmake ..
make -j `nproc`
sudo make install

# Sympy version 0.7.1
echo ""
echo "Downgrading sympy to version 0.7.1..."
echo ""
pip install --upgrade --user sympy==0.7.1

# OpenRAVE
COMMIT=9350ebc
echo ""
echo "Installing OpenRAVE 0.9 from source (Commit $COMMIT)..."
echo ""
cd ~/git
git clone https://github.com/rdiankov/openrave.git
cd openrave; git reset --hard $COMMIT
mkdir build; cd build
cmake -DODE_USE_MULTITHREAD=ON -DOSG_DIR=/usr/local/lib64/ ..
make -j `nproc`
sudo make install
